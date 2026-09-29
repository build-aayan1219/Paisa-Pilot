import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _inrFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final NumberFormat _inrWithDecimals = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  /// Formats amount in INR with Indian comma grouping without decimals (e.g. ₹25,000)
  static String format(num amount) {
    return _inrFormat.format(amount);
  }

  /// Formats amount with decimals (e.g. ₹25,000.50)
  static String formatWithDecimals(num amount) {
    return _inrWithDecimals.format(amount);
  }

  /// Formats signed amount for transactions (+₹5,000 or -₹1,200)
  static String formatSigned(num amount, {required bool isIncome}) {
    final prefix = isIncome ? '+' : '-';
    final absAmount = amount.abs();
    return '$prefix${_inrFormat.format(absAmount)}';
  }

  /// Compact representation for charts or small badges (e.g. ₹25K, ₹1.5L, ₹1Cr)
  static String formatCompact(num amount) {
    final abs = amount.abs();
    final sign = amount < 0 ? '-' : '';

    if (abs >= 10000000) {
      final cr = abs / 10000000;
      return '$sign₹${cr.toStringAsFixed(cr.truncateToDouble() == cr ? 0 : 1)}Cr';
    } else if (abs >= 100000) {
      final l = abs / 100000;
      return '$sign₹${l.toStringAsFixed(l.truncateToDouble() == l ? 0 : 1)}L';
    } else if (abs >= 1000) {
      final k = abs / 1000;
      return '$sign₹${k.toStringAsFixed(k.truncateToDouble() == k ? 0 : 1)}K';
    } else {
      return '$sign₹$abs';
    }
  }
}
