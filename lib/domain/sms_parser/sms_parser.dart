class ParsedSmsResult {
  final double amount;
  final String direction; // 'debit' or 'credit'
  final String merchant;
  final DateTime date;
  final String? accountSuffix;
  final String bank;
  final bool isOtp;
  final String rawText;

  const ParsedSmsResult({
    required this.amount,
    required this.direction,
    required this.merchant,
    required this.date,
    this.accountSuffix,
    required this.bank,
    this.isOtp = false,
    required this.rawText,
  });

  bool get isIncome => direction.toLowerCase() == 'credit';
  bool get isExpense => !isIncome;
}

class SmsParser {
  SmsParser._();

  // OTP check regex
  static final RegExp _otpPattern = RegExp(
    r'\b(otp|one[\s-]?time[\s-]?password|verification code|secret code|do not share|valid for \d+ min)\b',
    caseSensitive: false,
  );

  // Bank detection
  static String detectBank(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('hdfc')) return 'HDFC';
    if (lower.contains('sbi') ||
        lower.contains('state bank') ||
        RegExp(r'\ba\/c\s+x{3,}', caseSensitive: false).hasMatch(text)) {
      return 'SBI';
    }
    if (lower.contains('icici') ||
        RegExp(r'\bacct\s+xx', caseSensitive: false).hasMatch(text)) {
      return 'ICICI';
    }
    if (lower.contains('axis')) return 'AXIS';
    if (lower.contains('kotak')) return 'KOTAK';
    return 'GENERIC';
  }

  /// Checks if message is an OTP or security code that MUST NOT be parsed into a transaction
  static bool isOtpMessage(String text) {
    return _otpPattern.hasMatch(text);
  }

  /// Parse a single SMS text string
  static ParsedSmsResult? parse(String text, {DateTime? fallbackDate}) {
    final cleanText = text.trim();
    if (cleanText.isEmpty) return null;

    // 1. Scrub and discard OTPs completely
    if (isOtpMessage(cleanText)) {
      return null;
    }

    final bank = detectBank(cleanText);
    final date = _extractDate(cleanText) ?? fallbackDate ?? DateTime.now();
    final accountSuffix = _extractAccountSuffix(cleanText);

    // 2. Try HDFC regex templates
    final hdfcResult = _parseHdfc(cleanText, bank, date, accountSuffix);
    if (hdfcResult != null) return hdfcResult;

    // 3. Try SBI regex templates
    final sbiResult = _parseSbi(cleanText, bank, date, accountSuffix);
    if (sbiResult != null) return sbiResult;

    // 4. Try ICICI regex templates
    final iciciResult = _parseIcici(cleanText, bank, date, accountSuffix);
    if (iciciResult != null) return iciciResult;

    // 5. Generic fallback parser
    return _parseGeneric(cleanText, bank, date, accountSuffix);
  }

  /// Parses multiple SMS messages separated by newlines
  static List<ParsedSmsResult> parseMultiple(String fullText) {
    // Split by double newline or typical SMS boundaries
    final lines = fullText.split(RegExp(r'\n\s*\n+'));
    final results = <ParsedSmsResult>[];

    for (final block in lines) {
      final trimmed = block.trim();
      if (trimmed.isEmpty) continue;
      final parsed = parse(trimmed);
      if (parsed != null) {
        results.add(parsed);
      }
    }

    return results;
  }

  // --- HDFC PARSER ---
  static ParsedSmsResult? _parseHdfc(
      String text, String bank, DateTime date, String? accSuffix) {
    // Ex: Sent Rs.450.00 from HDFC Bank A/C **8832 to SWIGGY on 24-09-26 via UPI
    final sentMatch = RegExp(
      r'sent\s+(?:rs\.?|inr)\s*([\d,]+(?:\.\d{1,2})?)\s+from\s+hdfc\s+bank.*?to\s+([A-Za-z0-9\s*_-]+?)(?:\s+on|\s+via|\.|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (sentMatch != null) {
      final amount = _cleanAmount(sentMatch.group(1));
      final merchant = _cleanMerchant(sentMatch.group(2));
      return ParsedSmsResult(
        amount: amount,
        direction: 'debit',
        merchant: merchant,
        date: date,
        accountSuffix: accSuffix,
        bank: 'HDFC',
        rawText: text,
      );
    }

    // Ex: Rs. 25000.00 credited to HDFC Bank A/C **8832 on 01-09-26 by TECHCORP
    final creditMatch = RegExp(
      r'(?:rs\.?|inr)\s*([\d,]+(?:\.\d{1,2})?)\s+credited\s+to\s+hdfc\s+bank.*?(?:by|from)\s+([A-Za-z0-9\s*_-]+?)(?:\s+on|\s+via|\.|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (creditMatch != null) {
      final amount = _cleanAmount(creditMatch.group(1));
      final merchant = _cleanMerchant(creditMatch.group(2));
      return ParsedSmsResult(
        amount: amount,
        direction: 'credit',
        merchant: merchant,
        date: date,
        accountSuffix: accSuffix,
        bank: 'HDFC',
        rawText: text,
      );
    }

    // Ex: Alert: Rs 199.00 debited from HDFC Bank A/C **8832 on 14-Sep-26 towards NETFLIX
    final debitMatch = RegExp(
      r'(?:rs\.?|inr)\s*([\d,]+(?:\.\d{1,2})?)\s+debited\s+from\s+hdfc\s+bank.*?(?:towards|to|at)\s+([A-Za-z0-9\s*_-]+?)(?:\s+on|\s+via|\.|\s+bal|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (debitMatch != null) {
      final amount = _cleanAmount(debitMatch.group(1));
      final merchant = _cleanMerchant(debitMatch.group(2));
      return ParsedSmsResult(
        amount: amount,
        direction: 'debit',
        merchant: merchant,
        date: date,
        accountSuffix: accSuffix,
        bank: 'HDFC',
        rawText: text,
      );
    }

    return null;
  }

  // --- SBI PARSER ---
  static ParsedSmsResult? _parseSbi(
      String text, String bank, DateTime date, String? accSuffix) {
    // Ex: Dear SBI User, your A/C ending 4921 has been debited by Rs 380.00 on 22Sep26 transfer to Zomato
    final sbiDebit = RegExp(
      r'debited\s+(?:by\s+)?(?:rs\.?|inr)\s*([\d,]+(?:\.\d{1,2})?).*?(?:transfer\s+to|to|at)\s+([A-Za-z0-9\s*_-]+?)(?:\s+upi|\s+ref|\.|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (sbiDebit != null && (bank == 'SBI' || text.toLowerCase().contains('sbi') || text.toLowerCase().contains('a/c'))) {
      final amount = _cleanAmount(sbiDebit.group(1));
      final merchant = _cleanMerchant(sbiDebit.group(2));
      return ParsedSmsResult(
        amount: amount,
        direction: 'debit',
        merchant: merchant,
        date: date,
        accountSuffix: accSuffix,
        bank: 'SBI',
        rawText: text,
      );
    }

    // Ex: Your A/C XXXXXXXX4921 is credited by Rs 25,000.00 on 01Sep26 by TRANSFER from TECHCORP
    final sbiCredit = RegExp(
      r'credited\s+(?:by\s+)?(?:rs\.?|inr)\s*([\d,]+(?:\.\d{1,2})?).*?(?:from|by)\s+([A-Za-z0-9\s*_-]+?)(?:\s+on|\s+ref|\.|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (sbiCredit != null && (bank == 'SBI' || text.toLowerCase().contains('sbi'))) {
      final amount = _cleanAmount(sbiCredit.group(1));
      final merchant = _cleanMerchant(sbiCredit.group(2));
      return ParsedSmsResult(
        amount: amount,
        direction: 'credit',
        merchant: merchant,
        date: date,
        accountSuffix: accSuffix,
        bank: 'SBI',
        rawText: text,
      );
    }

    return null;
  }

  // --- ICICI PARSER ---
  static ParsedSmsResult? _parseIcici(
      String text, String bank, DateTime date, String? accSuffix) {
    // Ex: Dear Customer, your Acct XX1029 is debited for INR 1,250.00 on 18-Sep-26 towards CULT FIT.
    final iciciDebit = RegExp(
      r'debited\s+(?:for\s+)?(?:inr|rs\.?)\s*([\d,]+(?:\.\d{1,2})?).*?(?:towards|to|at)\s+([A-Za-z0-9\s*_-]+?)(?:\.|\s+upi|\s+ref|$)',
      caseSensitive: false,
    ).firstMatch(text);

    final isIciciStyle = bank == 'ICICI' ||
        text.toLowerCase().contains('icici') ||
        RegExp(r'\bacct\s+xx\d+', caseSensitive: false).hasMatch(text);

    if (iciciDebit != null && isIciciStyle) {
      final amount = _cleanAmount(iciciDebit.group(1));
      final merchant = _cleanMerchant(iciciDebit.group(2));
      return ParsedSmsResult(
        amount: amount,
        direction: 'debit',
        merchant: merchant,
        date: date,
        accountSuffix: accSuffix,
        bank: 'ICICI',
        rawText: text,
      );
    }

    // Ex: Acct XX1029 credited with INR 5,000.00 on 15-Sep-26 by AAYAN SHAIKH
    final iciciCredit = RegExp(
      r'credited\s+(?:with\s+)?(?:inr|rs\.?)\s*([\d,]+(?:\.\d{1,2})?).*?(?:by|from)\s+([A-Za-z0-9\s*_-]+?)(?:\s+upi|\s+ref|\.|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (iciciCredit != null && isIciciStyle) {
      final amount = _cleanAmount(iciciCredit.group(1));
      final merchant = _cleanMerchant(iciciCredit.group(2));
      return ParsedSmsResult(
        amount: amount,
        direction: 'credit',
        merchant: merchant,
        date: date,
        accountSuffix: accSuffix,
        bank: 'ICICI',
        rawText: text,
      );
    }

    // Ex: INR 350.00 spent on ICICI Bank Card ending 5012 at AMAZON INDIA on 12-Sep-26
    final iciciSpent = RegExp(
      r'(?:inr|rs\.?)\s*([\d,]+(?:\.\d{1,2})?)\s+spent\s+on\s+.*?at\s+([A-Za-z0-9\s*_-]+?)(?:\s+on|\.|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (iciciSpent != null) {
      final amount = _cleanAmount(iciciSpent.group(1));
      final merchant = _cleanMerchant(iciciSpent.group(2));
      return ParsedSmsResult(
        amount: amount,
        direction: 'debit',
        merchant: merchant,
        date: date,
        accountSuffix: accSuffix,
        bank: 'ICICI',
        rawText: text,
      );
    }

    return null;
  }

  // --- GENERIC PARSER ---
  static ParsedSmsResult? _parseGeneric(
      String text, String bank, DateTime date, String? accSuffix) {
    // 1. Determine direction
    final isCredit = RegExp(r'\b(credited|received|deposit|added)\b', caseSensitive: false).hasMatch(text);
    final isDebit = RegExp(r'\b(debited|sent|paid|spent|withdrawn)\b', caseSensitive: false).hasMatch(text);

    if (!isCredit && !isDebit) return null;
    final direction = isCredit ? 'credit' : 'debit';

    // 2. Extract amount
    final amtMatch = RegExp(
      r'(?:rs\.?|inr|\u20B9)\s*([\d,]+(?:\.\d{1,2})?)',
      caseSensitive: false,
    ).firstMatch(text);

    if (amtMatch == null) return null;
    final amount = _cleanAmount(amtMatch.group(1));
    if (amount <= 0) return null;

    // 3. Extract merchant/payee
    String merchant = 'Unknown Merchant';
    final payeeMatch = RegExp(
      r'(?:to|towards|at|info:|vpa|from|by)\s+([A-Za-z0-9\s*_-]{2,35}?)(?:\s+on|\s+via|\s+ref|\.|\s+using|$)',
      caseSensitive: false,
    ).firstMatch(text);

    if (payeeMatch != null) {
      merchant = _cleanMerchant(payeeMatch.group(1));
    }

    return ParsedSmsResult(
      amount: amount,
      direction: direction,
      merchant: merchant,
      date: date,
      accountSuffix: accSuffix,
      bank: bank,
      rawText: text,
    );
  }

  // --- HELPERS ---

  static double _cleanAmount(String? raw) {
    if (raw == null) return 0.0;
    final cleaned = raw.replaceAll(',', '').trim();
    return double.tryParse(cleaned) ?? 0.0;
  }

  static String _cleanMerchant(String? raw) {
    if (raw == null) return 'Unknown';
    String cleaned = raw.trim();
    // Remove trailing punctuation or leftover words
    cleaned = cleaned.replaceAll(RegExp(r'[\.\,\;]+$'), '');
    cleaned = cleaned.replaceAll(RegExp(r'^(UPI|IMPS|NEFT|VPA|POS|INFO)\/?', caseSensitive: false), '');
    cleaned = cleaned.replaceAll(RegExp(r'^(transfer\s+from|from|by)\s+', caseSensitive: false), '');
    cleaned = cleaned.replaceAll(RegExp(r'\s+(upi|upi\s+ref.*|ref.*)$', caseSensitive: false), '');
    cleaned = cleaned.trim();
    return cleaned.isEmpty ? 'Unknown' : cleaned;
  }

  static String? _extractAccountSuffix(String text) {
    // Look for A/C **8832 or ending 4921 or XX1029 or ..4921
    final match = RegExp(
      r'(?:a\/c|acct|account|card)\s*(?:ending\s+|no\.?\s*)?(?:[\*X\.]+)?(\d{3,4})',
      caseSensitive: false,
    ).firstMatch(text);
    return match?.group(1);
  }

  static DateTime? _extractDate(String text) {
    // 24-09-26 or 24/09/2026 or 24-Sep-26 or 24Sep26
    final dateMatch = RegExp(
      r'\b(\d{1,2})[-/]([A-Za-z]{3}|\d{1,2})[-/](\d{2,4})\b',
    ).firstMatch(text);

    if (dateMatch != null) {
      final day = int.tryParse(dateMatch.group(1) ?? '') ?? 1;
      final monthStr = dateMatch.group(2) ?? '';
      final yearStr = dateMatch.group(3) ?? '';
      int year = int.tryParse(yearStr) ?? 2026;
      if (year < 100) year += 2000;

      int month = _parseMonthString(monthStr);
      try {
        return DateTime(year, month, day);
      } catch (_) {}
    }

    // e.g. 22Sep26
    final compactMatch = RegExp(
      r'\b(\d{1,2})([A-Za-z]{3})(\d{2,4})\b',
    ).firstMatch(text);

    if (compactMatch != null) {
      final day = int.tryParse(compactMatch.group(1) ?? '') ?? 1;
      final monthStr = compactMatch.group(2) ?? '';
      int year = int.tryParse(compactMatch.group(3) ?? '') ?? 2026;
      if (year < 100) year += 2000;
      int month = _parseMonthString(monthStr);
      try {
        return DateTime(year, month, day);
      } catch (_) {}
    }

    return null;
  }

  static int _parseMonthString(String monthStr) {
    final lower = monthStr.toLowerCase();
    const months = {
      'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6,
      'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
    };
    if (months.containsKey(lower)) {
      return months[lower]!;
    }
    return int.tryParse(monthStr) ?? 1;
  }
}
