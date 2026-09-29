class MerchantNormalizer {
  MerchantNormalizer._();

  // Known clean aliases
  static const Map<String, String> _knownAliases = {
    'swiggy': 'Swiggy',
    'zomato': 'Zomato',
    'uber': 'Uber',
    'ola': 'Ola',
    'rapido': 'Rapido',
    'blinkit': 'Blinkit',
    'zepto': 'Zepto',
    'instamart': 'Swiggy Instamart',
    'bigbasket': 'BigBasket',
    'amazon': 'Amazon',
    'flipkart': 'Flipkart',
    'myntra': 'Myntra',
    'nykaa': 'Nykaa',
    'meesho': 'Meesho',
    'ajio': 'Ajio',
    'netflix': 'Netflix',
    'spotify': 'Spotify',
    'hotstar': 'Disney+ Hotstar',
    'bookmyshow': 'BookMyShow',
    'irctc': 'IRCTC',
    'makemytrip': 'MakeMyTrip',
    'cultfit': 'Cult.Fit',
    'cult fit': 'Cult.Fit',
    'curefit': 'Cult.Fit',
    'airtel': 'Airtel',
    'jio': 'Jio',
    'nestaway': 'NestAway',
    'nobroker': 'NoBroker',
    'annapurna': 'Annapurna Mess',
    'chai point': 'Chai Point',
    'chaayos': 'Chaayos',
    'starbucks': 'Starbucks',
    'mcdonalds': "McDonald's",
    'mcdonald': "McDonald's",
    'dominos': "Domino's",
    'kfc': 'KFC',
    'burger king': 'Burger King',
    'apollo': 'Apollo Pharmacy',
    'netmeds': 'Netmeds',
    '1mg': 'Tata 1mg',
    'zerodha': 'Zerodha',
    'groww': 'Groww',
  };

  static final RegExp _noiseWords = RegExp(
    r'\b(pvt|ltd|limited|services|service|india|technologies|solutions|retail|store|stores|online|order|orders|pay|payments|payment|upi|vpa|pos|bill|charges|care|center|centre|bangalore|blr|mumbai|delhi|gurgaon|hyderabad|pune|chennai|noida|kolkata|auth|authorized)\b',
    caseSensitive: false,
  );

  static final RegExp _cleanRegex = RegExp(r'[^a-zA-Z0-9\s]');

  /// Normalizes a raw bank merchant / UPI string to a clean human-readable name
  /// E.g. "SWIGGY*ORDER 8842 BANGALORE" -> "Swiggy"
  /// "UPI/RENT/NESTAWAY PG HOUSING BANGALORE" -> "NestAway"
  /// "UBER INDIA SYSTEMS PVT LTD" -> "Uber"
  static String normalize(String raw) {
    if (raw.trim().isEmpty) return 'Unknown';

    final lower = raw.toLowerCase().trim();

    // 1. Direct alias check
    for (final entry in _knownAliases.entries) {
      if (lower.contains(entry.key)) {
        return entry.value;
      }
    }

    // 2. Strip standard prefixes like UPI/, NEFT/, IMPS/, VPA/
    String cleaned = raw.replaceAll(RegExp(r'^(UPI|NEFT|IMPS|RTGS|VPA|POS|INFO|CARD|TXN)\/?', caseSensitive: false), '');
    cleaned = cleaned.replaceAll(RegExp(r'^(to|towards|at|from|by)\s+', caseSensitive: false), '');

    // 3. Remove punctuation and numbers
    cleaned = cleaned.replaceAll(_cleanRegex, ' ');
    cleaned = cleaned.replaceAll(RegExp(r'\b\d+\b'), ' ');

    // 4. Remove corporate & city noise words
    cleaned = cleaned.replaceAll(_noiseWords, ' ');

    // 5. Condense whitespaces
    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' ').trim();

    if (cleaned.isEmpty) return 'Other Payee';

    // 6. Title case the first 1-3 words
    final words = cleaned.split(' ').take(3).map((w) {
      if (w.isEmpty) return '';
      return w[0].toUpperCase() + w.substring(1).toLowerCase();
    }).where((w) => w.isNotEmpty).toList();

    return words.isEmpty ? 'Other Payee' : words.join(' ');
  }
}
