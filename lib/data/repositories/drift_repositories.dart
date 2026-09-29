import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/models/category.dart';
import '../../domain/models/merchant_rule.dart' as dm;
import '../../domain/models/nudge_item.dart';
import '../../domain/models/recurring_item.dart' as dm;
import '../../domain/models/savings_goal.dart';
import '../../domain/models/transaction_item.dart';
import '../../domain/models/user_profile.dart';
import '../../domain/repositories/goal_repository.dart';
import '../../domain/repositories/merchant_rule_repository.dart';
import '../../domain/repositories/nudge_repository.dart';
import '../../domain/repositories/recurring_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../database/app_database.dart';

class DriftUserRepository implements IUserRepository {
  final AppDatabase _db;
  DriftUserRepository(this._db);

  @override
  Future<UserProfile?> getUser(String userId) async {
    final row = await _db.getUser(userId);
    if (row == null) return null;
    return UserProfile(
      id: row.id,
      name: row.name,
      incomeCycleDay: row.incomeCycleDay,
      monthlyIncome: row.monthlyIncome,
      openingBalance: row.openingBalance,
      language: row.language,
    );
  }

  @override
  Stream<UserProfile?> watchUser(String userId) {
    return _db.watchUser(userId).map((row) {
      if (row == null) return null;
      return UserProfile(
        id: row.id,
        name: row.name,
        incomeCycleDay: row.incomeCycleDay,
        monthlyIncome: row.monthlyIncome,
        openingBalance: row.openingBalance,
        language: row.language,
      );
    });
  }

  @override
  Future<void> saveUser(UserProfile user) {
    return _db.upsertUser(
      UsersCompanion(
        id: Value(user.id),
        name: Value(user.name),
        incomeCycleDay: Value(user.incomeCycleDay),
        monthlyIncome: Value(user.monthlyIncome),
        openingBalance: Value(user.openingBalance),
        language: Value(user.language),
      ),
    );
  }

  @override
  Future<void> clearAllData(String userId) {
    return _db.clearAllUserData(userId);
  }
}

class DriftTransactionRepository implements ITransactionRepository {
  final AppDatabase _db;
  DriftTransactionRepository(this._db);

  TransactionItem _toDomain(Transaction row) {
    return TransactionItem(
      id: row.id,
      userId: row.userId,
      date: row.ts,
      amount: row.amount,
      direction: row.direction,
      merchantRaw: row.merchantRaw,
      merchantNorm: row.merchantNorm,
      category: TransactionCategory.fromString(row.category),
      confidence: row.confidence,
      isRecurring: row.isRecurring,
      source: row.source,
    );
  }

  TransactionsCompanion _toCompanion(TransactionItem item) {
    return TransactionsCompanion(
      id: Value(item.id),
      userId: Value(item.userId),
      ts: Value(item.date),
      amount: Value(item.amount),
      direction: Value(item.direction),
      merchantRaw: Value(item.merchantRaw),
      merchantNorm: Value(item.merchantNorm),
      category: Value(item.category.name),
      confidence: Value(item.confidence),
      isRecurring: Value(item.isRecurring),
      source: Value(item.source),
    );
  }

  @override
  Future<List<TransactionItem>> getTransactions(String userId) async {
    final rows = await _db.getAllTransactions(userId);
    return rows.map(_toDomain).toList();
  }

  @override
  Stream<List<TransactionItem>> watchTransactions(String userId) {
    return _db.watchAllTransactions(userId).map(
          (rows) => rows.map(_toDomain).toList(),
        );
  }

  @override
  Future<void> addTransaction(TransactionItem transaction) {
    return _db.insertTransaction(_toCompanion(transaction));
  }

  @override
  Future<void> addTransactionsBatch(List<TransactionItem> transactions) {
    return _db.insertTransactionsBatch(transactions.map(_toCompanion).toList());
  }

  @override
  Future<void> updateCategory(String id, String category) {
    return _db.updateTransactionCategory(id, category);
  }

  @override
  Future<void> clearTransactions(String userId) {
    return _db.clearAllTransactions(userId);
  }
}

class DriftRecurringRepository implements IRecurringRepository {
  final AppDatabase _db;
  DriftRecurringRepository(this._db);

  @override
  Future<List<dm.RecurringItem>> getRecurringItems(String userId) async {
    final rows = await _db.getRecurringItems(userId);
    return rows
        .map((r) => dm.RecurringItem(
              id: r.id,
              userId: r.userId,
              merchant: r.merchant,
              amount: r.amount,
              cadence: r.cadence,
              nextDue: r.nextDue,
            ))
        .toList();
  }

  @override
  Stream<List<dm.RecurringItem>> watchRecurringItems(String userId) {
    return _db.watchRecurringItems(userId).map((rows) => rows
        .map((r) => dm.RecurringItem(
              id: r.id,
              userId: r.userId,
              merchant: r.merchant,
              amount: r.amount,
              cadence: r.cadence,
              nextDue: r.nextDue,
            ))
        .toList());
  }

  @override
  Future<void> saveRecurringBatch(List<dm.RecurringItem> items) {
    final companions = items
        .map((i) => RecurringItemsCompanion(
              id: Value(i.id),
              userId: Value(i.userId),
              merchant: Value(i.merchant),
              amount: Value(i.amount),
              cadence: Value(i.cadence),
              nextDue: Value(i.nextDue),
            ))
        .toList();
    return _db.insertRecurringBatch(companions);
  }

  @override
  Future<void> clearRecurringItems(String userId) {
    return _db.clearRecurringItems(userId);
  }
}

class DriftGoalRepository implements IGoalRepository {
  final AppDatabase _db;
  DriftGoalRepository(this._db);

  @override
  Future<List<SavingsGoal>> getGoals(String userId) async {
    final rows = await _db.getGoals(userId);
    return rows
        .map((g) => SavingsGoal(
              id: g.id,
              userId: g.userId,
              name: g.name,
              targetAmount: g.targetAmt,
              deadline: g.deadline,
              savedAmount: g.saved,
            ))
        .toList();
  }

  @override
  Stream<List<SavingsGoal>> watchGoals(String userId) {
    return _db.watchGoals(userId).map((rows) => rows
        .map((g) => SavingsGoal(
              id: g.id,
              userId: g.userId,
              name: g.name,
              targetAmount: g.targetAmt,
              deadline: g.deadline,
              savedAmount: g.saved,
            ))
        .toList());
  }

  @override
  Future<void> saveGoal(SavingsGoal goal) {
    return _db.upsertGoal(
      GoalsCompanion(
        id: Value(goal.id),
        userId: Value(goal.userId),
        name: Value(goal.name),
        targetAmt: Value(goal.targetAmount),
        deadline: Value(goal.deadline),
        saved: Value(goal.savedAmount),
      ),
    );
  }

  @override
  Future<void> clearGoals(String userId) {
    return _db.clearGoals(userId);
  }
}

class DriftNudgeRepository implements INudgeRepository {
  final AppDatabase _db;
  DriftNudgeRepository(this._db);

  NudgeItem _toDomain(Nudge row) {
    List<NudgeFactData> facts = [];
    try {
      final decoded = jsonDecode(row.factsJson) as List<dynamic>?;
      if (decoded != null) {
        facts = decoded
            .map((f) => NudgeFactData.fromJson(f as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}

    return NudgeItem(
      id: row.id,
      userId: row.userId,
      timestamp: row.ts,
      type: NudgeType.values.firstWhere(
        (t) => t.name == row.type,
        orElse: () => NudgeType.safeSpendTip,
      ),
      title: row.type,
      body: row.textContent,
      facts: facts,
      feedback: row.feedback,
    );
  }

  @override
  Future<List<NudgeItem>> getNudges(String userId) async {
    final rows = await _db.getNudges(userId);
    return rows.map(_toDomain).toList();
  }

  @override
  Stream<List<NudgeItem>> watchNudges(String userId) {
    return _db.watchNudges(userId).map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<void> saveNudgesBatch(List<NudgeItem> nudges) {
    final companions = nudges.map((n) {
      final factsJson = jsonEncode(n.facts.map((f) => f.toJson()).toList());
      return NudgesCompanion(
        id: Value(n.id),
        userId: Value(n.userId),
        ts: Value(n.timestamp),
        type: Value(n.type.name),
        textContent: Value(n.body),
        factsJson: Value(factsJson),
        feedback: Value(n.feedback),
      );
    }).toList();
    return _db.insertNudgesBatch(companions);
  }

  @override
  Future<void> updateFeedback(String nudgeId, String feedback) {
    return _db.updateNudgeFeedback(nudgeId, feedback);
  }

  @override
  Future<void> clearNudges(String userId) {
    return _db.clearNudges(userId);
  }
}

class DriftMerchantRuleRepository implements IMerchantRuleRepository {
  final AppDatabase _db;
  DriftMerchantRuleRepository(this._db);

  @override
  Future<List<dm.MerchantRule>> getRules() async {
    final rows = await _db.getAllMerchantRules();
    return rows
        .map((r) => dm.MerchantRule(
              id: r.id,
              merchantNorm: r.merchantNorm,
              category: TransactionCategory.fromString(r.category),
            ))
        .toList();
  }

  @override
  Future<void> saveRule(String merchantNorm, TransactionCategory category) {
    return _db.upsertMerchantRule(
      MerchantRulesCompanion(
        id: Value(merchantNorm.toLowerCase().trim()),
        merchantNorm: Value(merchantNorm.toLowerCase().trim()),
        category: Value(category.name),
      ),
    );
  }
}
