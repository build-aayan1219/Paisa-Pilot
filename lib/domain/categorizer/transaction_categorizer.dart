import '../merchant_normalizer/merchant_normalizer.dart';
import '../models/category.dart';
import '../repositories/merchant_rule_repository.dart';
import 'merchant_dictionary.dart';
import 'naive_bayes_classifier.dart';

class CategorizationResult {
  final TransactionCategory category;
  final double confidence; // 0.0 - 1.0
  final String normalizedMerchant;
  final bool isUserRuleApplied;

  const CategorizationResult({
    required this.category,
    required this.confidence,
    required this.normalizedMerchant,
    this.isUserRuleApplied = false,
  });
}

class TransactionCategorizer {
  final IMerchantRuleRepository? ruleRepository;

  TransactionCategorizer({this.ruleRepository});

  /// Categorizes a merchant raw string
  Future<CategorizationResult> categorize(
    String rawMerchant, {
    String? direction,
  }) async {
    final norm = MerchantNormalizer.normalize(rawMerchant);

    // If explicit credit / salary
    if (direction?.toLowerCase() == 'credit') {
      final lower = rawMerchant.toLowerCase();
      if (lower.contains('salary') ||
          lower.contains('stipend') ||
          lower.contains('payroll') ||
          lower.contains('techcorp')) {
        return CategorizationResult(
          category: TransactionCategory.salary,
          confidence: 1.0,
          normalizedMerchant: norm,
        );
      }
    }

    // 1. Check Personal User Rules (Highest Priority, 1.0 confidence)
    if (ruleRepository != null) {
      try {
        final rules = await ruleRepository!.getRules();
        final lowerNorm = norm.toLowerCase();
        for (final rule in rules) {
          if (rule.merchantNorm.toLowerCase() == lowerNorm) {
            return CategorizationResult(
              category: rule.category,
              confidence: 1.0,
              normalizedMerchant: norm,
              isUserRuleApplied: true,
            );
          }
        }
      } catch (_) {}
    }

    // 2. Check Curated 150+ Merchant Dictionary (Confidence 0.95 - 0.98)
    final dictMatch = MerchantDictionary.lookup(norm) ?? MerchantDictionary.lookup(rawMerchant);
    if (dictMatch != null) {
      return CategorizationResult(
        category: dictMatch,
        confidence: 0.96,
        normalizedMerchant: norm,
      );
    }

    // 3. Fallback Naive Bayes / Keyword Classifier
    final nbResult = NaiveBayesClassifier.classify('$rawMerchant $norm');
    if (nbResult.confidence >= 0.50 && nbResult.category != TransactionCategory.others) {
      return CategorizationResult(
        category: nbResult.category,
        confidence: nbResult.confidence,
        normalizedMerchant: norm,
      );
    }

    // 4. Default Fallback
    return CategorizationResult(
      category: TransactionCategory.others,
      confidence: 0.35,
      normalizedMerchant: norm,
    );
  }
}
