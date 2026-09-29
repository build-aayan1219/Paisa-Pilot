import 'package:equatable/equatable.dart';

class RecurringItem extends Equatable {
  final String id;
  final String userId;
  final String merchant;
  final double amount;
  final String cadence; // 'monthly', 'weekly', etc.
  final DateTime nextDue;
  final bool isLeak; // Flag for duplicate, unused, or price-hiked subscriptions

  const RecurringItem({
    required this.id,
    required this.userId,
    required this.merchant,
    required this.amount,
    required this.cadence,
    required this.nextDue,
    this.isLeak = false,
  });

  RecurringItem copyWith({
    String? id,
    String? userId,
    String? merchant,
    double? amount,
    String? cadence,
    DateTime? nextDue,
    bool? isLeak,
  }) {
    return RecurringItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      merchant: merchant ?? this.merchant,
      amount: amount ?? this.amount,
      cadence: cadence ?? this.cadence,
      nextDue: nextDue ?? this.nextDue,
      isLeak: isLeak ?? this.isLeak,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        merchant,
        amount,
        cadence,
        nextDue,
        isLeak,
      ];
}
