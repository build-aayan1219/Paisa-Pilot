import '../models/category.dart';

class MerchantDictionary {
  MerchantDictionary._();

  static const Map<String, TransactionCategory> dictionary = {
    // --- Food & Dining (35) ---
    'swiggy': TransactionCategory.foodDining,
    'zomato': TransactionCategory.foodDining,
    'mcdonald': TransactionCategory.foodDining,
    "mcdonald's": TransactionCategory.foodDining,
    'domino': TransactionCategory.foodDining,
    "domino's": TransactionCategory.foodDining,
    'pizza hut': TransactionCategory.foodDining,
    'kfc': TransactionCategory.foodDining,
    'burger king': TransactionCategory.foodDining,
    'subway': TransactionCategory.foodDining,
    'starbucks': TransactionCategory.foodDining,
    'chai point': TransactionCategory.foodDining,
    'chaayos': TransactionCategory.foodDining,
    'third wave coffee': TransactionCategory.foodDining,
    'blue tokai': TransactionCategory.foodDining,
    'haldiram': TransactionCategory.foodDining,
    'bikanervala': TransactionCategory.foodDining,
    'barbeque nation': TransactionCategory.foodDining,
    'wow momo': TransactionCategory.foodDining,
    'behrouz': TransactionCategory.foodDining,
    'faasos': TransactionCategory.foodDining,
    'eatclub': TransactionCategory.foodDining,
    'box8': TransactionCategory.foodDining,
    'freshmenu': TransactionCategory.foodDining,
    'annapurna mess': TransactionCategory.foodDining,
    'mess': TransactionCategory.foodDining,
    'canteen': TransactionCategory.foodDining,
    'bakery': TransactionCategory.foodDining,
    'cafe': TransactionCategory.foodDining,
    'restaurant': TransactionCategory.foodDining,
    'dhabha': TransactionCategory.foodDining,
    'sweet': TransactionCategory.foodDining,
    'tea': TransactionCategory.foodDining,
    'coffee': TransactionCategory.foodDining,
    'biryani': TransactionCategory.foodDining,

    // --- Groceries & Quick Commerce (16) ---
    'blinkit': TransactionCategory.groceries,
    'zepto': TransactionCategory.groceries,
    'instamart': TransactionCategory.groceries,
    'swiggy instamart': TransactionCategory.groceries,
    'bigbasket': TransactionCategory.groceries,
    'bbdaily': TransactionCategory.groceries,
    'dmart': TransactionCategory.groceries,
    'reliance fresh': TransactionCategory.groceries,
    'reliance smart': TransactionCategory.groceries,
    'nature basket': TransactionCategory.groceries,
    "nature's basket": TransactionCategory.groceries,
    'spencers': TransactionCategory.groceries,
    'dunzo': TransactionCategory.groceries,
    'milkbasket': TransactionCategory.groceries,
    'country delight': TransactionCategory.groceries,
    'jiomart': TransactionCategory.groceries,

    // --- Shopping & E-Commerce (22) ---
    'amazon': TransactionCategory.shopping,
    'flipkart': TransactionCategory.shopping,
    'myntra': TransactionCategory.shopping,
    'ajio': TransactionCategory.shopping,
    'nykaa': TransactionCategory.shopping,
    'meesho': TransactionCategory.shopping,
    'tata cliq': TransactionCategory.shopping,
    'zara': TransactionCategory.shopping,
    'h&m': TransactionCategory.shopping,
    'uniqlo': TransactionCategory.shopping,
    'decathlon': TransactionCategory.shopping,
    'croma': TransactionCategory.shopping,
    'reliance digital': TransactionCategory.shopping,
    'apple store': TransactionCategory.shopping,
    'apple': TransactionCategory.shopping,
    'lenskart': TransactionCategory.shopping,
    'bewakoof': TransactionCategory.shopping,
    'snitch': TransactionCategory.shopping,
    'urbanic': TransactionCategory.shopping,
    'westside': TransactionCategory.shopping,
    'pantaloons': TransactionCategory.shopping,
    'shoppers stop': TransactionCategory.shopping,

    // --- Transport & Travel (18) ---
    'uber': TransactionCategory.transport,
    'ola': TransactionCategory.transport,
    'rapido': TransactionCategory.transport,
    'blusmart': TransactionCategory.transport,
    'irctc': TransactionCategory.transport,
    'makemytrip': TransactionCategory.transport,
    'goibibo': TransactionCategory.transport,
    'yatra': TransactionCategory.transport,
    'redbus': TransactionCategory.transport,
    'abhibus': TransactionCategory.transport,
    'delhi metro': TransactionCategory.transport,
    'namma metro': TransactionCategory.transport,
    'metro': TransactionCategory.transport,
    'fastag': TransactionCategory.transport,
    'indian oil': TransactionCategory.transport,
    'hpcl': TransactionCategory.transport,
    'bpcl': TransactionCategory.transport,
    'shell petrol': TransactionCategory.transport,

    // --- Rent & Housing (10) ---
    'nestaway': TransactionCategory.rentHousing,
    'nobroker': TransactionCategory.rentHousing,
    'stanza living': TransactionCategory.rentHousing,
    'zolo': TransactionCategory.rentHousing,
    'colive': TransactionCategory.rentHousing,
    'rentomojo': TransactionCategory.rentHousing,
    'furlenco': TransactionCategory.rentHousing,
    'urban company': TransactionCategory.rentHousing,
    'urbanclap': TransactionCategory.rentHousing,
    'pg rent': TransactionCategory.rentHousing,

    // --- Bills & Utilities (14) ---
    'airtel': TransactionCategory.billsUtilities,
    'jio': TransactionCategory.billsUtilities,
    'vodafone': TransactionCategory.billsUtilities,
    'vi': TransactionCategory.billsUtilities,
    'act fibernet': TransactionCategory.billsUtilities,
    'hathway': TransactionCategory.billsUtilities,
    'bescom': TransactionCategory.billsUtilities,
    'tata power': TransactionCategory.billsUtilities,
    'adani electricity': TransactionCategory.billsUtilities,
    'mgl': TransactionCategory.billsUtilities,
    'igl': TransactionCategory.billsUtilities,
    'indane': TransactionCategory.billsUtilities,
    'hp gas': TransactionCategory.billsUtilities,
    'bharat gas': TransactionCategory.billsUtilities,

    // --- Entertainment & Subscriptions (14) ---
    'netflix': TransactionCategory.entertainment,
    'spotify': TransactionCategory.entertainment,
    'disney+ hotstar': TransactionCategory.entertainment,
    'hotstar': TransactionCategory.entertainment,
    'prime video': TransactionCategory.entertainment,
    'amazon prime': TransactionCategory.entertainment,
    'youtube': TransactionCategory.entertainment,
    'apple music': TransactionCategory.entertainment,
    'bookmyshow': TransactionCategory.entertainment,
    'pvr': TransactionCategory.entertainment,
    'inox': TransactionCategory.entertainment,
    'sonyliv': TransactionCategory.entertainment,
    'zee5': TransactionCategory.entertainment,
    'audible': TransactionCategory.entertainment,

    // --- Health & Wellness (12) ---
    'cult.fit': TransactionCategory.health,
    'curefit': TransactionCategory.health,
    'apollo pharmacy': TransactionCategory.health,
    'apollo': TransactionCategory.health,
    'netmeds': TransactionCategory.health,
    'tata 1mg': TransactionCategory.health,
    'pharmeasy': TransactionCategory.health,
    'medplus': TransactionCategory.health,
    'practo': TransactionCategory.health,
    'dr lal pathlabs': TransactionCategory.health,
    'srl diagnostics': TransactionCategory.health,
    'gym': TransactionCategory.health,

    // --- Education & Upskilling (10) ---
    'coursera': TransactionCategory.education,
    'udemy': TransactionCategory.education,
    'edx': TransactionCategory.education,
    'unacademy': TransactionCategory.education,
    'physicswallah': TransactionCategory.education,
    'scaler': TransactionCategory.education,
    'upgrad': TransactionCategory.education,
    'duolingo': TransactionCategory.education,
    'leetcode': TransactionCategory.education,
    'skillshare': TransactionCategory.education,

    // --- Investments & Savings (10) ---
    'zerodha': TransactionCategory.investments,
    'groww': TransactionCategory.investments,
    'angelone': TransactionCategory.investments,
    'upstox': TransactionCategory.investments,
    'indmoney': TransactionCategory.investments,
    'kuvera': TransactionCategory.investments,
    'smallcase': TransactionCategory.investments,
    'wint wealth': TransactionCategory.investments,
    'jar app': TransactionCategory.investments,
    'coin zerodha': TransactionCategory.investments,

    // --- Salary & Income (8) ---
    'techcorp': TransactionCategory.salary,
    'infosys': TransactionCategory.salary,
    'tcs': TransactionCategory.salary,
    'wipro': TransactionCategory.salary,
    'accenture': TransactionCategory.salary,
    'cognizant': TransactionCategory.salary,
    'salary': TransactionCategory.salary,
    'stipend': TransactionCategory.salary,
  };

  static TransactionCategory? lookup(String merchantNorm) {
    final lower = merchantNorm.toLowerCase().trim();

    // 1. Direct match
    if (dictionary.containsKey(lower)) {
      return dictionary[lower];
    }

    // 2. Substring match
    for (final entry in dictionary.entries) {
      if (lower.contains(entry.key) || entry.key.contains(lower)) {
        return entry.value;
      }
    }

    return null;
  }
}
