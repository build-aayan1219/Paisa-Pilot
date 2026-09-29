import 'package:equatable/equatable.dart';

class SavingsGoal extends Equatable {
  final String id;
  final String userId;
  final String name;
  final double targetAmount;
  final DateTime deadline;
  final double savedAmount;

  const SavingsGoal({
    required this.id,
    required this.userId,
    required this.name,
    required this.targetAmount,
    required this.deadline,
    this.savedAmount = 0.0,
  });

  double get progress => targetAmount > 0 ? (savedAmount / targetAmount).clamp(0.0, 1.0) : 0.0;
  double get remainingAmount => (targetAmount - savedAmount).clamp(0.0, double.infinity);
  int get daysRemaining => deadline.difference(DateTime.now()).inDays.clamp(1, 9999);
  double get requiredDailySavings => remainingAmount / daysRemaining;

  SavingsGoal copyWith({
    String? id,
    String? userId,
    String? name,
    double? targetAmount,
    DateTime? deadline,
    double? savedAmount,
  }) {
    return SavingsGoal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      deadline: deadline ?? this.deadline,
      savedAmount: savedAmount ?? this.savedAmount,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        targetAmount,
        deadline,
        savedAmount,
      ];
}
