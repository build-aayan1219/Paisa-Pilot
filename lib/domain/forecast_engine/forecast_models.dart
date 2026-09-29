import 'package:equatable/equatable.dart';

class DailyBalancePoint extends Equatable {
  final int dayOffset;
  final DateTime date;
  final double? actualBalance; // If day is in past or today
  final double p10; // 10th percentile (conservative / pessimistic)
  final double p50; // Median projection
  final double p90; // 90th percentile (optimistic)

  const DailyBalancePoint({
    required this.dayOffset,
    required this.date,
    this.actualBalance,
    required this.p10,
    required this.p50,
    required this.p90,
  });

  @override
  List<Object?> get props => [dayOffset, date, actualBalance, p10, p50, p90];
}

class ForecastResult extends Equatable {
  final List<DailyBalancePoint> points;
  final double shortfallProbability; // 0.0 - 1.0 (e.g. 0.78 = 78%)
  final double projectedMonthEndBalance; // P50 at end of cycle
  final DateTime? runOutDate; // Date when P50 drops <= 0
  final double meanDailySpend;
  final double stdDevDailySpend;
  final bool isColdStart;

  const ForecastResult({
    required this.points,
    required this.shortfallProbability,
    required this.projectedMonthEndBalance,
    this.runOutDate,
    required this.meanDailySpend,
    required this.stdDevDailySpend,
    this.isColdStart = false,
  });

  bool get hasShortfallRisk => shortfallProbability >= 0.30;
  bool get hasCriticalShortfallRisk => shortfallProbability >= 0.60;

  @override
  List<Object?> get props => [
        points,
        shortfallProbability,
        projectedMonthEndBalance,
        runOutDate,
        meanDailySpend,
        stdDevDailySpend,
        isColdStart,
      ];
}

class ForecastParams {
  final double openingBalance;
  final int daysLeftToSalary;
  final List<double> historicalDailySpends;
  final Map<int, double> upcomingBillsByDayOffset; // dayOffset -> billAmount
  final double categoryReductionFactor; // 0.0 - 1.0 (from what-if)
  final double monthlyIncome;
  final int incomeCycleDay;
  final bool isColdStart;
  final DateTime startDate;

  ForecastParams({
    required this.openingBalance,
    required this.daysLeftToSalary,
    required this.historicalDailySpends,
    required this.upcomingBillsByDayOffset,
    this.categoryReductionFactor = 1.0,
    required this.monthlyIncome,
    required this.incomeCycleDay,
    this.isColdStart = false,
    required this.startDate,
  });
}
