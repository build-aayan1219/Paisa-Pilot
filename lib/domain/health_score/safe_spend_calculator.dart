import 'dart:math';
import '../models/recurring_item.dart';
import '../models/savings_goal.dart';
import '../models/transaction_item.dart';
import '../models/user_profile.dart';

class SafeSpendBreakdown {
  final double currentBalance;
  final double upcomingFixedBills;
  final double goalReserve;
  final int daysLeftToSalary;
  final double safeSpendToday;
  final List<RecurringItem> upcomingBillsList;
  final List<double> sparkline14Days; // 14-day daily spend values for sparkline
  final double averageDailySpend;

  const SafeSpendBreakdown({
    required this.currentBalance,
    required this.upcomingFixedBills,
    required this.goalReserve,
    required this.daysLeftToSalary,
    required this.safeSpendToday,
    required this.upcomingBillsList,
    required this.sparkline14Days,
    required this.averageDailySpend,
  });
}

class SafeSpendCalculator {
  SafeSpendCalculator._();

  static SafeSpendBreakdown compute({
    required UserProfile user,
    required List<TransactionItem> transactions,
    required List<RecurringItem> recurringItems,
    SavingsGoal? goal,
  }) {
    final now = DateTime.now();

    // 1. Calculate days left to next salary day
    int daysLeft = _calculateDaysToSalary(now, user.incomeCycleDay);
    if (daysLeft < 1) daysLeft = 1;

    // 2. Identify upcoming fixed bills before next salary day
    final nextSalaryDate = now.add(Duration(days: daysLeft));
    final upcomingBills = recurringItems.where((b) {
      return b.nextDue.isAfter(now.subtract(const Duration(hours: 12))) &&
          b.nextDue.isBefore(nextSalaryDate);
    }).toList();

    final upcomingBillsTotal =
        upcomingBills.fold<double>(0.0, (sum, b) => sum + b.amount);

    // 3. Goal reserve allocated for this cycle
    double goalReserve = 0.0;
    if (goal != null && goal.targetAmount > goal.savedAmount) {
      // Monthly goal portion: (remaining / remainingMonths) or conservative 10% of income
      final monthsRemaining = max(1.0, goal.daysRemaining / 30.0);
      goalReserve = min(user.monthlyIncome * 0.15, goal.remainingAmount / monthsRemaining);
    }

    // 4. Safe-to-Spend Today formula
    // (balance - upcoming fixed bills - goal reserve) / days left to salary
    final netAvailable = user.openingBalance - upcomingBillsTotal - goalReserve;
    final safeSpendToday = max(0.0, netAvailable / daysLeft);

    // 5. 14-day spend history for the hero card sparkline
    final sparkline = List.filled(14, 0.0);
    for (final t in transactions.where((t) => t.isExpense && !t.isRecurring)) {
      final daysAgo = now.difference(t.date).inDays;
      if (daysAgo >= 0 && daysAgo < 14) {
        sparkline[13 - daysAgo] += t.amount;
      }
    }

    // 6. Average daily spend over past 30 days
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final recentExpenses = transactions
        .where((t) => t.isExpense && t.date.isAfter(thirtyDaysAgo))
        .fold<double>(0.0, (sum, t) => sum + t.amount);
    final avgDaily = recentExpenses / 30.0;

    return SafeSpendBreakdown(
      currentBalance: user.openingBalance,
      upcomingFixedBills: upcomingBillsTotal,
      goalReserve: goalReserve,
      daysLeftToSalary: daysLeft,
      safeSpendToday: safeSpendToday,
      upcomingBillsList: upcomingBills,
      sparkline14Days: sparkline,
      averageDailySpend: avgDaily,
    );
  }

  static int _calculateDaysToSalary(DateTime now, int salaryDay) {
    DateTime nextSalary;
    if (now.day < salaryDay) {
      nextSalary = DateTime(now.year, now.month, salaryDay);
    } else if (now.day == salaryDay) {
      // Today is salary day, next is in ~1 month
      final nextMonth = DateTime(now.year, now.month + 1, 1);
      final daysInNextMonth = DateTime(nextMonth.year, nextMonth.month + 1, 0).day;
      final targetDay = min(salaryDay, daysInNextMonth);
      nextSalary = DateTime(nextMonth.year, nextMonth.month, targetDay);
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
