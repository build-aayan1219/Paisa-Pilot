import 'package:equatable/equatable.dart';
import 'category.dart';

class MerchantRule extends Equatable {
  final String id;
  final String merchantNorm;
  final TransactionCategory category;

  const MerchantRule({
    required this.id,
    required this.merchantNorm,
    required this.category,
  });

  @override
  List<Object?> get props => [id, merchantNorm, category];
}
