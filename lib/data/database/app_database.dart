import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// --- TABLES ---

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get incomeCycleDay => integer()();
  RealColumn get monthlyIncome => real()();
  RealColumn get openingBalance => real()();
  TextColumn get language => text().withDefault(const Constant('en'))();

  @override
  Set<Column> get primaryKey => {id};
}

class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get ts => dateTime()();
  RealColumn get amount => real()();
  TextColumn get direction => text()(); // 'debit' or 'credit'
  TextColumn get merchantRaw => text()();
  TextColumn get merchantNorm => text()();
  TextColumn get category => text()();
  RealColumn get confidence => real()();
  BoolColumn get isRecurring => boolean().withDefault(const Constant(false))();
  TextColumn get source => text()(); // 'sms', 'csv', 'manual', 'seed'

  @override
  Set<Column> get primaryKey => {id};
}

class RecurringItems extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get merchant => text()();
  RealColumn get amount => real()();
  TextColumn get cadence => text()(); // 'monthly', 'weekly', etc.
  DateTimeColumn get nextDue => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  RealColumn get targetAmt => real()();
  DateTimeColumn get deadline => dateTime()();
  RealColumn get saved => real().withDefault(const Constant(0.0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Nudges extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get ts => dateTime()();
  TextColumn get type => text()();
  TextColumn get textContent => text().named('text')();
  TextColumn get factsJson => text()();
  TextColumn get feedback => text().nullable()(); // 'helpful', 'dismissed'

  @override
  Set<Column> get primaryKey => {id};
}

class MerchantRules extends Table {
  TextColumn get id => text()();
  TextColumn get merchantNorm => text()();
  TextColumn get category => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- DATABASE ---

@DriftDatabase(tables: [
  Users,
  Transactions,
  RecurringItems,
  Goals,
  Nudges,
  MerchantRules,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'paisa_pilot');
  }

  // --- TRANSACTIONS QUERIES ---
  Future<List<Transaction>> getAllTransactions(String userId) {
    return (select(transactions)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.ts, mode: OrderingMode.desc)]))
        .get();
  }

  Stream<List<Transaction>> watchAllTransactions(String userId) {
    return (select(transactions)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.ts, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<void> insertTransaction(TransactionsCompanion entry) {
    return into(transactions).insert(entry, mode: InsertMode.insertOrReplace);
  }

  Future<void> insertTransactionsBatch(List<TransactionsCompanion> entries) {
    return batch((batch) {
      batch.insertAll(transactions, entries, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> updateTransactionCategory(String id, String category) {
    return (update(transactions)..where((t) => t.id.equals(id))).write(
      TransactionsCompanion(
        category: Value(category),
        confidence: const Value(1.0),
      ),
    );
  }

  Future<void> clearAllTransactions(String userId) {
    return (delete(transactions)..where((t) => t.userId.equals(userId))).go();
  }

  // --- USER QUERIES ---
  Future<User?> getUser(String userId) {
    return (select(users)..where((tbl) => tbl.id.equals(userId))).getSingleOrNull();
  }

  Stream<User?> watchUser(String userId) {
    return (select(users)..where((tbl) => tbl.id.equals(userId))).watchSingleOrNull();
  }

  Future<void> upsertUser(UsersCompanion user) {
    return into(users).insert(user, mode: InsertMode.insertOrReplace);
  }

  // --- RECURRING ITEMS ---
  Future<List<RecurringItem>> getRecurringItems(String userId) {
    return (select(recurringItems)..where((tbl) => tbl.userId.equals(userId))).get();
  }

  Stream<List<RecurringItem>> watchRecurringItems(String userId) {
    return (select(recurringItems)..where((tbl) => tbl.userId.equals(userId))).watch();
  }

  Future<void> insertRecurringBatch(List<RecurringItemsCompanion> entries) {
    return batch((batch) {
      batch.insertAll(recurringItems, entries, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> clearRecurringItems(String userId) {
    return (delete(recurringItems)..where((t) => t.userId.equals(userId))).go();
  }

  // --- GOALS ---
  Future<List<Goal>> getGoals(String userId) {
    return (select(goals)..where((tbl) => tbl.userId.equals(userId))).get();
  }

  Stream<List<Goal>> watchGoals(String userId) {
    return (select(goals)..where((tbl) => tbl.userId.equals(userId))).watch();
  }

  Future<void> upsertGoal(GoalsCompanion goal) {
    return into(goals).insert(goal, mode: InsertMode.insertOrReplace);
  }

  Future<void> clearGoals(String userId) {
    return (delete(goals)..where((t) => t.userId.equals(userId))).go();
  }

  // --- NUDGES ---
  Future<List<Nudge>> getNudges(String userId) {
    return (select(nudges)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.ts, mode: OrderingMode.desc)]))
        .get();
  }

  Stream<List<Nudge>> watchNudges(String userId) {
    return (select(nudges)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.ts, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<void> insertNudgesBatch(List<NudgesCompanion> entries) {
    return batch((batch) {
      batch.insertAll(nudges, entries, mode: InsertMode.insertOrReplace);
    });
  }

  Future<void> updateNudgeFeedback(String id, String feedback) {
    return (update(nudges)..where((n) => n.id.equals(id))).write(
      NudgesCompanion(feedback: Value(feedback)),
    );
  }

  Future<void> clearNudges(String userId) {
    return (delete(nudges)..where((t) => t.userId.equals(userId))).go();
  }

  // --- MERCHANT RULES ---
  Future<List<MerchantRule>> getAllMerchantRules() {
    return select(merchantRules).get();
  }

  Future<void> upsertMerchantRule(MerchantRulesCompanion rule) {
    return into(merchantRules).insert(rule, mode: InsertMode.insertOrReplace);
  }

  // --- RESET ALL DATA ---
  Future<void> clearAllUserData(String userId) async {
    await (delete(transactions)..where((t) => t.userId.equals(userId))).go();
    await (delete(recurringItems)..where((t) => t.userId.equals(userId))).go();
    await (delete(goals)..where((t) => t.userId.equals(userId))).go();
    await (delete(nudges)..where((t) => t.userId.equals(userId))).go();
    await (delete(users)..where((t) => t.id.equals(userId))).go();
  }
}
