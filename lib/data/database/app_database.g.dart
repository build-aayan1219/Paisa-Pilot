// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _incomeCycleDayMeta = const VerificationMeta(
    'incomeCycleDay',
  );
  @override
  late final GeneratedColumn<int> incomeCycleDay = GeneratedColumn<int>(
    'income_cycle_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthlyIncomeMeta = const VerificationMeta(
    'monthlyIncome',
  );
  @override
  late final GeneratedColumn<double> monthlyIncome = GeneratedColumn<double>(
    'monthly_income',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingBalanceMeta = const VerificationMeta(
    'openingBalance',
  );
  @override
  late final GeneratedColumn<double> openingBalance = GeneratedColumn<double>(
    'opening_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    incomeCycleDay,
    monthlyIncome,
    openingBalance,
    language,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('income_cycle_day')) {
      context.handle(
        _incomeCycleDayMeta,
        incomeCycleDay.isAcceptableOrUnknown(
          data['income_cycle_day']!,
          _incomeCycleDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_incomeCycleDayMeta);
    }
    if (data.containsKey('monthly_income')) {
      context.handle(
        _monthlyIncomeMeta,
        monthlyIncome.isAcceptableOrUnknown(
          data['monthly_income']!,
          _monthlyIncomeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monthlyIncomeMeta);
    }
    if (data.containsKey('opening_balance')) {
      context.handle(
        _openingBalanceMeta,
        openingBalance.isAcceptableOrUnknown(
          data['opening_balance']!,
          _openingBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingBalanceMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      incomeCycleDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}income_cycle_day'],
      )!,
      monthlyIncome: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_income'],
      )!,
      openingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}opening_balance'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String name;
  final int incomeCycleDay;
  final double monthlyIncome;
  final double openingBalance;
  final String language;
  const User({
    required this.id,
    required this.name,
    required this.incomeCycleDay,
    required this.monthlyIncome,
    required this.openingBalance,
    required this.language,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['income_cycle_day'] = Variable<int>(incomeCycleDay);
    map['monthly_income'] = Variable<double>(monthlyIncome);
    map['opening_balance'] = Variable<double>(openingBalance);
    map['language'] = Variable<String>(language);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      incomeCycleDay: Value(incomeCycleDay),
      monthlyIncome: Value(monthlyIncome),
      openingBalance: Value(openingBalance),
      language: Value(language),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      incomeCycleDay: serializer.fromJson<int>(json['incomeCycleDay']),
      monthlyIncome: serializer.fromJson<double>(json['monthlyIncome']),
      openingBalance: serializer.fromJson<double>(json['openingBalance']),
      language: serializer.fromJson<String>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'incomeCycleDay': serializer.toJson<int>(incomeCycleDay),
      'monthlyIncome': serializer.toJson<double>(monthlyIncome),
      'openingBalance': serializer.toJson<double>(openingBalance),
      'language': serializer.toJson<String>(language),
    };
  }

  User copyWith({
    String? id,
    String? name,
    int? incomeCycleDay,
    double? monthlyIncome,
    double? openingBalance,
    String? language,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    incomeCycleDay: incomeCycleDay ?? this.incomeCycleDay,
    monthlyIncome: monthlyIncome ?? this.monthlyIncome,
    openingBalance: openingBalance ?? this.openingBalance,
    language: language ?? this.language,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      incomeCycleDay: data.incomeCycleDay.present
          ? data.incomeCycleDay.value
          : this.incomeCycleDay,
      monthlyIncome: data.monthlyIncome.present
          ? data.monthlyIncome.value
          : this.monthlyIncome,
      openingBalance: data.openingBalance.present
          ? data.openingBalance.value
          : this.openingBalance,
      language: data.language.present ? data.language.value : this.language,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('incomeCycleDay: $incomeCycleDay, ')
          ..write('monthlyIncome: $monthlyIncome, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    incomeCycleDay,
    monthlyIncome,
    openingBalance,
    language,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.incomeCycleDay == this.incomeCycleDay &&
          other.monthlyIncome == this.monthlyIncome &&
          other.openingBalance == this.openingBalance &&
          other.language == this.language);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> incomeCycleDay;
  final Value<double> monthlyIncome;
  final Value<double> openingBalance;
  final Value<String> language;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.incomeCycleDay = const Value.absent(),
    this.monthlyIncome = const Value.absent(),
    this.openingBalance = const Value.absent(),
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String name,
    required int incomeCycleDay,
    required double monthlyIncome,
    required double openingBalance,
    this.language = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       incomeCycleDay = Value(incomeCycleDay),
       monthlyIncome = Value(monthlyIncome),
       openingBalance = Value(openingBalance);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? incomeCycleDay,
    Expression<double>? monthlyIncome,
    Expression<double>? openingBalance,
    Expression<String>? language,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (incomeCycleDay != null) 'income_cycle_day': incomeCycleDay,
      if (monthlyIncome != null) 'monthly_income': monthlyIncome,
      if (openingBalance != null) 'opening_balance': openingBalance,
      if (language != null) 'language': language,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? incomeCycleDay,
    Value<double>? monthlyIncome,
    Value<double>? openingBalance,
    Value<String>? language,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      incomeCycleDay: incomeCycleDay ?? this.incomeCycleDay,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      openingBalance: openingBalance ?? this.openingBalance,
      language: language ?? this.language,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (incomeCycleDay.present) {
      map['income_cycle_day'] = Variable<int>(incomeCycleDay.value);
    }
    if (monthlyIncome.present) {
      map['monthly_income'] = Variable<double>(monthlyIncome.value);
    }
    if (openingBalance.present) {
      map['opening_balance'] = Variable<double>(openingBalance.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('incomeCycleDay: $incomeCycleDay, ')
          ..write('monthlyIncome: $monthlyIncome, ')
          ..write('openingBalance: $openingBalance, ')
          ..write('language: $language, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tsMeta = const VerificationMeta('ts');
  @override
  late final GeneratedColumn<DateTime> ts = GeneratedColumn<DateTime>(
    'ts',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantRawMeta = const VerificationMeta(
    'merchantRaw',
  );
  @override
  late final GeneratedColumn<String> merchantRaw = GeneratedColumn<String>(
    'merchant_raw',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantNormMeta = const VerificationMeta(
    'merchantNorm',
  );
  @override
  late final GeneratedColumn<String> merchantNorm = GeneratedColumn<String>(
    'merchant_norm',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRecurringMeta = const VerificationMeta(
    'isRecurring',
  );
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
    'is_recurring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recurring" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    ts,
    amount,
    direction,
    merchantRaw,
    merchantNorm,
    category,
    confidence,
    isRecurring,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('ts')) {
      context.handle(_tsMeta, ts.isAcceptableOrUnknown(data['ts']!, _tsMeta));
    } else if (isInserting) {
      context.missing(_tsMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('merchant_raw')) {
      context.handle(
        _merchantRawMeta,
        merchantRaw.isAcceptableOrUnknown(
          data['merchant_raw']!,
          _merchantRawMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantRawMeta);
    }
    if (data.containsKey('merchant_norm')) {
      context.handle(
        _merchantNormMeta,
        merchantNorm.isAcceptableOrUnknown(
          data['merchant_norm']!,
          _merchantNormMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantNormMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
        _isRecurringMeta,
        isRecurring.isAcceptableOrUnknown(
          data['is_recurring']!,
          _isRecurringMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      ts: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ts'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      merchantRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_raw'],
      )!,
      merchantNorm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_norm'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      isRecurring: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_recurring'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final String id;
  final String userId;
  final DateTime ts;
  final double amount;
  final String direction;
  final String merchantRaw;
  final String merchantNorm;
  final String category;
  final double confidence;
  final bool isRecurring;
  final String source;
  const Transaction({
    required this.id,
    required this.userId,
    required this.ts,
    required this.amount,
    required this.direction,
    required this.merchantRaw,
    required this.merchantNorm,
    required this.category,
    required this.confidence,
    required this.isRecurring,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['ts'] = Variable<DateTime>(ts);
    map['amount'] = Variable<double>(amount);
    map['direction'] = Variable<String>(direction);
    map['merchant_raw'] = Variable<String>(merchantRaw);
    map['merchant_norm'] = Variable<String>(merchantNorm);
    map['category'] = Variable<String>(category);
    map['confidence'] = Variable<double>(confidence);
    map['is_recurring'] = Variable<bool>(isRecurring);
    map['source'] = Variable<String>(source);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      userId: Value(userId),
      ts: Value(ts),
      amount: Value(amount),
      direction: Value(direction),
      merchantRaw: Value(merchantRaw),
      merchantNorm: Value(merchantNorm),
      category: Value(category),
      confidence: Value(confidence),
      isRecurring: Value(isRecurring),
      source: Value(source),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      ts: serializer.fromJson<DateTime>(json['ts']),
      amount: serializer.fromJson<double>(json['amount']),
      direction: serializer.fromJson<String>(json['direction']),
      merchantRaw: serializer.fromJson<String>(json['merchantRaw']),
      merchantNorm: serializer.fromJson<String>(json['merchantNorm']),
      category: serializer.fromJson<String>(json['category']),
      confidence: serializer.fromJson<double>(json['confidence']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'ts': serializer.toJson<DateTime>(ts),
      'amount': serializer.toJson<double>(amount),
      'direction': serializer.toJson<String>(direction),
      'merchantRaw': serializer.toJson<String>(merchantRaw),
      'merchantNorm': serializer.toJson<String>(merchantNorm),
      'category': serializer.toJson<String>(category),
      'confidence': serializer.toJson<double>(confidence),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'source': serializer.toJson<String>(source),
    };
  }

  Transaction copyWith({
    String? id,
    String? userId,
    DateTime? ts,
    double? amount,
    String? direction,
    String? merchantRaw,
    String? merchantNorm,
    String? category,
    double? confidence,
    bool? isRecurring,
    String? source,
  }) => Transaction(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    ts: ts ?? this.ts,
    amount: amount ?? this.amount,
    direction: direction ?? this.direction,
    merchantRaw: merchantRaw ?? this.merchantRaw,
    merchantNorm: merchantNorm ?? this.merchantNorm,
    category: category ?? this.category,
    confidence: confidence ?? this.confidence,
    isRecurring: isRecurring ?? this.isRecurring,
    source: source ?? this.source,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      ts: data.ts.present ? data.ts.value : this.ts,
      amount: data.amount.present ? data.amount.value : this.amount,
      direction: data.direction.present ? data.direction.value : this.direction,
      merchantRaw: data.merchantRaw.present
          ? data.merchantRaw.value
          : this.merchantRaw,
      merchantNorm: data.merchantNorm.present
          ? data.merchantNorm.value
          : this.merchantNorm,
      category: data.category.present ? data.category.value : this.category,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      isRecurring: data.isRecurring.present
          ? data.isRecurring.value
          : this.isRecurring,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('ts: $ts, ')
          ..write('amount: $amount, ')
          ..write('direction: $direction, ')
          ..write('merchantRaw: $merchantRaw, ')
          ..write('merchantNorm: $merchantNorm, ')
          ..write('category: $category, ')
          ..write('confidence: $confidence, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    ts,
    amount,
    direction,
    merchantRaw,
    merchantNorm,
    category,
    confidence,
    isRecurring,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.ts == this.ts &&
          other.amount == this.amount &&
          other.direction == this.direction &&
          other.merchantRaw == this.merchantRaw &&
          other.merchantNorm == this.merchantNorm &&
          other.category == this.category &&
          other.confidence == this.confidence &&
          other.isRecurring == this.isRecurring &&
          other.source == this.source);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> ts;
  final Value<double> amount;
  final Value<String> direction;
  final Value<String> merchantRaw;
  final Value<String> merchantNorm;
  final Value<String> category;
  final Value<double> confidence;
  final Value<bool> isRecurring;
  final Value<String> source;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.ts = const Value.absent(),
    this.amount = const Value.absent(),
    this.direction = const Value.absent(),
    this.merchantRaw = const Value.absent(),
    this.merchantNorm = const Value.absent(),
    this.category = const Value.absent(),
    this.confidence = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String userId,
    required DateTime ts,
    required double amount,
    required String direction,
    required String merchantRaw,
    required String merchantNorm,
    required String category,
    required double confidence,
    this.isRecurring = const Value.absent(),
    required String source,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       ts = Value(ts),
       amount = Value(amount),
       direction = Value(direction),
       merchantRaw = Value(merchantRaw),
       merchantNorm = Value(merchantNorm),
       category = Value(category),
       confidence = Value(confidence),
       source = Value(source);
  static Insertable<Transaction> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? ts,
    Expression<double>? amount,
    Expression<String>? direction,
    Expression<String>? merchantRaw,
    Expression<String>? merchantNorm,
    Expression<String>? category,
    Expression<double>? confidence,
    Expression<bool>? isRecurring,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (ts != null) 'ts': ts,
      if (amount != null) 'amount': amount,
      if (direction != null) 'direction': direction,
      if (merchantRaw != null) 'merchant_raw': merchantRaw,
      if (merchantNorm != null) 'merchant_norm': merchantNorm,
      if (category != null) 'category': category,
      if (confidence != null) 'confidence': confidence,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<DateTime>? ts,
    Value<double>? amount,
    Value<String>? direction,
    Value<String>? merchantRaw,
    Value<String>? merchantNorm,
    Value<String>? category,
    Value<double>? confidence,
    Value<bool>? isRecurring,
    Value<String>? source,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      ts: ts ?? this.ts,
      amount: amount ?? this.amount,
      direction: direction ?? this.direction,
      merchantRaw: merchantRaw ?? this.merchantRaw,
      merchantNorm: merchantNorm ?? this.merchantNorm,
      category: category ?? this.category,
      confidence: confidence ?? this.confidence,
      isRecurring: isRecurring ?? this.isRecurring,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (ts.present) {
      map['ts'] = Variable<DateTime>(ts.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (merchantRaw.present) {
      map['merchant_raw'] = Variable<String>(merchantRaw.value);
    }
    if (merchantNorm.present) {
      map['merchant_norm'] = Variable<String>(merchantNorm.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('ts: $ts, ')
          ..write('amount: $amount, ')
          ..write('direction: $direction, ')
          ..write('merchantRaw: $merchantRaw, ')
          ..write('merchantNorm: $merchantNorm, ')
          ..write('category: $category, ')
          ..write('confidence: $confidence, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecurringItemsTable extends RecurringItems
    with TableInfo<$RecurringItemsTable, RecurringItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurringItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantMeta = const VerificationMeta(
    'merchant',
  );
  @override
  late final GeneratedColumn<String> merchant = GeneratedColumn<String>(
    'merchant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cadenceMeta = const VerificationMeta(
    'cadence',
  );
  @override
  late final GeneratedColumn<String> cadence = GeneratedColumn<String>(
    'cadence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextDueMeta = const VerificationMeta(
    'nextDue',
  );
  @override
  late final GeneratedColumn<DateTime> nextDue = GeneratedColumn<DateTime>(
    'next_due',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    merchant,
    amount,
    cadence,
    nextDue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurring_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurringItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('merchant')) {
      context.handle(
        _merchantMeta,
        merchant.isAcceptableOrUnknown(data['merchant']!, _merchantMeta),
      );
    } else if (isInserting) {
      context.missing(_merchantMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('cadence')) {
      context.handle(
        _cadenceMeta,
        cadence.isAcceptableOrUnknown(data['cadence']!, _cadenceMeta),
      );
    } else if (isInserting) {
      context.missing(_cadenceMeta);
    }
    if (data.containsKey('next_due')) {
      context.handle(
        _nextDueMeta,
        nextDue.isAcceptableOrUnknown(data['next_due']!, _nextDueMeta),
      );
    } else if (isInserting) {
      context.missing(_nextDueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurringItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurringItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      merchant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      cadence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cadence'],
      )!,
      nextDue: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_due'],
      )!,
    );
  }

  @override
  $RecurringItemsTable createAlias(String alias) {
    return $RecurringItemsTable(attachedDatabase, alias);
  }
}

class RecurringItem extends DataClass implements Insertable<RecurringItem> {
  final String id;
  final String userId;
  final String merchant;
  final double amount;
  final String cadence;
  final DateTime nextDue;
  const RecurringItem({
    required this.id,
    required this.userId,
    required this.merchant,
    required this.amount,
    required this.cadence,
    required this.nextDue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['merchant'] = Variable<String>(merchant);
    map['amount'] = Variable<double>(amount);
    map['cadence'] = Variable<String>(cadence);
    map['next_due'] = Variable<DateTime>(nextDue);
    return map;
  }

  RecurringItemsCompanion toCompanion(bool nullToAbsent) {
    return RecurringItemsCompanion(
      id: Value(id),
      userId: Value(userId),
      merchant: Value(merchant),
      amount: Value(amount),
      cadence: Value(cadence),
      nextDue: Value(nextDue),
    );
  }

  factory RecurringItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurringItem(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      merchant: serializer.fromJson<String>(json['merchant']),
      amount: serializer.fromJson<double>(json['amount']),
      cadence: serializer.fromJson<String>(json['cadence']),
      nextDue: serializer.fromJson<DateTime>(json['nextDue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'merchant': serializer.toJson<String>(merchant),
      'amount': serializer.toJson<double>(amount),
      'cadence': serializer.toJson<String>(cadence),
      'nextDue': serializer.toJson<DateTime>(nextDue),
    };
  }

  RecurringItem copyWith({
    String? id,
    String? userId,
    String? merchant,
    double? amount,
    String? cadence,
    DateTime? nextDue,
  }) => RecurringItem(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    merchant: merchant ?? this.merchant,
    amount: amount ?? this.amount,
    cadence: cadence ?? this.cadence,
    nextDue: nextDue ?? this.nextDue,
  );
  RecurringItem copyWithCompanion(RecurringItemsCompanion data) {
    return RecurringItem(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      merchant: data.merchant.present ? data.merchant.value : this.merchant,
      amount: data.amount.present ? data.amount.value : this.amount,
      cadence: data.cadence.present ? data.cadence.value : this.cadence,
      nextDue: data.nextDue.present ? data.nextDue.value : this.nextDue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurringItem(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('merchant: $merchant, ')
          ..write('amount: $amount, ')
          ..write('cadence: $cadence, ')
          ..write('nextDue: $nextDue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, merchant, amount, cadence, nextDue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurringItem &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.merchant == this.merchant &&
          other.amount == this.amount &&
          other.cadence == this.cadence &&
          other.nextDue == this.nextDue);
}

class RecurringItemsCompanion extends UpdateCompanion<RecurringItem> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> merchant;
  final Value<double> amount;
  final Value<String> cadence;
  final Value<DateTime> nextDue;
  final Value<int> rowid;
  const RecurringItemsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.merchant = const Value.absent(),
    this.amount = const Value.absent(),
    this.cadence = const Value.absent(),
    this.nextDue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurringItemsCompanion.insert({
    required String id,
    required String userId,
    required String merchant,
    required double amount,
    required String cadence,
    required DateTime nextDue,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       merchant = Value(merchant),
       amount = Value(amount),
       cadence = Value(cadence),
       nextDue = Value(nextDue);
  static Insertable<RecurringItem> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? merchant,
    Expression<double>? amount,
    Expression<String>? cadence,
    Expression<DateTime>? nextDue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (merchant != null) 'merchant': merchant,
      if (amount != null) 'amount': amount,
      if (cadence != null) 'cadence': cadence,
      if (nextDue != null) 'next_due': nextDue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurringItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? merchant,
    Value<double>? amount,
    Value<String>? cadence,
    Value<DateTime>? nextDue,
    Value<int>? rowid,
  }) {
    return RecurringItemsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      merchant: merchant ?? this.merchant,
      amount: amount ?? this.amount,
      cadence: cadence ?? this.cadence,
      nextDue: nextDue ?? this.nextDue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (merchant.present) {
      map['merchant'] = Variable<String>(merchant.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (cadence.present) {
      map['cadence'] = Variable<String>(cadence.value);
    }
    if (nextDue.present) {
      map['next_due'] = Variable<DateTime>(nextDue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurringItemsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('merchant: $merchant, ')
          ..write('amount: $amount, ')
          ..write('cadence: $cadence, ')
          ..write('nextDue: $nextDue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAmtMeta = const VerificationMeta(
    'targetAmt',
  );
  @override
  late final GeneratedColumn<double> targetAmt = GeneratedColumn<double>(
    'target_amt',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedMeta = const VerificationMeta('saved');
  @override
  late final GeneratedColumn<double> saved = GeneratedColumn<double>(
    'saved',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    targetAmt,
    deadline,
    saved,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('target_amt')) {
      context.handle(
        _targetAmtMeta,
        targetAmt.isAcceptableOrUnknown(data['target_amt']!, _targetAmtMeta),
      );
    } else if (isInserting) {
      context.missing(_targetAmtMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    if (data.containsKey('saved')) {
      context.handle(
        _savedMeta,
        saved.isAcceptableOrUnknown(data['saved']!, _savedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      targetAmt: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_amt'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      )!,
      saved: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}saved'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final String id;
  final String userId;
  final String name;
  final double targetAmt;
  final DateTime deadline;
  final double saved;
  const Goal({
    required this.id,
    required this.userId,
    required this.name,
    required this.targetAmt,
    required this.deadline,
    required this.saved,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['target_amt'] = Variable<double>(targetAmt);
    map['deadline'] = Variable<DateTime>(deadline);
    map['saved'] = Variable<double>(saved);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      targetAmt: Value(targetAmt),
      deadline: Value(deadline),
      saved: Value(saved),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      targetAmt: serializer.fromJson<double>(json['targetAmt']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
      saved: serializer.fromJson<double>(json['saved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'targetAmt': serializer.toJson<double>(targetAmt),
      'deadline': serializer.toJson<DateTime>(deadline),
      'saved': serializer.toJson<double>(saved),
    };
  }

  Goal copyWith({
    String? id,
    String? userId,
    String? name,
    double? targetAmt,
    DateTime? deadline,
    double? saved,
  }) => Goal(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    targetAmt: targetAmt ?? this.targetAmt,
    deadline: deadline ?? this.deadline,
    saved: saved ?? this.saved,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      targetAmt: data.targetAmt.present ? data.targetAmt.value : this.targetAmt,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      saved: data.saved.present ? data.saved.value : this.saved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('targetAmt: $targetAmt, ')
          ..write('deadline: $deadline, ')
          ..write('saved: $saved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, targetAmt, deadline, saved);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.targetAmt == this.targetAmt &&
          other.deadline == this.deadline &&
          other.saved == this.saved);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<double> targetAmt;
  final Value<DateTime> deadline;
  final Value<double> saved;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmt = const Value.absent(),
    this.deadline = const Value.absent(),
    this.saved = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    required double targetAmt,
    required DateTime deadline,
    this.saved = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name),
       targetAmt = Value(targetAmt),
       deadline = Value(deadline);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<double>? targetAmt,
    Expression<DateTime>? deadline,
    Expression<double>? saved,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (targetAmt != null) 'target_amt': targetAmt,
      if (deadline != null) 'deadline': deadline,
      if (saved != null) 'saved': saved,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<double>? targetAmt,
    Value<DateTime>? deadline,
    Value<double>? saved,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      targetAmt: targetAmt ?? this.targetAmt,
      deadline: deadline ?? this.deadline,
      saved: saved ?? this.saved,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetAmt.present) {
      map['target_amt'] = Variable<double>(targetAmt.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (saved.present) {
      map['saved'] = Variable<double>(saved.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('targetAmt: $targetAmt, ')
          ..write('deadline: $deadline, ')
          ..write('saved: $saved, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NudgesTable extends Nudges with TableInfo<$NudgesTable, Nudge> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NudgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tsMeta = const VerificationMeta('ts');
  @override
  late final GeneratedColumn<DateTime> ts = GeneratedColumn<DateTime>(
    'ts',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factsJsonMeta = const VerificationMeta(
    'factsJson',
  );
  @override
  late final GeneratedColumn<String> factsJson = GeneratedColumn<String>(
    'facts_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feedbackMeta = const VerificationMeta(
    'feedback',
  );
  @override
  late final GeneratedColumn<String> feedback = GeneratedColumn<String>(
    'feedback',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    ts,
    type,
    textContent,
    factsJson,
    feedback,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nudges';
  @override
  VerificationContext validateIntegrity(
    Insertable<Nudge> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('ts')) {
      context.handle(_tsMeta, ts.isAcceptableOrUnknown(data['ts']!, _tsMeta));
    } else if (isInserting) {
      context.missing(_tsMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(data['text']!, _textContentMeta),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('facts_json')) {
      context.handle(
        _factsJsonMeta,
        factsJson.isAcceptableOrUnknown(data['facts_json']!, _factsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_factsJsonMeta);
    }
    if (data.containsKey('feedback')) {
      context.handle(
        _feedbackMeta,
        feedback.isAcceptableOrUnknown(data['feedback']!, _feedbackMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Nudge map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Nudge(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      ts: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ts'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      factsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}facts_json'],
      )!,
      feedback: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feedback'],
      ),
    );
  }

  @override
  $NudgesTable createAlias(String alias) {
    return $NudgesTable(attachedDatabase, alias);
  }
}

class Nudge extends DataClass implements Insertable<Nudge> {
  final String id;
  final String userId;
  final DateTime ts;
  final String type;
  final String textContent;
  final String factsJson;
  final String? feedback;
  const Nudge({
    required this.id,
    required this.userId,
    required this.ts,
    required this.type,
    required this.textContent,
    required this.factsJson,
    this.feedback,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['ts'] = Variable<DateTime>(ts);
    map['type'] = Variable<String>(type);
    map['text'] = Variable<String>(textContent);
    map['facts_json'] = Variable<String>(factsJson);
    if (!nullToAbsent || feedback != null) {
      map['feedback'] = Variable<String>(feedback);
    }
    return map;
  }

  NudgesCompanion toCompanion(bool nullToAbsent) {
    return NudgesCompanion(
      id: Value(id),
      userId: Value(userId),
      ts: Value(ts),
      type: Value(type),
      textContent: Value(textContent),
      factsJson: Value(factsJson),
      feedback: feedback == null && nullToAbsent
          ? const Value.absent()
          : Value(feedback),
    );
  }

  factory Nudge.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Nudge(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      ts: serializer.fromJson<DateTime>(json['ts']),
      type: serializer.fromJson<String>(json['type']),
      textContent: serializer.fromJson<String>(json['textContent']),
      factsJson: serializer.fromJson<String>(json['factsJson']),
      feedback: serializer.fromJson<String?>(json['feedback']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'ts': serializer.toJson<DateTime>(ts),
      'type': serializer.toJson<String>(type),
      'textContent': serializer.toJson<String>(textContent),
      'factsJson': serializer.toJson<String>(factsJson),
      'feedback': serializer.toJson<String?>(feedback),
    };
  }

  Nudge copyWith({
    String? id,
    String? userId,
    DateTime? ts,
    String? type,
    String? textContent,
    String? factsJson,
    Value<String?> feedback = const Value.absent(),
  }) => Nudge(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    ts: ts ?? this.ts,
    type: type ?? this.type,
    textContent: textContent ?? this.textContent,
    factsJson: factsJson ?? this.factsJson,
    feedback: feedback.present ? feedback.value : this.feedback,
  );
  Nudge copyWithCompanion(NudgesCompanion data) {
    return Nudge(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      ts: data.ts.present ? data.ts.value : this.ts,
      type: data.type.present ? data.type.value : this.type,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      factsJson: data.factsJson.present ? data.factsJson.value : this.factsJson,
      feedback: data.feedback.present ? data.feedback.value : this.feedback,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Nudge(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('ts: $ts, ')
          ..write('type: $type, ')
          ..write('textContent: $textContent, ')
          ..write('factsJson: $factsJson, ')
          ..write('feedback: $feedback')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, ts, type, textContent, factsJson, feedback);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Nudge &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.ts == this.ts &&
          other.type == this.type &&
          other.textContent == this.textContent &&
          other.factsJson == this.factsJson &&
          other.feedback == this.feedback);
}

class NudgesCompanion extends UpdateCompanion<Nudge> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> ts;
  final Value<String> type;
  final Value<String> textContent;
  final Value<String> factsJson;
  final Value<String?> feedback;
  final Value<int> rowid;
  const NudgesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.ts = const Value.absent(),
    this.type = const Value.absent(),
    this.textContent = const Value.absent(),
    this.factsJson = const Value.absent(),
    this.feedback = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NudgesCompanion.insert({
    required String id,
    required String userId,
    required DateTime ts,
    required String type,
    required String textContent,
    required String factsJson,
    this.feedback = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       ts = Value(ts),
       type = Value(type),
       textContent = Value(textContent),
       factsJson = Value(factsJson);
  static Insertable<Nudge> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? ts,
    Expression<String>? type,
    Expression<String>? textContent,
    Expression<String>? factsJson,
    Expression<String>? feedback,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (ts != null) 'ts': ts,
      if (type != null) 'type': type,
      if (textContent != null) 'text': textContent,
      if (factsJson != null) 'facts_json': factsJson,
      if (feedback != null) 'feedback': feedback,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NudgesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<DateTime>? ts,
    Value<String>? type,
    Value<String>? textContent,
    Value<String>? factsJson,
    Value<String?>? feedback,
    Value<int>? rowid,
  }) {
    return NudgesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      ts: ts ?? this.ts,
      type: type ?? this.type,
      textContent: textContent ?? this.textContent,
      factsJson: factsJson ?? this.factsJson,
      feedback: feedback ?? this.feedback,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (ts.present) {
      map['ts'] = Variable<DateTime>(ts.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (textContent.present) {
      map['text'] = Variable<String>(textContent.value);
    }
    if (factsJson.present) {
      map['facts_json'] = Variable<String>(factsJson.value);
    }
    if (feedback.present) {
      map['feedback'] = Variable<String>(feedback.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NudgesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('ts: $ts, ')
          ..write('type: $type, ')
          ..write('textContent: $textContent, ')
          ..write('factsJson: $factsJson, ')
          ..write('feedback: $feedback, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MerchantRulesTable extends MerchantRules
    with TableInfo<$MerchantRulesTable, MerchantRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MerchantRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantNormMeta = const VerificationMeta(
    'merchantNorm',
  );
  @override
  late final GeneratedColumn<String> merchantNorm = GeneratedColumn<String>(
    'merchant_norm',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, merchantNorm, category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'merchant_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<MerchantRule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('merchant_norm')) {
      context.handle(
        _merchantNormMeta,
        merchantNorm.isAcceptableOrUnknown(
          data['merchant_norm']!,
          _merchantNormMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_merchantNormMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MerchantRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MerchantRule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      merchantNorm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_norm'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $MerchantRulesTable createAlias(String alias) {
    return $MerchantRulesTable(attachedDatabase, alias);
  }
}

class MerchantRule extends DataClass implements Insertable<MerchantRule> {
  final String id;
  final String merchantNorm;
  final String category;
  const MerchantRule({
    required this.id,
    required this.merchantNorm,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['merchant_norm'] = Variable<String>(merchantNorm);
    map['category'] = Variable<String>(category);
    return map;
  }

  MerchantRulesCompanion toCompanion(bool nullToAbsent) {
    return MerchantRulesCompanion(
      id: Value(id),
      merchantNorm: Value(merchantNorm),
      category: Value(category),
    );
  }

  factory MerchantRule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MerchantRule(
      id: serializer.fromJson<String>(json['id']),
      merchantNorm: serializer.fromJson<String>(json['merchantNorm']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'merchantNorm': serializer.toJson<String>(merchantNorm),
      'category': serializer.toJson<String>(category),
    };
  }

  MerchantRule copyWith({String? id, String? merchantNorm, String? category}) =>
      MerchantRule(
        id: id ?? this.id,
        merchantNorm: merchantNorm ?? this.merchantNorm,
        category: category ?? this.category,
      );
  MerchantRule copyWithCompanion(MerchantRulesCompanion data) {
    return MerchantRule(
      id: data.id.present ? data.id.value : this.id,
      merchantNorm: data.merchantNorm.present
          ? data.merchantNorm.value
          : this.merchantNorm,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MerchantRule(')
          ..write('id: $id, ')
          ..write('merchantNorm: $merchantNorm, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, merchantNorm, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MerchantRule &&
          other.id == this.id &&
          other.merchantNorm == this.merchantNorm &&
          other.category == this.category);
}

class MerchantRulesCompanion extends UpdateCompanion<MerchantRule> {
  final Value<String> id;
  final Value<String> merchantNorm;
  final Value<String> category;
  final Value<int> rowid;
  const MerchantRulesCompanion({
    this.id = const Value.absent(),
    this.merchantNorm = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MerchantRulesCompanion.insert({
    required String id,
    required String merchantNorm,
    required String category,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       merchantNorm = Value(merchantNorm),
       category = Value(category);
  static Insertable<MerchantRule> custom({
    Expression<String>? id,
    Expression<String>? merchantNorm,
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (merchantNorm != null) 'merchant_norm': merchantNorm,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MerchantRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? merchantNorm,
    Value<String>? category,
    Value<int>? rowid,
  }) {
    return MerchantRulesCompanion(
      id: id ?? this.id,
      merchantNorm: merchantNorm ?? this.merchantNorm,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (merchantNorm.present) {
      map['merchant_norm'] = Variable<String>(merchantNorm.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MerchantRulesCompanion(')
          ..write('id: $id, ')
          ..write('merchantNorm: $merchantNorm, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $RecurringItemsTable recurringItems = $RecurringItemsTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $NudgesTable nudges = $NudgesTable(this);
  late final $MerchantRulesTable merchantRules = $MerchantRulesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    transactions,
    recurringItems,
    goals,
    nudges,
    merchantRules,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String name,
      required int incomeCycleDay,
      required double monthlyIncome,
      required double openingBalance,
      Value<String> language,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> incomeCycleDay,
      Value<double> monthlyIncome,
      Value<double> openingBalance,
      Value<String> language,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get incomeCycleDay => $composableBuilder(
    column: $table.incomeCycleDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlyIncome => $composableBuilder(
    column: $table.monthlyIncome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get incomeCycleDay => $composableBuilder(
    column: $table.incomeCycleDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlyIncome => $composableBuilder(
    column: $table.monthlyIncome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get incomeCycleDay => $composableBuilder(
    column: $table.incomeCycleDay,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monthlyIncome => $composableBuilder(
    column: $table.monthlyIncome,
    builder: (column) => column,
  );

  GeneratedColumn<double> get openingBalance => $composableBuilder(
    column: $table.openingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> incomeCycleDay = const Value.absent(),
                Value<double> monthlyIncome = const Value.absent(),
                Value<double> openingBalance = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                incomeCycleDay: incomeCycleDay,
                monthlyIncome: monthlyIncome,
                openingBalance: openingBalance,
                language: language,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int incomeCycleDay,
                required double monthlyIncome,
                required double openingBalance,
                Value<String> language = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                incomeCycleDay: incomeCycleDay,
                monthlyIncome: monthlyIncome,
                openingBalance: openingBalance,
                language: language,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  BaseReferences<_$AppDatabase, $UsersTable, User>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required String userId,
      required DateTime ts,
      required double amount,
      required String direction,
      required String merchantRaw,
      required String merchantNorm,
      required String category,
      required double confidence,
      Value<bool> isRecurring,
      required String source,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<DateTime> ts,
      Value<double> amount,
      Value<String> direction,
      Value<String> merchantRaw,
      Value<String> merchantNorm,
      Value<String> category,
      Value<double> confidence,
      Value<bool> isRecurring,
      Value<String> source,
      Value<int> rowid,
    });

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantRaw => $composableBuilder(
    column: $table.merchantRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantNorm => $composableBuilder(
    column: $table.merchantNorm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantRaw => $composableBuilder(
    column: $table.merchantRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantNorm => $composableBuilder(
    column: $table.merchantNorm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get ts =>
      $composableBuilder(column: $table.ts, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get merchantRaw => $composableBuilder(
    column: $table.merchantRaw,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantNorm => $composableBuilder(
    column: $table.merchantNorm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (
            Transaction,
            BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
          ),
          Transaction,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> ts = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String> merchantRaw = const Value.absent(),
                Value<String> merchantNorm = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                userId: userId,
                ts: ts,
                amount: amount,
                direction: direction,
                merchantRaw: merchantRaw,
                merchantNorm: merchantNorm,
                category: category,
                confidence: confidence,
                isRecurring: isRecurring,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required DateTime ts,
                required double amount,
                required String direction,
                required String merchantRaw,
                required String merchantNorm,
                required String category,
                required double confidence,
                Value<bool> isRecurring = const Value.absent(),
                required String source,
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                userId: userId,
                ts: ts,
                amount: amount,
                direction: direction,
                merchantRaw: merchantRaw,
                merchantNorm: merchantNorm,
                category: category,
                confidence: confidence,
                isRecurring: isRecurring,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, Transaction>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TransactionsTable,
                    Transaction
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (
        Transaction,
        BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
      ),
      Transaction,
      PrefetchHooks Function()
    >;
typedef $$RecurringItemsTableCreateCompanionBuilder =
    RecurringItemsCompanion Function({
      required String id,
      required String userId,
      required String merchant,
      required double amount,
      required String cadence,
      required DateTime nextDue,
      Value<int> rowid,
    });
typedef $$RecurringItemsTableUpdateCompanionBuilder =
    RecurringItemsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> merchant,
      Value<double> amount,
      Value<String> cadence,
      Value<DateTime> nextDue,
      Value<int> rowid,
    });

class $$RecurringItemsTableFilterComposer
    extends Composer<_$AppDatabase, $RecurringItemsTable> {
  $$RecurringItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextDue => $composableBuilder(
    column: $table.nextDue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecurringItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurringItemsTable> {
  $$RecurringItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchant => $composableBuilder(
    column: $table.merchant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cadence => $composableBuilder(
    column: $table.cadence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextDue => $composableBuilder(
    column: $table.nextDue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecurringItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurringItemsTable> {
  $$RecurringItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get merchant =>
      $composableBuilder(column: $table.merchant, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get cadence =>
      $composableBuilder(column: $table.cadence, builder: (column) => column);

  GeneratedColumn<DateTime> get nextDue =>
      $composableBuilder(column: $table.nextDue, builder: (column) => column);
}

class $$RecurringItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurringItemsTable,
          RecurringItem,
          $$RecurringItemsTableFilterComposer,
          $$RecurringItemsTableOrderingComposer,
          $$RecurringItemsTableAnnotationComposer,
          $$RecurringItemsTableCreateCompanionBuilder,
          $$RecurringItemsTableUpdateCompanionBuilder,
          (
            RecurringItem,
            BaseReferences<_$AppDatabase, $RecurringItemsTable, RecurringItem>,
          ),
          RecurringItem,
          PrefetchHooks Function()
        > {
  $$RecurringItemsTableTableManager(
    _$AppDatabase db,
    $RecurringItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurringItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurringItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurringItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> merchant = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> cadence = const Value.absent(),
                Value<DateTime> nextDue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurringItemsCompanion(
                id: id,
                userId: userId,
                merchant: merchant,
                amount: amount,
                cadence: cadence,
                nextDue: nextDue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String merchant,
                required double amount,
                required String cadence,
                required DateTime nextDue,
                Value<int> rowid = const Value.absent(),
              }) => RecurringItemsCompanion.insert(
                id: id,
                userId: userId,
                merchant: merchant,
                amount: amount,
                cadence: cadence,
                nextDue: nextDue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecurringItemsTable, RecurringItem>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $RecurringItemsTable,
                    RecurringItem
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecurringItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurringItemsTable,
      RecurringItem,
      $$RecurringItemsTableFilterComposer,
      $$RecurringItemsTableOrderingComposer,
      $$RecurringItemsTableAnnotationComposer,
      $$RecurringItemsTableCreateCompanionBuilder,
      $$RecurringItemsTableUpdateCompanionBuilder,
      (
        RecurringItem,
        BaseReferences<_$AppDatabase, $RecurringItemsTable, RecurringItem>,
      ),
      RecurringItem,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      required String id,
      required String userId,
      required String name,
      required double targetAmt,
      required DateTime deadline,
      Value<double> saved,
      Value<int> rowid,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> name,
      Value<double> targetAmt,
      Value<DateTime> deadline,
      Value<double> saved,
      Value<int> rowid,
    });

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetAmt => $composableBuilder(
    column: $table.targetAmt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saved => $composableBuilder(
    column: $table.saved,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetAmt => $composableBuilder(
    column: $table.targetAmt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saved => $composableBuilder(
    column: $table.saved,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get targetAmt =>
      $composableBuilder(column: $table.targetAmt, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<double> get saved =>
      $composableBuilder(column: $table.saved, builder: (column) => column);
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          Goal,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
          Goal,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> targetAmt = const Value.absent(),
                Value<DateTime> deadline = const Value.absent(),
                Value<double> saved = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                userId: userId,
                name: name,
                targetAmt: targetAmt,
                deadline: deadline,
                saved: saved,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String name,
                required double targetAmt,
                required DateTime deadline,
                Value<double> saved = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                targetAmt: targetAmt,
                deadline: deadline,
                saved: saved,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalsTable, Goal>(table),
                  BaseReferences<_$AppDatabase, $GoalsTable, Goal>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      Goal,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
      Goal,
      PrefetchHooks Function()
    >;
typedef $$NudgesTableCreateCompanionBuilder =
    NudgesCompanion Function({
      required String id,
      required String userId,
      required DateTime ts,
      required String type,
      required String textContent,
      required String factsJson,
      Value<String?> feedback,
      Value<int> rowid,
    });
typedef $$NudgesTableUpdateCompanionBuilder =
    NudgesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<DateTime> ts,
      Value<String> type,
      Value<String> textContent,
      Value<String> factsJson,
      Value<String?> feedback,
      Value<int> rowid,
    });

class $$NudgesTableFilterComposer
    extends Composer<_$AppDatabase, $NudgesTable> {
  $$NudgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get factsJson => $composableBuilder(
    column: $table.factsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NudgesTableOrderingComposer
    extends Composer<_$AppDatabase, $NudgesTable> {
  $$NudgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get factsJson => $composableBuilder(
    column: $table.factsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedback => $composableBuilder(
    column: $table.feedback,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NudgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NudgesTable> {
  $$NudgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get ts =>
      $composableBuilder(column: $table.ts, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get factsJson =>
      $composableBuilder(column: $table.factsJson, builder: (column) => column);

  GeneratedColumn<String> get feedback =>
      $composableBuilder(column: $table.feedback, builder: (column) => column);
}

class $$NudgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NudgesTable,
          Nudge,
          $$NudgesTableFilterComposer,
          $$NudgesTableOrderingComposer,
          $$NudgesTableAnnotationComposer,
          $$NudgesTableCreateCompanionBuilder,
          $$NudgesTableUpdateCompanionBuilder,
          (Nudge, BaseReferences<_$AppDatabase, $NudgesTable, Nudge>),
          Nudge,
          PrefetchHooks Function()
        > {
  $$NudgesTableTableManager(_$AppDatabase db, $NudgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NudgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NudgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NudgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> ts = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<String> factsJson = const Value.absent(),
                Value<String?> feedback = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NudgesCompanion(
                id: id,
                userId: userId,
                ts: ts,
                type: type,
                textContent: textContent,
                factsJson: factsJson,
                feedback: feedback,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required DateTime ts,
                required String type,
                required String textContent,
                required String factsJson,
                Value<String?> feedback = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NudgesCompanion.insert(
                id: id,
                userId: userId,
                ts: ts,
                type: type,
                textContent: textContent,
                factsJson: factsJson,
                feedback: feedback,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NudgesTable, Nudge>(table),
                  BaseReferences<_$AppDatabase, $NudgesTable, Nudge>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NudgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NudgesTable,
      Nudge,
      $$NudgesTableFilterComposer,
      $$NudgesTableOrderingComposer,
      $$NudgesTableAnnotationComposer,
      $$NudgesTableCreateCompanionBuilder,
      $$NudgesTableUpdateCompanionBuilder,
      (Nudge, BaseReferences<_$AppDatabase, $NudgesTable, Nudge>),
      Nudge,
      PrefetchHooks Function()
    >;
typedef $$MerchantRulesTableCreateCompanionBuilder =
    MerchantRulesCompanion Function({
      required String id,
      required String merchantNorm,
      required String category,
      Value<int> rowid,
    });
typedef $$MerchantRulesTableUpdateCompanionBuilder =
    MerchantRulesCompanion Function({
      Value<String> id,
      Value<String> merchantNorm,
      Value<String> category,
      Value<int> rowid,
    });

class $$MerchantRulesTableFilterComposer
    extends Composer<_$AppDatabase, $MerchantRulesTable> {
  $$MerchantRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantNorm => $composableBuilder(
    column: $table.merchantNorm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MerchantRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $MerchantRulesTable> {
  $$MerchantRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantNorm => $composableBuilder(
    column: $table.merchantNorm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MerchantRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MerchantRulesTable> {
  $$MerchantRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get merchantNorm => $composableBuilder(
    column: $table.merchantNorm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$MerchantRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MerchantRulesTable,
          MerchantRule,
          $$MerchantRulesTableFilterComposer,
          $$MerchantRulesTableOrderingComposer,
          $$MerchantRulesTableAnnotationComposer,
          $$MerchantRulesTableCreateCompanionBuilder,
          $$MerchantRulesTableUpdateCompanionBuilder,
          (
            MerchantRule,
            BaseReferences<_$AppDatabase, $MerchantRulesTable, MerchantRule>,
          ),
          MerchantRule,
          PrefetchHooks Function()
        > {
  $$MerchantRulesTableTableManager(_$AppDatabase db, $MerchantRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MerchantRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MerchantRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MerchantRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> merchantNorm = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MerchantRulesCompanion(
                id: id,
                merchantNorm: merchantNorm,
                category: category,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String merchantNorm,
                required String category,
                Value<int> rowid = const Value.absent(),
              }) => MerchantRulesCompanion.insert(
                id: id,
                merchantNorm: merchantNorm,
                category: category,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MerchantRulesTable, MerchantRule>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MerchantRulesTable,
                    MerchantRule
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MerchantRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MerchantRulesTable,
      MerchantRule,
      $$MerchantRulesTableFilterComposer,
      $$MerchantRulesTableOrderingComposer,
      $$MerchantRulesTableAnnotationComposer,
      $$MerchantRulesTableCreateCompanionBuilder,
      $$MerchantRulesTableUpdateCompanionBuilder,
      (
        MerchantRule,
        BaseReferences<_$AppDatabase, $MerchantRulesTable, MerchantRule>,
      ),
      MerchantRule,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$RecurringItemsTableTableManager get recurringItems =>
      $$RecurringItemsTableTableManager(_db, _db.recurringItems);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$NudgesTableTableManager get nudges =>
      $$NudgesTableTableManager(_db, _db.nudges);
  $$MerchantRulesTableTableManager get merchantRules =>
      $$MerchantRulesTableTableManager(_db, _db.merchantRules);
}
