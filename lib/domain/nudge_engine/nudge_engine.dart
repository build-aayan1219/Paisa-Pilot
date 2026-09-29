import 'package:flutter/material.dart';
import '../../core/formatters/currency_formatter.dart';
import '../../core/formatters/date_formatter.dart';
import '../forecast_engine/forecast_models.dart';
import '../health_score/safe_spend_calculator.dart';
import '../insight_engine/insight_models.dart';
import '../models/nudge_item.dart';
import '../models/recurring_item.dart';
import '../models/user_profile.dart';

class NudgeEngine {
  NudgeEngine._();

  /// Generates structured facts and plain-language templates for the Coach section
  static List<NudgeItem> generateNudges({
    required UserProfile user,
    required ForecastResult forecast,
    required InsightSummary insights,
    required SafeSpendBreakdown safeSpend,
    required List<RecurringItem> recurringItems,
  }) {
    final nudges = <NudgeItem>[];
    final now = DateTime.now();

    // 1. Shortfall Risk Nudge (Urgent if prob >= 60%)
    if (forecast.shortfallProbability >= 0.30) {
      final deficit = (forecast.projectedMonthEndBalance < 0)
          ? forecast.projectedMonthEndBalance.abs()
          : 1800.0;
      final dateStr = forecast.runOutDate != null
          ? DateFormatter.formatShort(forecast.runOutDate!)
          : 'month-end';

      final facts = [
        NudgeFactData(metric: 'shortfall_probability', value: (forecast.shortfallProbability * 100).round(), unit: '%'),
        NudgeFactData(metric: 'projected_deficit', value: deficit.round(), unit: 'INR'),
        NudgeFactData(metric: 'days_left', value: safeSpend.daysLeftToSalary, unit: 'days'),
      ];

      nudges.add(NudgeItem(
        id: 'nudge_shortfall',
        userId: user.id,
        timestamp: now,
        type: NudgeType.shortfallRisk,
        title: 'Projected shortfall ahead',
        body: 'At your current pace, cash may run low around $dateStr. Trimming non-essential orders protects your balance.',
        impactChip: 'Preserve ${CurrencyFormatter.format(deficit)}',
        facts: facts,
        isUrgent: forecast.shortfallProbability >= 0.60,
        icon: Icons.warning_amber_rounded,
      ));
    }

    // 2. Subscription Leaks
    final leaks = recurringItems.where((r) => r.isLeak).toList();
    for (final leak in leaks) {
      final facts = [
        NudgeFactData(metric: 'leak_amount', value: leak.amount.round(), unit: 'INR'),
        NudgeFactData(metric: 'merchant', value: 0, metadata: {'name': leak.merchant}),
      ];

      nudges.add(NudgeItem(
        id: 'nudge_leak_${leak.id}',
        userId: user.id,
        timestamp: now,
        type: NudgeType.subscriptionLeak,
        title: 'Possible subscription leak',
        body: '${leak.merchant} auto-debited ${CurrencyFormatter.format(leak.amount)}. If you are no longer using this, cancel to keep cash.',
        impactChip: 'Save ${CurrencyFormatter.format(leak.amount)}/mo',
        facts: facts,
        isUrgent: false,
        icon: Icons.autorenew_rounded,
      ));
    }

    // 3. Weekend Spikes
    if (insights.weekendWeekdaySplit.weekendSharePercentage >= 40.0) {
      final weekendShare = insights.weekendWeekdaySplit.weekendSharePercentage.round();
      final potentialSavings = (insights.weekendWeekdaySplit.weekendDailyAvg * 0.25 * 4).round();

      final facts = [
        NudgeFactData(metric: 'weekend_share', value: weekendShare, unit: '%'),
        NudgeFactData(metric: 'potential_weekend_savings', value: potentialSavings, unit: 'INR'),
      ];

      nudges.add(NudgeItem(
        id: 'nudge_weekend',
        userId: user.id,
        timestamp: now,
        type: NudgeType.weekendSpike,
        title: 'Weekend spending spike',
        body: 'Weekends make up $weekendShare% of your monthly discretionary spend. Spreading treats smoothly prevents mid-week crunch.',
        impactChip: 'Save about ${CurrencyFormatter.format(potentialSavings)}',
        facts: facts,
        isUrgent: false,
        icon: Icons.celebration_rounded,
      ));
    }

    // 4. Safe-to-Spend Pacing Tip
    final safeDaily = safeSpend.safeSpendToday.round();
    final factsSafe = [
      NudgeFactData(metric: 'safe_to_spend_daily', value: safeDaily, unit: 'INR'),
      NudgeFactData(metric: 'days_left', value: safeSpend.daysLeftToSalary, unit: 'days'),
    ];

    nudges.add(NudgeItem(
      id: 'nudge_safespend',
      userId: user.id,
      timestamp: now,
      type: NudgeType.safeSpendTip,
      title: 'Safe daily spending limit',
      body: 'Spending under ${CurrencyFormatter.format(safeDaily)} per day keeps all fixed rent, bills, and emergency savings secure.',
      impactChip: '${CurrencyFormatter.format(safeDaily)} / day',
      facts: factsSafe,
      isUrgent: false,
      icon: Icons.shield_outlined,
    ));

    // 5. Category Surges (Top MoM increase)
    for (final delta in insights.categoryDeltas.take(2)) {
      if (delta.isIncrease && delta.deltaPercentage >= 25.0 && delta.deltaAmount >= 800) {
        final factsDelta = [
          NudgeFactData(metric: 'category_delta_pct', value: delta.deltaPercentage.round(), unit: '%'),
          NudgeFactData(metric: 'category_delta_amount', value: delta.deltaAmount.round(), unit: 'INR'),
        ];

        nudges.add(NudgeItem(
          id: 'nudge_surge_${delta.category.name}',
          userId: user.id,
          timestamp: now,
          type: NudgeType.categorySurge,
          title: '${delta.category.displayName} is up',
          body: 'Your spend on ${delta.category.displayName} increased by ${delta.deltaPercentage.round()}% this cycle compared to last month.',
          impactChip: 'Up by ${CurrencyFormatter.format(delta.deltaAmount)}',
          facts: factsDelta,
          isUrgent: false,
          icon: delta.category.icon,
        ));
      }
    }

    return nudges;
  }
}
