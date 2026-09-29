import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/recurring_item.dart';
import '../models/transaction_item.dart';
import '../models/user_profile.dart';
import 'forecast_models.dart';

/// Top-level function for compute() isolate execution
ForecastResult _runMonteCarloSimulation(ForecastParams params) {
  const int numPaths = 1000;
  final random = Random(1337);
  final days = max(1, params.daysLeftToSalary);

  // 1. Establish daily spend distribution parameters
  List<double> spends = List<double>.from(params.historicalDailySpends);

  if (params.isColdStart || spends.isEmpty) {
    // 50/30/20 Rule: 30% discretionary wants -> daily baseline
    final dailyDiscretionary = (params.monthlyIncome * 0.30) / 30.0;
    spends = List.generate(30, (i) {
      final variation = (random.nextDouble() - 0.5) * 0.4; // +/- 20%
      return max(100.0, dailyDiscretionary * (1.0 + variation));
    });
  }

  // Calculate mean and standard deviation
  final meanSpend = spends.reduce((a, b) => a + b) / spends.length;
  final variance = spends.map((x) => pow(x - meanSpend, 2)).reduce((a, b) => a + b) / spends.length;
  final stdDev = sqrt(variance);

  // 2. Matrix of balances: [pathIndex][dayIndex]
  final pathBalances = List.generate(numPaths, (_) => List<double>.filled(days + 1, 0.0));
  int shortfallPathsCount = 0;

  for (int p = 0; p < numPaths; p++) {
    double currentBalance = params.openingBalance;
    pathBalances[p][0] = currentBalance;
    bool hasDippedBelowZero = currentBalance <= 0;

    for (int d = 1; d <= days; d++) {
      final targetDate = params.startDate.add(Duration(days: d));

      // Salary is credited on the next salary date (day == days)
      if (d == days) {
        currentBalance += params.monthlyIncome;
      }

      // Sample daily spend using bootstrap + Box-Muller normal perturbation
      final sampledIndex = random.nextInt(spends.length);
      double sampledSpend = spends[sampledIndex];

      // Add small Gaussian perturbation
      final u1 = random.nextDouble().clamp(1e-6, 1.0);
      final u2 = random.nextDouble().clamp(1e-6, 1.0);
      final z = sqrt(-2.0 * log(u1)) * cos(2.0 * pi * u2);
      sampledSpend = sampledSpend + (z * stdDev * 0.25);

      // Apply what-if category reduction factor
      sampledSpend = max(0.0, sampledSpend * params.categoryReductionFactor);

      // Add fixed bills due on this day
      final bill = params.upcomingBillsByDayOffset[d] ?? 0.0;

      currentBalance -= (sampledSpend + bill);
      pathBalances[p][d] = currentBalance;

      // Check if cash ran dry during the cycle
      if (currentBalance <= 0) {
        hasDippedBelowZero = true;
      }
    }

    // A shortfall occurs if cash dipped below zero before salary OR month-end closing balance is under target buffer
    if (hasDippedBelowZero && pathBalances[p].last < (params.monthlyIncome * 0.10)) {
      shortfallPathsCount++;
    } else if (pathBalances[p].last <= 0) {
      shortfallPathsCount++;
    }
  }

  // 3. Compute P10, P50, P90 points for each day
  final points = <DailyBalancePoint>[];
  DateTime? runOutDate;

  for (int d = 0; d <= days; d++) {
    final dailyValues = List<double>.generate(numPaths, (p) => pathBalances[p][d]);
    dailyValues.sort();

    final p10 = dailyValues[(numPaths * 0.10).toInt()];
    final p50 = dailyValues[(numPaths * 0.50).toInt()];
    final p90 = dailyValues[(numPaths * 0.90).toInt()];

    final pointDate = params.startDate.add(Duration(days: d));

    if (d > 0 && p50 <= 0 && runOutDate == null) {
      runOutDate = pointDate;
    }

    points.add(DailyBalancePoint(
      dayOffset: d,
      date: pointDate,
      actualBalance: d == 0 ? params.openingBalance : null,
      p10: p10,
      p50: p50,
      p90: p90,
    ));
  }

  final shortfallProb = (shortfallPathsCount / numPaths).clamp(0.0, 1.0);
  final monthEndBalance = points.last.p50;

  return ForecastResult(
    points: points,
    shortfallProbability: shortfallProb,
    projectedMonthEndBalance: monthEndBalance,
    runOutDate: shortfallProb >= 0.30 ? runOutDate : null,
    meanDailySpend: meanSpend,
    stdDevDailySpend: stdDev,
    isColdStart: params.isColdStart,
  );
}

class ForecastEngine {
  ForecastEngine._();

  /// Runs 1,000 Monte Carlo paths asynchronously inside a Dart Isolate via compute()
  static Future<ForecastResult> runForecast({
    required UserProfile user,
    required List<TransactionItem> transactions,
    required List<RecurringItem> recurringItems,
    double categoryReductionMultiplier = 1.0,
    bool isNext30Days = true,
    int? forecastDays,
    DateTime? currentDate,
  }) async {
    final now = currentDate ?? DateTime.now();

    // 1. Calculate forecast horizon (default to 14 days or next salary cycle)
    int daysLeft = forecastDays ??
        (isNext30Days ? 14 : _calculateDaysToSalary(now, user.incomeCycleDay));
    if (daysLeft < 5) {
      daysLeft = 14; // Look ahead 14 days to upcoming salary date
    }

    // 2. Map upcoming recurring bills by day offset (matching day of month)
    final upcomingBillsMap = <int, double>{};
    for (int d = 1; d <= daysLeft; d++) {
      final targetDay = now.add(Duration(days: d));
      final billsOnDay = recurringItems.where((b) {
        return b.nextDue.day == targetDay.day;
      }).fold<double>(0.0, (sum, b) => sum + b.amount);

      if (billsOnDay > 0) {
        upcomingBillsMap[d] = billsOnDay;
      }
    }

    // 3. Extract historical daily discretionary spend
    final dailySpends = <double>[];
    final ninetyDaysAgo = now.subtract(const Duration(days: 90));
    final discretionary = transactions.where((t) =>
        t.isExpense && !t.isRecurring && t.date.isAfter(ninetyDaysAgo));

    final dayBuckets = <String, double>{};
    for (final t in discretionary) {
      final key = '${t.date.year}-${t.date.month}-${t.date.day}';
      dayBuckets[key] = (dayBuckets[key] ?? 0.0) + t.amount;
    }

    dailySpends.addAll(dayBuckets.values);
    final isColdStart = dailySpends.length < 15;

    final params = ForecastParams(
      openingBalance: user.openingBalance,
      daysLeftToSalary: daysLeft,
      historicalDailySpends: dailySpends,
      upcomingBillsByDayOffset: upcomingBillsMap,
      categoryReductionFactor: categoryReductionMultiplier,
      monthlyIncome: user.monthlyIncome,
      incomeCycleDay: user.incomeCycleDay,
      isColdStart: isColdStart,
      startDate: now,
    );

    // Run Monte Carlo in Dart background isolate
    return compute(_runMonteCarloSimulation, params);
  }

  static int _calculateDaysToSalary(DateTime now, int salaryDay) {
    DateTime nextSalary;
    if (now.day < salaryDay) {
      nextSalary = DateTime(now.year, now.month, salaryDay);
    } else {
      final nextMonth = DateTime(now.year, now.month + 1, 1);
      final daysInNextMonth = DateTime(nextMonth.year, nextMonth.month + 1, 0).day;
      final targetDay = min(salaryDay, daysInNextMonth);
      nextSalary = DateTime(nextMonth.year, nextMonth.month, targetDay);
    }

    final diff = nextSalary.difference(now).inDays;
    return max(1, diff);
  }
}
