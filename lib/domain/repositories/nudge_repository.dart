import '../models/nudge_item.dart';

abstract class INudgeRepository {
  Future<List<NudgeItem>> getNudges(String userId);
  Stream<List<NudgeItem>> watchNudges(String userId);
  Future<void> saveNudgesBatch(List<NudgeItem> nudges);
  Future<void> updateFeedback(String nudgeId, String feedback);
  Future<void> clearNudges(String userId);
}
