import 'package:flutter/material.dart';
import '../../core/tokens/app_colors.dart';

enum TransactionCategory {
  foodDining('Food & Dining', AppColors.chartAmber, Icons.restaurant_rounded),
  groceries('Groceries', AppColors.emerald, Icons.local_grocery_store_rounded),
  rentHousing('Rent & Housing', AppColors.indigo, Icons.home_rounded),
  billsUtilities('Bills & Utilities', AppColors.sky, Icons.bolt_rounded),
  transport('Transport & Commute', AppColors.chartViolet, Icons.directions_car_rounded),
  shopping('Shopping', AppColors.chartPink, Icons.shopping_bag_rounded),
  entertainment('Subscriptions & Entertainment', AppColors.chartSlate, Icons.movie_rounded),
  health('Health & Medical', AppColors.rose, Icons.medical_services_rounded),
  education('Education & Upskilling', Color(0xFF10B981), Icons.school_rounded),
  investments('Investments & Savings', Color(0xFF06B6D4), Icons.trending_up_rounded),
  personalCare('Personal Care', Color(0xFFEC4899), Icons.face_rounded),
  salary('Salary & Income', AppColors.emerald, Icons.account_balance_wallet_rounded),
  others('Other Expenses', AppColors.chartSlate, Icons.more_horiz_rounded);

  final String displayName;
  final Color color;
  final IconData icon;

  const TransactionCategory(this.displayName, this.color, this.icon);

  static TransactionCategory fromString(String? name) {
    if (name == null || name.isEmpty) return TransactionCategory.others;
    for (final cat in TransactionCategory.values) {
      if (cat.name.toLowerCase() == name.toLowerCase() ||
          cat.displayName.toLowerCase() == name.toLowerCase()) {
        return cat;
      }
    }
    return TransactionCategory.others;
  }
}
