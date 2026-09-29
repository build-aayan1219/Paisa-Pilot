import '../models/savings_goal.dart';

abstract class IGoalRepository {
  Future<List<SavingsGoal>> getGoals(String userId);
  Stream<List<SavingsGoal>> watchGoals(String userId);
  Future<void> saveGoal(SavingsGoal goal);
  Future<void> clearGoals(String userId);
}
