import '../models/user_profile.dart';

abstract class IUserRepository {
  Future<UserProfile?> getUser(String userId);
  Stream<UserProfile?> watchUser(String userId);
  Future<void> saveUser(UserProfile user);
  Future<void> clearAllData(String userId);
}
