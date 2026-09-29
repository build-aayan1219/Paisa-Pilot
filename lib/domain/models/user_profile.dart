import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final int incomeCycleDay; // 1-31
  final double monthlyIncome;
  final double openingBalance;
  final String language;

  const UserProfile({
    required this.id,
    required this.name,
    required this.incomeCycleDay,
    required this.monthlyIncome,
    required this.openingBalance,
    this.language = 'en',
  });

  UserProfile copyWith({
    String? id,
    String? name,
    int? incomeCycleDay,
    double? monthlyIncome,
    double? openingBalance,
    String? language,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      incomeCycleDay: incomeCycleDay ?? this.incomeCycleDay,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      openingBalance: openingBalance ?? this.openingBalance,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        incomeCycleDay,
        monthlyIncome,
        openingBalance,
        language,
      ];
}
