import 'dart:math';
import '../models/category.dart';
import '../models/transaction_item.dart';
import 'insight_models.dart';

class InsightEngine {
  InsightEngine._();

  static InsightSummary computeInsights(List<TransactionItem> allTransactions) {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final sixtyDaysAgo = now.subtract(const Duration(days: 60));

    // Current 30 days transactions vs previous 30 days
    final currentPeriod = allTransactions.where((t) => t.date.isAfter(thirtyDaysAgo)).toList();
    final previousPeriod = allTransactions
        .where((t) => t.date.isAfter(sixtyDaysAgo) && t.date.isBefore(thirtyDaysAgo))
        .toList();

    // 1. Month-over-Month Category Deltas
    final currentCatTotals = <TransactionCategory, double>{};
    final previousCatTotals = <TransactionCategory, double>{};

    for (final t in currentPeriod) {
      if (t.isExpense) {
        currentCatTotals[t.category] = (currentCatTotals[t.category] ?? 0.0) + t.amount;
      }
    }

    for (final t in previousPeriod) {
      if (t.isExpense) {
        previousCatTotals[t.category] = (previousCatTotals[t.category] ?? 0.0) + t.amount;
      }
    }

    final categoryDeltas = <CategoryMoMDelta>[];
    final allCategories = {...currentCatTotals.keys, ...previousCatTotals.keys};

    for (final cat in allCategories) {
      final current = currentCatTotals[cat] ?? 0.0;
      final previous = previousCatTotals[cat] ?? 0.0;
      final deltaAmt = current - previous;
      final deltaPct = previous > 0
          ? ((deltaAmt / previous) * 100.0)
          : (current > 0 ? 100.0 : 0.0);

      categoryDeltas.add(CategoryMoMDelta(
        category: cat,
        currentSpend: current,
        previousSpend: previous,
        deltaAmount: deltaAmt,
        deltaPercentage: deltaPct,
      ));
    }

    // Sort by largest spend descending
    categoryDeltas.sort((a, b) => b.currentSpend.compareTo(a.currentSpend));

    // 2. Weekend vs Weekday Split
    double weekdayTotal = 0.0;
    double weekendTotal = 0.0;
    int weekdayDays = 0;
    int weekendDays = 0;

    final expenses = currentPeriod.where((t) => t.isExpense).toList();
    final dayBuckets = <String, double>{};

    for (final t in expenses) {
      final dayKey = '${t.date.year}-${t.date.month}-${t.date.day}';
      dayBuckets[dayKey] = (dayBuckets[dayKey] ?? 0.0) + t.amount;
    }

    for (int i = 0; i < 30; i++) {
      final d = now.subtract(Duration(days: i));
      final dayKey = '${d.year}-${d.month}-${d.day}';
      final spend = dayBuckets[dayKey] ?? 0.0;
      final isWeekend = d.weekday == DateTime.saturday || d.weekday == DateTime.sunday;

      if (isWeekend) {
        weekendTotal += spend;
        weekendDays++;
      } else {
        weekdayTotal += spend;
        weekdayDays++;
      }
    }

    final totalDiscretionary = weekdayTotal + weekendTotal;
    final weekendDailyAvg = weekendDays > 0 ? (weekendTotal / weekendDays) : 0.0;
    final weekdayDailyAvg = weekdayDays > 0 ? (weekdayTotal / weekdayDays) : 0.0;
    final weekendShare = totalDiscretionary > 0 ? ((weekendTotal / totalDiscretionary) * 100.0) : 0.0;
    final weekdayShare = totalDiscretionary > 0 ? ((weekdayTotal / totalDiscretionary) * 100.0) : 0.0;

    final weekendWeekdaySplit = WeekendWeekdaySplit(
      weekdayTotal: weekdayTotal,
      weekendTotal: weekendTotal,
      weekdayDailyAvg: weekdayDailyAvg,
      weekendDailyAvg: weekendDailyAvg,
      weekendSharePercentage: weekendShare,
      weekdaySharePercentage: weekdayShare,
    );

    // 3. Z-score Anomaly Detection (outliers with z >= 2.5)
    final anomalies = <AnomalyFlag>[];
    final allExpenses = allTransactions.where((t) => t.isExpense).toList();

    if (allExpenses.length >= 10) {
      // Group expenses by category
      final categoryExpenses = <TransactionCategory, List<double>>{};
      for (final t in allExpenses) {
        categoryExpenses.putIfAbsent(t.category, () => []).add(t.amount);
      }

      for (final t in allExpenses) {
        final amounts = categoryExpenses[t.category] ?? [];
        if (amounts.length >= 5) {
          final mean = amounts.reduce((a, b) => a + b) / amounts.length;
          final variance = amounts.map((x) => pow(x - mean, 2)).reduce((a, b) => a + b) / amounts.length;
          final stdDev = sqrt(variance);

          if (stdDev > 0) {
            final z = (t.amount - mean) / stdDev;
            if (z >= 2.5 && t.amount >= 2000.0) {
              final ratio = (t.amount / mean).toStringAsFixed(1);
              anomalies.add(AnomalyFlag(
                transaction: t,
                zScore: z,
                categoryMean: mean,
                reason: 'Spending ₹${t.amount.toStringAsFixed(0)} is ${ratio}x higher than typical ${t.category.displayName} (avg ₹${mean.toStringAsFixed(0)})',
              ));
            }
          }
        }
      }
    }

    // Totals
    final totalMonthlySpend = expenses.fold<double>(0.0, (sum, t) => sum + t.amount);
    final totalMonthlyIncome = currentPeriod
        .where((t) => t.isIncome)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
    final avgDailySpend = totalMonthlySpend / 30.0;

    return InsightSummary(
      categoryDeltas: categoryDeltas,
      weekendWeekdaySplit: weekendWeekdaySplit,
      anomalies: anomalies,
      totalMonthlySpend: totalMonthlySpend,
      totalMonthlyIncome: totalMonthlyIncome,
      averageDailySpend: avgDailySpend,
    );
  }
}
