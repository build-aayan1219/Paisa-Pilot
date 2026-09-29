import 'package:equatable/equatable.dart';
import 'category.dart';

class TransactionItem extends Equatable {
  final String id;
  final String userId;
  final DateTime date;
  final double amount;
  final String direction; // 'debit' or 'credit'
  final String merchantRaw;
  final String merchantNorm;
  final TransactionCategory category;
  final double confidence; // 0.0 - 1.0
  final bool isRecurring;
  final String source; // 'sms', 'csv', 'manual', 'seed'

  const TransactionItem({
    required this.id,
    required this.userId,
    required this.date,
    required this.amount,
    required this.direction,
    required this.merchantRaw,
    required this.merchantNorm,
    required this.category,
    this.confidence = 1.0,
    this.isRecurring = false,
    this.source = 'manual',
  });

  bool get isIncome => direction.toLowerCase() == 'credit';
  bool get isExpense => !isIncome;

  TransactionItem copyWith({
    String? id,
    String? userId,
    DateTime? date,
    double? amount,
    String? direction,
    String? merchantRaw,
    String? merchantNorm,
    TransactionCategory? category,
    double? confidence,
    bool? isRecurring,
    String? source,
  }) {
    return TransactionItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      direction: direction ?? this.direction,
      merchantRaw: merchantRaw ?? this.merchantRaw,
      merchantNorm: merchantNorm ?? this.merchantNorm,
      category: category ?? this.category,
      confidence: confidence ?? this.confidence,
      isRecurring: isRecurring ?? this.isRecurring,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        date,
        amount,
        direction,
        merchantRaw,
        merchantNorm,
        category,
        confidence,
        isRecurring,
        source,
      ];
}
