import '../models/category.dart';
import '../models/merchant_rule.dart';

abstract class IMerchantRuleRepository {
  Future<List<MerchantRule>> getRules();
  Future<void> saveRule(String merchantNorm, TransactionCategory category);
}
