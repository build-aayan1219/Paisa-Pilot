import 'dart:math';
import '../models/category.dart';

class ClassificationResult {
  final TransactionCategory category;
  final double confidence; // 0.0 - 1.0

  const ClassificationResult({
    required this.category,
    required this.confidence,
  });
}

class NaiveBayesClassifier {
  // Vocabulary term frequencies per category for Indian financial terms
  static final Map<TransactionCategory, Map<String, int>> _categoryWordCounts = {
    TransactionCategory.foodDining: {
      'food': 15, 'restaurant': 12, 'dining': 10, 'cafe': 10, 'coffee': 8,
      'tea': 8, 'chai': 12, 'biryani': 9, 'kitchen': 7, 'bakery': 8,
      'pizza': 10, 'burger': 9, 'snack': 6, 'lunch': 5, 'dinner': 5,
      'mess': 12, 'diner': 5, 'canteen': 9, 'dosa': 6, 'roll': 6,
    },
    TransactionCategory.groceries: {
      'grocery': 15, 'mart': 12, 'supermarket': 10, 'store': 8, 'provisions': 7,
      'vegetable': 9, 'fruit': 8, 'milk': 10, 'dairy': 9, 'bazaar': 8,
      'fresher': 6, 'daily': 8, 'bread': 5, 'eggs': 5,
    },
    TransactionCategory.shopping: {
      'shop': 12, 'mall': 10, 'clothing': 9, 'fashion': 10, 'wear': 8,
      'shoes': 7, 'electronics': 10, 'mobile': 7, 'retail': 8, 'apparel': 7,
      'store': 7, 'jewel': 6, 'beauty': 8, 'cosmetics': 8, 'outlet': 6,
    },
    TransactionCategory.transport: {
      'ride': 12, 'cab': 10, 'taxi': 10, 'travel': 9, 'trip': 8,
      'metro': 12, 'train': 9, 'railway': 9, 'bus': 10, 'petrol': 12,
      'fuel': 12, 'diesel': 10, 'auto': 8, 'toll': 8, 'parking': 6,
    },
    TransactionCategory.rentHousing: {
      'rent': 18, 'pg': 15, 'hostel': 12, 'society': 10, 'maintenance': 10,
      'housing': 12, 'flat': 9, 'apartment': 9, 'lease': 8, 'landlord': 7,
    },
    TransactionCategory.billsUtilities: {
      'bill': 15, 'electricity': 14, 'power': 12, 'water': 10, 'gas': 12,
      'broadband': 12, 'fiber': 10, 'wifi': 10, 'recharge': 14, 'cylinder': 9,
      'utility': 10, 'dth': 9,
    },
    TransactionCategory.entertainment: {
      'movie': 12, 'cinema': 10, 'theatre': 8, 'show': 7, 'music': 9,
      'subscription': 12, 'ott': 10, 'games': 8, 'streaming': 10, 'fun': 5,
    },
    TransactionCategory.health: {
      'pharmacy': 15, 'chemist': 12, 'hospital': 14, 'clinic': 12, 'doctor': 10,
      'medical': 12, 'medicine': 12, 'diagnostic': 10, 'lab': 9, 'fitness': 10,
      'gym': 12, 'health': 10,
    },
    TransactionCategory.education: {
      'course': 14, 'fee': 12, 'school': 12, 'college': 12, 'exam': 10,
      'tuition': 10, 'learning': 10, 'academy': 9, 'institute': 9, 'books': 8,
    },
    TransactionCategory.investments: {
      'invest': 15, 'mutual': 14, 'fund': 14, 'stocks': 14, 'sip': 12,
      'equity': 10, 'securities': 10, 'gold': 8, 'deposit': 7,
    },
    TransactionCategory.salary: {
      'salary': 20, 'stipend': 20, 'payroll': 18, 'wages': 14, 'bonus': 12,
      'incentive': 10, 'reimbursement': 10,
    },
  };

  /// Classifies text into a category with a calculated confidence score (0.0 to 1.0)
  static ClassificationResult classify(String text) {
    final tokens = _tokenize(text);
    if (tokens.isEmpty) {
      return const ClassificationResult(
        category: TransactionCategory.others,
        confidence: 0.30,
      );
    }

    final scores = <TransactionCategory, double>{};
    const double smoothing = 1.0;

    for (final category in _categoryWordCounts.keys) {
      final wordMap = _categoryWordCounts[category]!;
      final totalCategoryWords = wordMap.values.fold<int>(0, (a, b) => a + b);
      final vocabSize = 100; // estimated vocabulary size

      double logProb = 0.0;
      int matchCount = 0;

      for (final token in tokens) {
        final count = wordMap[token] ?? 0;
        if (count > 0) matchCount++;
        // Log-likelihood with Laplace smoothing
        logProb += log((count + smoothing) / (totalCategoryWords + smoothing * vocabSize));
      }

      // Bonus for exact keyword matches
      scores[category] = logProb + (matchCount * 2.5);
    }

    // Find highest scoring category
    TransactionCategory bestCategory = TransactionCategory.others;
    double maxScore = -double.infinity;

    for (final entry in scores.entries) {
      if (entry.value > maxScore) {
        maxScore = entry.value;
        bestCategory = entry.key;
      }
    }

    // Convert scores to pseudo-probabilities via Softmax over top candidates
    final expScores = scores.map((k, v) => MapEntry(k, exp(v - maxScore)));
    final sumExp = expScores.values.fold<double>(0.0, (a, b) => a + b);
    double confidence = sumExp > 0 ? (expScores[bestCategory]! / sumExp) : 0.40;

    // Normalizing confidence into human range 0.40 - 0.88 for fallback classifier
    confidence = (confidence * 0.5 + 0.38).clamp(0.40, 0.88);

    return ClassificationResult(
      category: bestCategory,
      confidence: confidence,
    );
  }

  static List<String> _tokenize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-zA-Z\s]'), ' ')
        .split(RegExp(r'\s+'))
        .where((token) => token.length > 2)
        .toList();
  }
}
