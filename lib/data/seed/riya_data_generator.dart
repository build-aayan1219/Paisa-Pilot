import 'dart:math';
import 'package:uuid/uuid.dart';
import '../../domain/models/category.dart';
import '../../domain/models/recurring_item.dart';
import '../../domain/models/savings_goal.dart';
import '../../domain/models/transaction_item.dart';
import '../../domain/models/user_profile.dart';

class RiyaDataGenerator {
  RiyaDataGenerator._();

  static const String demoUserId = 'riya_demo_user';
  static const _uuid = Uuid();

  static UserProfile createRiyaProfile() {
    return const UserProfile(
      id: demoUserId,
      name: 'Riya Sharma',
      incomeCycleDay: 1, // Salary day is 1st of month
      monthlyIncome: 25000.0,
      openingBalance: 8450.0, // Mid-cycle balance creating ~78% shortfall probability
      language: 'en',
    );
  }

  static SavingsGoal createRiyaGoal() {
    return SavingsGoal(
      id: 'riya_goal_1',
      userId: demoUserId,
      name: 'Emergency Fund',
      targetAmount: 20000.0,
      savedAmount: 6500.0,
      deadline: DateTime.now().add(const Duration(days: 75)),
    );
  }

  static List<RecurringItem> createRiyaRecurringItems() {
    final now = DateTime.now();
    final nextMonth = DateTime(now.year, now.month + 1, 1);

    return [
      RecurringItem(
        id: 'rec_rent',
        userId: demoUserId,
        merchant: 'NestAway PG Rent',
        amount: 8500.0,
        cadence: 'monthly',
        nextDue: DateTime(now.year, now.month, 2).isAfter(now)
            ? DateTime(now.year, now.month, 2)
            : DateTime(nextMonth.year, nextMonth.month, 2),
      ),
      RecurringItem(
        id: 'rec_mess',
        userId: demoUserId,
        merchant: 'Annapurna Mess',
        amount: 3800.0,
        cadence: 'monthly',
        nextDue: DateTime(now.year, now.month, 5).isAfter(now)
            ? DateTime(now.year, now.month, 5)
            : DateTime(nextMonth.year, nextMonth.month, 5),
      ),
      RecurringItem(
        id: 'rec_netflix',
        userId: demoUserId,
        merchant: 'Netflix',
        amount: 199.0,
        cadence: 'monthly',
        nextDue: DateTime(now.year, now.month, 14).isAfter(now)
            ? DateTime(now.year, now.month, 14)
            : DateTime(nextMonth.year, nextMonth.month, 14),
      ),
      RecurringItem(
        id: 'rec_spotify',
        userId: demoUserId,
        merchant: 'Spotify India',
        amount: 119.0,
        cadence: 'monthly',
        nextDue: DateTime(now.year, now.month, 18).isAfter(now)
            ? DateTime(now.year, now.month, 18)
            : DateTime(nextMonth.year, nextMonth.month, 18),
      ),
      RecurringItem(
        id: 'rec_wifi',
        userId: demoUserId,
        merchant: 'Airtel Broadband',
        amount: 589.0,
        cadence: 'monthly',
        nextDue: DateTime(now.year, now.month, 26).isAfter(now)
            ? DateTime(now.year, now.month, 26)
            : DateTime(nextMonth.year, nextMonth.month, 26),
      ),
      // Suspected leak: Forgotten gym membership auto-debit
      RecurringItem(
        id: 'rec_gym_leak',
        userId: demoUserId,
        merchant: 'Cult.Fit Pass',
        amount: 1250.0,
        cadence: 'monthly',
        nextDue: DateTime(now.year, now.month, 28).isAfter(now)
            ? DateTime(now.year, now.month, 28)
            : DateTime(nextMonth.year, nextMonth.month, 28),
        isLeak: true,
      ),
    ];
  }

  static List<TransactionItem> generate3MonthsTransactions() {
    final transactions = <TransactionItem>[];
    final random = Random(42); // Deterministic seed for reproducible testing
    final now = DateTime.now();

    // 90 days span
    for (int dayOffset = 90; dayOffset >= 0; dayOffset--) {
      final date = now.subtract(Duration(days: dayOffset));
      final day = date.day;
      final weekday = date.weekday;
      final isWeekend = weekday == DateTime.saturday || weekday == DateTime.sunday;

      // 1. Stipend on the 1st of every month
      if (day == 1) {
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 9, 30),
          amount: 25000.0,
          direction: 'credit',
          merchantRaw: 'SALARY CREDIT TECHCORP INTERNSHIP STIPEND',
          merchantNorm: 'TechCorp Internship',
          category: TransactionCategory.salary,
          confidence: 1.0,
          isRecurring: true,
          source: 'seed',
        ));
      }

      // 2. Fixed recurring bills
      if (day == 2) {
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 11, 15),
          amount: 8500.0,
          direction: 'debit',
          merchantRaw: 'UPI/RENT/NESTAWAY PG HOUSING BANGALORE',
          merchantNorm: 'NestAway PG Rent',
          category: TransactionCategory.rentHousing,
          confidence: 0.98,
          isRecurring: true,
          source: 'seed',
        ));
      }

      if (day == 5) {
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 10, 0),
          amount: 3800.0,
          direction: 'debit',
          merchantRaw: 'UPI/ANNAPURNA MESS FOOD CHARGES',
          merchantNorm: 'Annapurna Mess',
          category: TransactionCategory.foodDining,
          confidence: 0.95,
          isRecurring: true,
          source: 'seed',
        ));
      }

      if (day == 14) {
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 8, 45),
          amount: 199.0,
          direction: 'debit',
          merchantRaw: 'NETFLIX ENTERTAINMENT SERVICES MUMBAI',
          merchantNorm: 'Netflix',
          category: TransactionCategory.entertainment,
          confidence: 0.99,
          isRecurring: true,
          source: 'seed',
        ));
      }

      if (day == 18) {
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 12, 10),
          amount: 119.0,
          direction: 'debit',
          merchantRaw: 'SPOTIFY INDIA MUSIC SUBSCRIPTION',
          merchantNorm: 'Spotify India',
          category: TransactionCategory.entertainment,
          confidence: 0.99,
          isRecurring: true,
          source: 'seed',
        ));
      }

      if (day == 26) {
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 16, 20),
          amount: 589.0,
          direction: 'debit',
          merchantRaw: 'AIRTEL BROADBAND FIBER BILL PYMT',
          merchantNorm: 'Airtel Broadband',
          category: TransactionCategory.billsUtilities,
          confidence: 0.96,
          isRecurring: true,
          source: 'seed',
        ));
      }

      if (day == 28) {
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 7, 0),
          amount: 1250.0,
          direction: 'debit',
          merchantRaw: 'CULT FIT CUREFIT HEALTHCARE BLR',
          merchantNorm: 'Cult.Fit Pass',
          category: TransactionCategory.health,
          confidence: 0.92,
          isRecurring: true,
          source: 'seed',
        ));
      }

      // 3. Daily variable food & chai
      final foodCount = isWeekend ? (random.nextInt(2) + 2) : (random.nextInt(2) + 1);
      for (int i = 0; i < foodCount; i++) {
        final isSwiggy = random.nextBool();
        final rawMerchant = isSwiggy
            ? 'SWIGGY*ORDER ${random.nextInt(8999) + 1000} BANGALORE'
            : 'ZOMATO ONLINE ORDER RESTAURANTS';
        final normMerchant = isSwiggy ? 'Swiggy' : 'Zomato';
        final amount = (random.nextInt(28) + 12) * 10.0 + (random.nextInt(10)); // ₹120 - ₹400

        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 13 + i * 6, random.nextInt(60)),
          amount: amount,
          direction: 'debit',
          merchantRaw: rawMerchant,
          merchantNorm: normMerchant,
          category: TransactionCategory.foodDining,
          confidence: 0.97,
          isRecurring: false,
          source: 'seed',
        ));
      }

      // 4. Quick Chai / Snack
      if (random.nextDouble() > 0.4) {
        final amount = (random.nextInt(8) + 3) * 10.0; // ₹30 - ₹100
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 17, random.nextInt(60)),
          amount: amount,
          direction: 'debit',
          merchantRaw: 'CHAI POINT KORAMANGALA',
          merchantNorm: 'Chai Point',
          category: TransactionCategory.foodDining,
          confidence: 0.95,
          isRecurring: false,
          source: 'seed',
        ));
      }

      // 5. Commute (Uber, Ola, Rapido)
      if (!isWeekend && random.nextDouble() > 0.3) {
        final isUber = random.nextBool();
        final amount = (random.nextInt(14) + 6) * 10.0 + random.nextInt(9); // ₹60 - ₹200
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 9, random.nextInt(60)),
          amount: amount,
          direction: 'debit',
          merchantRaw: isUber ? 'UBER INDIA SYSTEMS PVT LTD' : 'RAPIDO BIKE TAXI RIDES',
          merchantNorm: isUber ? 'Uber' : 'Rapido',
          category: TransactionCategory.transport,
          confidence: 0.98,
          isRecurring: false,
          source: 'seed',
        ));
      }

      // 6. Weekend spikes (Shopping, Dining, Cafes)
      if (isWeekend) {
        if (random.nextDouble() > 0.4) {
          final isBlinkit = random.nextBool();
          final amount = (random.nextInt(40) + 25) * 10.0; // ₹250 - ₹650
          transactions.add(TransactionItem(
            id: _uuid.v4(),
            userId: demoUserId,
            date: DateTime(date.year, date.month, date.day, 19, random.nextInt(60)),
            amount: amount,
            direction: 'debit',
            merchantRaw: isBlinkit ? 'BLINKIT QUICK COMMERCE GURGAON' : 'ZEPTO 10 MIN GROCERY BLR',
            merchantNorm: isBlinkit ? 'Blinkit' : 'Zepto',
            category: TransactionCategory.groceries,
            confidence: 0.96,
            isRecurring: false,
            source: 'seed',
          ));
        }

        if (random.nextDouble() > 0.5) {
          final amount = (random.nextInt(60) + 40) * 10.0; // ₹400 - ₹1000
          transactions.add(TransactionItem(
            id: _uuid.v4(),
            userId: demoUserId,
            date: DateTime(date.year, date.month, date.day, 21, random.nextInt(60)),
            amount: amount,
            direction: 'debit',
            merchantRaw: 'THIRD WAVE COFFEE ROASTERS BLR',
            merchantNorm: 'Third Wave Coffee',
            category: TransactionCategory.foodDining,
            confidence: 0.94,
            isRecurring: false,
            source: 'seed',
          ));
        }
      }

      // 7. Occasional Shopping (Amazon, Myntra)
      if (dayOffset % 12 == 3) {
        final amount = (random.nextInt(90) + 35) * 10.0; // ₹350 - ₹1250
        transactions.add(TransactionItem(
          id: _uuid.v4(),
          userId: demoUserId,
          date: DateTime(date.year, date.month, date.day, 15, random.nextInt(60)),
          amount: amount,
          direction: 'debit',
          merchantRaw: 'AMAZON PAY INDIA SELLER SERVICES',
          merchantNorm: 'Amazon',
          category: TransactionCategory.shopping,
          confidence: 0.98,
          isRecurring: false,
          source: 'seed',
        ));
      }
    }

    // 8. Exactly 2 Unusual Outlier Transactions (z-score anomalies)
    // One from 45 days ago: Laptop / phone screen repair
    final anomalyDate1 = now.subtract(const Duration(days: 42));
    transactions.add(TransactionItem(
      id: _uuid.v4(),
      userId: demoUserId,
      date: DateTime(anomalyDate1.year, anomalyDate1.month, anomalyDate1.day, 14, 20),
      amount: 6800.0,
      direction: 'debit',
      merchantRaw: 'APPLE AUTHORIZED SERVICE CENTER INDIRANAGAR',
      merchantNorm: 'Apple Service Center',
      category: TransactionCategory.shopping,
      confidence: 0.91,
      isRecurring: false,
      source: 'seed',
    ));

    // Second from 12 days ago: Concert ticket
    final anomalyDate2 = now.subtract(const Duration(days: 12));
    transactions.add(TransactionItem(
      id: _uuid.v4(),
      userId: demoUserId,
      date: DateTime(anomalyDate2.year, anomalyDate2.month, anomalyDate2.day, 20, 15),
      amount: 4500.0,
      direction: 'debit',
      merchantRaw: 'BOOKMYSHOW LIVE CONCERT TICKETS MUMBAI',
      merchantNorm: 'BookMyShow',
      category: TransactionCategory.entertainment,
      confidence: 0.95,
      isRecurring: false,
      source: 'seed',
    ));

    // Sort descending by date
    transactions.sort((a, b) => b.date.compareTo(a.date));
    return transactions;
  }
}
