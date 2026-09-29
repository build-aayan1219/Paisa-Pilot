import '../../domain/repositories/goal_repository.dart';
import '../../domain/repositories/nudge_repository.dart';
import '../../domain/repositories/recurring_repository.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../domain/repositories/user_repository.dart';
import 'riya_data_generator.dart';

class SeedDataService {
  final IUserRepository userRepository;
  final ITransactionRepository transactionRepository;
  final IRecurringRepository recurringRepository;
  final IGoalRepository goalRepository;
  final INudgeRepository nudgeRepository;

  SeedDataService({
    required this.userRepository,
    required this.transactionRepository,
    required this.recurringRepository,
    required this.goalRepository,
    required this.nudgeRepository,
  });

  Future<void> seedRiyaPersona() async {
    const userId = RiyaDataGenerator.demoUserId;

    // 1. Clear existing data for Riya
    await userRepository.clearAllData(userId);

    // 2. Insert User Profile
    final user = RiyaDataGenerator.createRiyaProfile();
    await userRepository.saveUser(user);

    // 3. Insert Goal
    final goal = RiyaDataGenerator.createRiyaGoal();
    await goalRepository.saveGoal(goal);

    // 4. Insert Recurring Items
    final recurring = RiyaDataGenerator.createRiyaRecurringItems();
    await recurringRepository.saveRecurringBatch(recurring);

    // 5. Insert 3 Months of Transactions (~300 transactions)
    final transactions = RiyaDataGenerator.generate3MonthsTransactions();
    await transactionRepository.addTransactionsBatch(transactions);
  }
}
