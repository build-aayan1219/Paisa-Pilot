import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/tokens/app_colors.dart';
import '../models/transaction_item.dart';
import '../models/user_profile.dart';

enum HealthScoreRating {
  needsAttention('Needs attention', AppColors.rose),
  fair('Fair', AppColors.amber),
  good('Good', AppColors.sky),
  excellent('Excellent', AppColors.emerald);

  final String label;
  final Color color;
  const HealthScoreRating(this.label, this.color);
}

class HealthSubScore {
  final String title;
  final double score; // 0 - 25
  final double maxScore; // 25
  final String tip;

  const HealthSubScore({
    required this.title,
    required this.score,
    this.maxScore = 25.0,
    required this.tip,
  });

  double get ratio => (score / maxScore).clamp(0.0, 1.0);
}

class HealthScoreResult {
  final int totalScore; // 0 - 100
  final HealthScoreRating rating;
  final HealthSubScore savingsRateScore;
  final HealthSubScore spendStabilityScore;
  final HealthSubScore billRegularityScore;
  final HealthSubScore bufferDaysScore;

  const HealthScoreResult({
    required this.totalScore,
    required this.rating,
    required this.savingsRateScore,
    required this.spendStabilityScore,
    required this.billRegularityScore,
    required this.bufferDaysScore,
  });

  List<HealthSubScore> get subScores => [
        savingsRateScore,
        spendStabilityScore,
        billRegularityScore,
        bufferDaysScore,
      ];
}

class HealthScoreEngine {
  HealthScoreEngine._();

  static HealthScoreResult compute({
    required UserProfile user,
    required List<TransactionItem> transactions,
  }) {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final recent = transactions.where((t) => t.date.isAfter(thirtyDaysAgo)).toList();

    final income = recent
        .where((t) => t.isIncome)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
    final effectiveIncome = income > 0 ? income : user.monthlyIncome;

    final expenses = recent
        .where((t) => t.isExpense)
        .fold<double>(0.0, (sum, t) => sum + t.amount);

    // 1. Savings Rate Sub-score (0-25)
    final netSavings = effectiveIncome - expenses;
    final savingsRate = effectiveIncome > 0 ? (netSavings / effectiveIncome) : 0.0;
    double savingsScore = 0.0;
    String savingsTip = '';

    if (savingsRate >= 0.20) {
      savingsScore = 25.0;
      savingsTip = 'Outstanding! You are saving over 20% of your earnings.';
    } else if (savingsRate >= 0.10) {
      savingsScore = 15.0 + ((savingsRate - 0.10) / 0.10) * 10.0;
      savingsTip = 'Good savings habit. Strive to nudge it closer to 20%.';
    } else if (savingsRate > 0) {
      savingsScore = 5.0 + (savingsRate / 0.10) * 10.0;
      savingsTip = 'Tight savings margin. Trimming small food orders will help.';
    } else {
      savingsScore = max(0.0, 5.0 + (savingsRate * 10.0));
      savingsTip = 'Spending is outpacing income this cycle. Cut discretionary spend.';
    }

    // 2. Spend Stability Sub-score (0-25)
    // Low coefficient of variation (stdDev / mean) = consistent, high = erratic
    final dailyBuckets = List.filled(30, 0.0);
    for (final t in recent.where((t) => t.isExpense && !t.isRecurring)) {
      final dayDiff = now.difference(t.date).inDays.clamp(0, 29);
      dailyBuckets[dayDiff] += t.amount;
    }

    final avgDaily = dailyBuckets.reduce((a, b) => a + b) / 30.0;
    double stabilityScore = 18.0;
    String stabilityTip = 'Spending is moderately consistent with minor spikes.';

    if (avgDaily > 0) {
      final variance = dailyBuckets.map((d) => pow(d - avgDaily, 2)).reduce((a, b) => a + b) / 30.0;
      final cv = sqrt(variance) / avgDaily; // Coefficient of variation

      if (cv < 0.6) {
        stabilityScore = 25.0;
        stabilityTip = 'Very stable daily spending without major erratic bursts.';
      } else if (cv < 1.0) {
        stabilityScore = 18.0;
        stabilityTip = 'Occasional weekend spikes. Keep an eye on impulsive buys.';
      } else {
        stabilityScore = 10.0;
        stabilityTip = 'High spend volatility on weekends. Pace your daily budget.';
      }
    }

    // 3. Bill Regularity Sub-score (0-25)
    // Checks recurring bills paid consistently
    final recurringTxns = recent.where((t) => t.isRecurring).toList();
    double billScore = 22.0;
    String billTip = 'Fixed commitments and rent paid on schedule.';
    if (recurringTxns.isEmpty) {
      billScore = 18.0;
      billTip = 'Few fixed obligations detected.';
    } else if (recurringTxns.length >= 3) {
      billScore = 25.0;
      billTip = 'All core bills, rent and subscriptions handled timely.';
    }

    // 4. Buffer Days Sub-score (0-25)
    // Days current balance can sustain expenses: openingBalance / avgDaily
    final dailyExpenseAvg = expenses > 0 ? (expenses / 30.0) : 600.0;
    final bufferDays = user.openingBalance / dailyExpenseAvg;
    double bufferScore = 0.0;
    String bufferTip = '';

    if (bufferDays >= 20) {
      bufferScore = 25.0;
      bufferTip = 'Strong cash cushion. Balance covers 20+ days of spending.';
    } else if (bufferDays >= 10) {
      bufferScore = 15.0 + ((bufferDays - 10) / 10.0) * 10.0;
      bufferTip = 'Adequate cash buffer covering about ${bufferDays.toInt()} days.';
    } else if (bufferDays >= 5) {
      bufferScore = 8.0 + ((bufferDays - 5) / 5.0) * 7.0;
      bufferTip = 'Low cash buffer (${bufferDays.toInt()} days left). Watch out for shortfall.';
    } else {
      bufferScore = max(2.0, bufferDays * 1.5);
      bufferTip = 'Critical cash buffer (under 5 days remaining before salary).';
    }

    final total = (savingsScore + stabilityScore + billScore + bufferScore).round().clamp(0, 100);

    HealthScoreRating rating;
    if (total >= 80) {
      rating = HealthScoreRating.excellent;
    } else if (total >= 65) {
      rating = HealthScoreRating.good;
    } else if (total >= 45) {
      rating = HealthScoreRating.fair;
    } else {
      rating = HealthScoreRating.needsAttention;
    }

    return HealthScoreResult(
      totalScore: total,
      rating: rating,
      savingsRateScore: HealthSubScore(
        title: 'Savings Rate',
        score: savingsScore.clamp(0.0, 25.0),
        tip: savingsTip,
      ),
      spendStabilityScore: HealthSubScore(
        title: 'Spend Stability',
        score: stabilityScore.clamp(0.0, 25.0),
        tip: stabilityTip,
      ),
      billRegularityScore: HealthSubScore(
        title: 'Bill Regularity',
        score: billScore.clamp(0.0, 25.0),
        tip: billTip,
      ),
      bufferDaysScore: HealthSubScore(
        title: 'Buffer Days',
        score: bufferScore.clamp(0.0, 25.0),
        tip: bufferTip,
      ),
    );
  }
}
