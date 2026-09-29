import 'dart:math';
import '../forecast_engine/forecast_engine.dart';
import '../forecast_engine/forecast_models.dart';
import '../models/category.dart';
import '../models/recurring_item.dart';
import '../models/transaction_item.dart';
import '../models/user_profile.dart';

class WhatIfComparison {
  final ForecastResult baselineForecast;
  final ForecastResult simulatedForecast;
  final double extraSavingsKept; // Amount kept by month-end
  final double riskReductionPercentage; // e.g. 78% -> 28% = 50% reduction
  final Map<TransactionCategory, double> categoryReductions;

  const WhatIfComparison({
    required this.baselineForecast,
    required this.simulatedForecast,
    required this.extraSavingsKept,
    required this.riskReductionPercentage,
    required this.categoryReductions,
  });
}

class WhatIfEngine {
  WhatIfEngine._();

  /// Computes simulated forecast by scaling historical discretionary spends according to slider cuts
  static Future<WhatIfComparison> simulate({
    required UserProfile user,
    required List<TransactionItem> transactions,
    required List<RecurringItem> recurringItems,
    required Map<TransactionCategory, double> categoryReductions, // e.g. {foodDining: 0.30, shopping: 0.20}
  }) async {
    // 1. Run baseline forecast
    final baseline = await ForecastEngine.runForecast(
      user: user,
      transactions: transactions,
      recurringItems: recurringItems,
      categoryReductionMultiplier: 1.0,
    );

    // 2. Compute weighted reduction multiplier across discretionary categories
    final discretionary = transactions.where((t) => t.isExpense && !t.isRecurring).toList();
    final totalDiscretionary = discretionary.fold<double>(0.0, (sum, t) => sum + t.amount);

    double weightedReduction = 0.0;
    if (totalDiscretionary > 0) {
      for (final entry in categoryReductions.entries) {
        final catSpend = discretionary
            .where((t) => t.category == entry.key)
            .fold<double>(0.0, (sum, t) => sum + t.amount);
        final catWeight = catSpend / totalDiscretionary;
        weightedReduction += (catWeight * entry.value);
      }
    }

    final reductionMultiplier = (1.0 - weightedReduction).clamp(0.0, 1.0);

    // 3. Run simulated forecast in isolate
    final simulated = await ForecastEngine.runForecast(
      user: user,
      transactions: transactions,
      recurringItems: recurringItems,
      categoryReductionMultiplier: reductionMultiplier,
    );

    // 4. Calculate savings kept and risk reduction
    final extraSavings = max(0.0, simulated.projectedMonthEndBalance - baseline.projectedMonthEndBalance);
    final riskReduction = max(0.0, (baseline.shortfallProbability - simulated.shortfallProbability) * 100.0);

    return WhatIfComparison(
      baselineForecast: baseline,
      simulatedForecast: simulated,
      extraSavingsKept: extraSavings,
      riskReductionPercentage: riskReduction,
      categoryReductions: categoryReductions,
    );
  }
}
