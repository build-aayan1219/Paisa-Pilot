import '../models/recurring_item.dart';

abstract class IRecurringRepository {
  Future<List<RecurringItem>> getRecurringItems(String userId);
  Stream<List<RecurringItem>> watchRecurringItems(String userId);
  Future<void> saveRecurringBatch(List<RecurringItem> items);
  Future<void> clearRecurringItems(String userId);
}
