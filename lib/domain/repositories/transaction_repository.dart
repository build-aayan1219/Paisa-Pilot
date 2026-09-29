import '../models/transaction_item.dart';

abstract class ITransactionRepository {
  Future<List<TransactionItem>> getTransactions(String userId);
  Stream<List<TransactionItem>> watchTransactions(String userId);
  Future<void> addTransaction(TransactionItem transaction);
  Future<void> addTransactionsBatch(List<TransactionItem> transactions);
  Future<void> updateCategory(String id, String category);
  Future<void> clearTransactions(String userId);
}
