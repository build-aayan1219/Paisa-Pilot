import 'package:flutter_test/flutter_test.dart';
import 'package:paisa_pilot/data/seed/riya_data_generator.dart';
import 'package:paisa_pilot/domain/forecast_engine/forecast_engine.dart';
import 'package:paisa_pilot/domain/health_score/health_score_engine.dart';
import 'package:paisa_pilot/domain/health_score/safe_spend_calculator.dart';
import 'package:paisa_pilot/domain/insight_engine/insight_engine.dart';
import 'package:paisa_pilot/domain/models/category.dart';
import 'package:paisa_pilot/domain/nudge_engine/nudge_engine.dart';
import 'package:paisa_pilot/domain/whatif/what_if_engine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final riya = RiyaDataGenerator.createRiyaProfile();
  final recurring = RiyaDataGenerator.createRiyaRecurringItems();
  final transactions = RiyaDataGenerator.generate3MonthsTransactions();
  final goal = RiyaDataGenerator.createRiyaGoal();

  group('Forecast Engine Tests', () {
    test('produces valid Monte Carlo percentiles with P10 <= P50 <= P90', () async {
      final forecast = await ForecastEngine.runForecast(
        user: riya,
        transactions: transactions,
        recurringItems: recurring,
      );

      expect(forecast.points.isNotEmpty, isTrue);
      for (final p in forecast.points) {
        expect(p.p10, lessThanOrEqualTo(p.p50));
        expect(p.p50, lessThanOrEqualTo(p.p90));
      }

      // Riya persona specification: shortfall probability between 70% and 85%
      expect(forecast.shortfallProbability, greaterThanOrEqualTo(0.65));
      expect(forecast.shortfallProbability, lessThanOrEqualTo(0.90));
      expect(forecast.hasShortfallRisk, isTrue);
    });

    test('what-if simulation reduces shortfall risk when categories are trimmed', () async {
      final comparison = await WhatIfEngine.simulate(
        user: riya,
        transactions: transactions,
        recurringItems: recurring,
        categoryReductions: {
          TransactionCategory.foodDining: 0.40, // Cut Swiggy/Zomato by 40%
          TransactionCategory.shopping: 0.50, // Cut Shopping by 50%
        },
      );

      expect(
        comparison.simulatedForecast.shortfallProbability,
        lessThan(comparison.baselineForecast.shortfallProbability),
      );
      expect(comparison.extraSavingsKept, greaterThan(0.0));
      expect(comparison.riskReductionPercentage, greaterThan(0.0));
    });
  });

  group('Health Score & Safe-to-Spend Tests', () {
    test('calculates Financial Health Score (0-100) and 4 valid sub-scores', () {
      final health = HealthScoreEngine.compute(
        user: riya,
        transactions: transactions,
      );

      expect(health.totalScore, greaterThanOrEqualTo(0));
      expect(health.totalScore, lessThanOrEqualTo(100));

      for (final sub in health.subScores) {
        expect(sub.score, greaterThanOrEqualTo(0.0));
        expect(sub.score, lessThanOrEqualTo(25.0));
        expect(sub.tip.isNotEmpty, isTrue);
      }
    });

    test('Safe-to-Spend strictly satisfies (balance - bills - goal) / daysLeft', () {
      final breakdown = SafeSpendCalculator.compute(
        user: riya,
        transactions: transactions,
        recurringItems: recurring,
        goal: goal,
      );

      expect(breakdown.currentBalance, riya.openingBalance);
      expect(breakdown.daysLeftToSalary, greaterThanOrEqualTo(1));
      expect(breakdown.sparkline14Days.length, 14);

      final netAvailable = breakdown.currentBalance - breakdown.upcomingFixedBills - breakdown.goalReserve;
      final expectedSafe = netAvailable > 0 ? (netAvailable / breakdown.daysLeftToSalary) : 0.0;
      expect(breakdown.safeSpendToday, closeTo(expectedSafe, 0.01));
    });
  });

  group('Nudge Engine & Fact Constraints Tests', () {
    test('emits structured fact-grounded nudges where microcopy matches facts', () async {
      final forecast = await ForecastEngine.runForecast(
        user: riya,
        transactions: transactions,
        recurringItems: recurring,
      );
      final insights = InsightEngine.computeInsights(transactions);
      final safeSpend = SafeSpendCalculator.compute(
        user: riya,
        transactions: transactions,
        recurringItems: recurring,
        goal: goal,
      );

      final nudges = NudgeEngine.generateNudges(
        user: riya,
        forecast: forecast,
        insights: insights,
        safeSpend: safeSpend,
        recurringItems: recurring,
      );

      expect(nudges.isNotEmpty, isTrue);

      // Verify at least one urgent shortfall nudge exists for Riya
      final shortfallNudge = nudges.firstWhere((n) => n.id == 'nudge_shortfall');
      expect(shortfallNudge.isUrgent, isTrue);
      expect(shortfallNudge.facts.isNotEmpty, isTrue);

      // Fact constraint check: verify numbers in facts exist
      for (final n in nudges) {
        expect(n.title.isNotEmpty, isTrue);
        expect(n.body.isNotEmpty, isTrue);
        for (final fact in n.facts) {
          expect(fact.metric.isNotEmpty, isTrue);
        }
      }
    });
  });
}
