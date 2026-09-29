import 'package:equatable/equatable.dart';
import '../models/category.dart';
import '../models/transaction_item.dart';

class CategoryMoMDelta extends Equatable {
  final TransactionCategory category;
  final double currentSpend;
  final double previousSpend;
  final double deltaAmount;
  final double deltaPercentage; // e.g. +35.2% or -12.4%

  const CategoryMoMDelta({
    required this.category,
    required this.currentSpend,
    required this.previousSpend,
    required this.deltaAmount,
    required this.deltaPercentage,
  });

  bool get isIncrease => deltaAmount > 0;

  @override
  List<Object?> get props => [
        category,
        currentSpend,
        previousSpend,
        deltaAmount,
        deltaPercentage,
      ];
}

class WeekendWeekdaySplit extends Equatable {
  final double weekdayTotal;
  final double weekendTotal;
  final double weekdayDailyAvg;
  final double weekendDailyAvg;
  final double weekendSharePercentage; // e.g. 48.5%
  final double weekdaySharePercentage;

  const WeekendWeekdaySplit({
    required this.weekdayTotal,
    required this.weekendTotal,
    required this.weekdayDailyAvg,
    required this.weekendDailyAvg,
    required this.weekendSharePercentage,
    required this.weekdaySharePercentage,
  });

  @override
  List<Object?> get props => [
        weekdayTotal,
        weekendTotal,
        weekdayDailyAvg,
        weekendDailyAvg,
        weekendSharePercentage,
        weekdaySharePercentage,
      ];
}

class AnomalyFlag extends Equatable {
  final TransactionItem transaction;
  final double zScore;
  final double categoryMean;
  final String reason;

  const AnomalyFlag({
    required this.transaction,
    required this.zScore,
    required this.categoryMean,
    required this.reason,
  });

  @override
  List<Object?> get props => [transaction, zScore, categoryMean, reason];
}

class InsightSummary extends Equatable {
  final List<CategoryMoMDelta> categoryDeltas;
  final WeekendWeekdaySplit weekendWeekdaySplit;
  final List<AnomalyFlag> anomalies;
  final double totalMonthlySpend;
  final double totalMonthlyIncome;
  final double averageDailySpend;

  const InsightSummary({
    required this.categoryDeltas,
    required this.weekendWeekdaySplit,
    required this.anomalies,
    required this.totalMonthlySpend,
    required this.totalMonthlyIncome,
    required this.averageDailySpend,
  });

  @override
  List<Object?> get props => [
        categoryDeltas,
        weekendWeekdaySplit,
        anomalies,
        totalMonthlySpend,
        totalMonthlyIncome,
        averageDailySpend,
      ];
}
