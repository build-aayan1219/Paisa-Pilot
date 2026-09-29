import 'package:flutter_test/flutter_test.dart';
import 'package:paisa_pilot/domain/categorizer/naive_bayes_classifier.dart';
import 'package:paisa_pilot/domain/categorizer/transaction_categorizer.dart';
import 'package:paisa_pilot/domain/merchant_normalizer/merchant_normalizer.dart';
import 'package:paisa_pilot/domain/models/category.dart';
import 'package:paisa_pilot/domain/models/merchant_rule.dart';
import 'package:paisa_pilot/domain/repositories/merchant_rule_repository.dart';

class MockMerchantRuleRepository implements IMerchantRuleRepository {
  final List<MerchantRule> rules = [];

  @override
  Future<List<MerchantRule>> getRules() async => rules;

  @override
  Future<void> saveRule(String merchantNorm, TransactionCategory category) async {
    rules.add(MerchantRule(
      id: merchantNorm,
      merchantNorm: merchantNorm,
      category: category,
    ));
  }
}

void main() {
  group('MerchantNormalizer Tests', () {
    test('normalizes complex raw UPI strings correctly', () {
      expect(MerchantNormalizer.normalize('SWIGGY*ORDER 8842 BANGALORE'), 'Swiggy');
      expect(MerchantNormalizer.normalize('UPI/RENT/NESTAWAY PG HOUSING BANGALORE'), 'NestAway');
      expect(MerchantNormalizer.normalize('ZOMATO ONLINE ORDER RESTAURANTS'), 'Zomato');
      expect(MerchantNormalizer.normalize('AMAZON PAY INDIA SELLER SERVICES'), 'Amazon');
      expect(MerchantNormalizer.normalize('UBER INDIA SYSTEMS PVT LTD'), 'Uber');
      expect(MerchantNormalizer.normalize('CULT FIT CUREFIT HEALTHCARE BLR'), 'Cult.Fit');
      expect(MerchantNormalizer.normalize('AIRTEL BROADBAND FIBER BILL PYMT'), 'Airtel');
      expect(MerchantNormalizer.normalize('SPOTIFY INDIA MUSIC SUBSCRIPTION'), 'Spotify');
    });
  });

  group('Categorizer & Fallback Classifier Tests', () {
    late TransactionCategorizer categorizer;
    late MockMerchantRuleRepository mockRuleRepo;

    setUp(() {
      mockRuleRepo = MockMerchantRuleRepository();
      categorizer = TransactionCategorizer(ruleRepository: mockRuleRepo);
    });

    test('categorizes popular dictionary merchants with high confidence', () async {
      final swiggy = await categorizer.categorize('SWIGGY*ORDER 1234');
      expect(swiggy.category, TransactionCategory.foodDining);
      expect(swiggy.confidence, greaterThanOrEqualTo(0.90));

      final uber = await categorizer.categorize('UBER INDIA SYSTEMS PVT LTD');
      expect(uber.category, TransactionCategory.transport);
      expect(uber.confidence, greaterThanOrEqualTo(0.90));

      final blinkit = await categorizer.categorize('BLINKIT QUICK COMMERCE GURGAON');
      expect(blinkit.category, TransactionCategory.groceries);
      expect(blinkit.confidence, greaterThanOrEqualTo(0.90));

      final netflix = await categorizer.categorize('NETFLIX ENTERTAINMENT SERVICES');
      expect(netflix.category, TransactionCategory.entertainment);
      expect(netflix.confidence, greaterThanOrEqualTo(0.90));
    });

    test('applies personal user rules with 1.0 confidence', () async {
      // User sets rule: "Swiggy" should be classified as groceries (e.g. Swiggy Instamart order)
      await mockRuleRepo.saveRule('Swiggy', TransactionCategory.groceries);

      final result = await categorizer.categorize('SWIGGY*ORDER 9999');
      expect(result.category, TransactionCategory.groceries);
      expect(result.confidence, 1.0);
      expect(result.isUserRuleApplied, isTrue);
    });

    test('classifies unlisted merchants via Naive Bayes keyword fallback', () async {
      final cafe = NaiveBayesClassifier.classify('Corner Street Cafe and Bakery');
      expect(cafe.category, TransactionCategory.foodDining);
      expect(cafe.confidence, greaterThan(0.50));

      final metro = NaiveBayesClassifier.classify('Metro Railway Station Recharge');
      expect(metro.category, TransactionCategory.transport);
      expect(metro.confidence, greaterThan(0.50));

      final pharmacy = NaiveBayesClassifier.classify('City Medicals and Pharmacy Chemist');
      expect(pharmacy.category, TransactionCategory.health);
      expect(pharmacy.confidence, greaterThan(0.50));
    });

    test('evaluates accuracy on held-out 50 Indian transaction test split', () async {
      // 50 realistic held-out transaction descriptions unseen directly in training
      final testSet = <Map<String, dynamic>>[
        {'text': 'Zomato Daily Lunch Order', 'expected': TransactionCategory.foodDining},
        {'text': 'Haldiram Sweets and Restaurant BLR', 'expected': TransactionCategory.foodDining},
        {'text': 'Starbucks Coffee Koramangala', 'expected': TransactionCategory.foodDining},
        {'text': 'Dominos Pizza India', 'expected': TransactionCategory.foodDining},
        {'text': 'KFC Fried Chicken Order', 'expected': TransactionCategory.foodDining},
        {'text': 'Chai Point Hot Beverages', 'expected': TransactionCategory.foodDining},
        {'text': 'Annapurna Canteen Mess Meal', 'expected': TransactionCategory.foodDining},
        {'text': 'Burger King CP New Delhi', 'expected': TransactionCategory.foodDining},
        {'text': 'Biryani By Kilo Indiranagar', 'expected': TransactionCategory.foodDining},
        {'text': 'Local Street Dosa and Tea Stall', 'expected': TransactionCategory.foodDining},

        {'text': 'Zepto 10 min groceries delivery', 'expected': TransactionCategory.groceries},
        {'text': 'BigBasket Supermarket BLR', 'expected': TransactionCategory.groceries},
        {'text': 'Blinkit Instant Milk and Bread', 'expected': TransactionCategory.groceries},
        {'text': 'DMart Ready Retail Hypermarket', 'expected': TransactionCategory.groceries},
        {'text': 'Nature Basket Gourmet Food Store', 'expected': TransactionCategory.groceries},

        {'text': 'Uber Auto Ride to Metro', 'expected': TransactionCategory.transport},
        {'text': 'Ola Cabs Trip Payment', 'expected': TransactionCategory.transport},
        {'text': 'Rapido Bike Taxi BLR', 'expected': TransactionCategory.transport},
        {'text': 'Delhi Metro Rail Card Topup', 'expected': TransactionCategory.transport},
        {'text': 'IRCTC E-Ticket Booking', 'expected': TransactionCategory.transport},
        {'text': 'Indian Oil Petrol Pump Fuel', 'expected': TransactionCategory.transport},
        {'text': 'FASTag National Toll Highway', 'expected': TransactionCategory.transport},

        {'text': 'Amazon India Retail Seller', 'expected': TransactionCategory.shopping},
        {'text': 'Myntra Fashion Apparels', 'expected': TransactionCategory.shopping},
        {'text': 'Flipkart Internet E-commerce', 'expected': TransactionCategory.shopping},
        {'text': 'Nykaa Beauty and Cosmetics', 'expected': TransactionCategory.shopping},
        {'text': 'Zara Garments and Clothing Store', 'expected': TransactionCategory.shopping},
        {'text': 'Decathlon Sports Equipment', 'expected': TransactionCategory.shopping},
        {'text': 'Apple Retail Store BKC Mumbai', 'expected': TransactionCategory.shopping},
        {'text': 'Lenskart Eyewear Solutions', 'expected': TransactionCategory.shopping},

        {'text': 'NestAway PG Monthly Rent', 'expected': TransactionCategory.rentHousing},
        {'text': 'NoBroker Property Society Maintenance', 'expected': TransactionCategory.rentHousing},
        {'text': 'Stanza Living Student Hostel', 'expected': TransactionCategory.rentHousing},
        {'text': 'Zolo Stays Co-living Rent', 'expected': TransactionCategory.rentHousing},

        {'text': 'Airtel Broadband Fiber Internet', 'expected': TransactionCategory.billsUtilities},
        {'text': 'Reliance Jio Prepaid Recharge', 'expected': TransactionCategory.billsUtilities},
        {'text': 'Tata Power Electricity Bill Payment', 'expected': TransactionCategory.billsUtilities},
        {'text': 'BESCOM Bangalore Power Utility', 'expected': TransactionCategory.billsUtilities},
        {'text': 'Indane Gas Cylinder Booking', 'expected': TransactionCategory.billsUtilities},

        {'text': 'Netflix Entertainment India', 'expected': TransactionCategory.entertainment},
        {'text': 'Spotify Premium Music Streaming', 'expected': TransactionCategory.entertainment},
        {'text': 'BookMyShow Movie Tickets PVR', 'expected': TransactionCategory.entertainment},
        {'text': 'Disney+ Hotstar Annual VIP Subscription', 'expected': TransactionCategory.entertainment},
        {'text': 'PVR INOX Multiplex Cinema', 'expected': TransactionCategory.entertainment},

        {'text': 'Apollo Pharmacy Medical Store', 'expected': TransactionCategory.health},
        {'text': 'Tata 1mg Prescription Medicines', 'expected': TransactionCategory.health},
        {'text': 'Cult.Fit Gym Fitness Membership', 'expected': TransactionCategory.health},
        {'text': 'Netmeds Health Diagnostic Lab', 'expected': TransactionCategory.health},

        {'text': 'Coursera Online Certificate Course Fee', 'expected': TransactionCategory.education},
        {'text': 'Udemy Technical Upskilling Classes', 'expected': TransactionCategory.education},
      ];

      int correctCount = 0;
      for (final item in testSet) {
        final text = item['text'] as String;
        final expected = item['expected'] as TransactionCategory;
        final result = await categorizer.categorize(text);

        if (result.category == expected) {
          correctCount++;
        }
      }

      final accuracy = (correctCount / testSet.length) * 100.0;
      // ignore: avoid_print
      print('\n=========================================');
      // ignore: avoid_print
      print('Categorizer Held-Out Split Test Accuracy: ${accuracy.toStringAsFixed(1)}% ($correctCount/${testSet.length})');
      // ignore: avoid_print
      print('=========================================\n');

      expect(accuracy, greaterThanOrEqualTo(90.0)); // Strict 90%+ bar!
    });
  });
}
