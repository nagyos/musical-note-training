// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DecksTable extends Decks with TableInfo<$DecksTable, Deck> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    createdAt,
    version,
    updatedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Deck> instance, {
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Deck map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deck(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $DecksTable createAlias(String alias) {
    return $DecksTable(attachedDatabase, alias);
  }
}

class Deck extends DataClass implements Insertable<Deck> {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final int version;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;
  const Deck({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.version,
    required this.updatedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['version'] = Variable<int>(version);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  DecksCompanion toCompanion(bool nullToAbsent) {
    return DecksCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      version: Value(version),
      updatedAt: Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory Deck.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deck(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      version: serializer.fromJson<int>(json['version']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'version': serializer.toJson<int>(version),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  Deck copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    int? version,
    DateTime? updatedAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => Deck(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    version: version ?? this.version,
    updatedAt: updatedAt ?? this.updatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  Deck copyWithCompanion(DecksCompanion data) {
    return Deck(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      version: data.version.present ? data.version.value : this.version,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deck(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('version: $version, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    createdAt,
    version,
    updatedAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deck &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.version == this.version &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class DecksCompanion extends UpdateCompanion<Deck> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<int> version;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const DecksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.version = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DecksCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required DateTime createdAt,
    this.version = const Value.absent(),
    required DateTime updatedAt,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Deck> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<int>? version,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (version != null) 'version': version,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DecksCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<int>? version,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return DecksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      version: version ?? this.version,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('version: $version, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeckCardsTable extends DeckCards
    with TableInfo<$DeckCardsTable, DeckCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeckCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<String> deckId = GeneratedColumn<String>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES decks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [deckId, cardId, sortOrder, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deck_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeckCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deckId, cardId};
  @override
  DeckCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeckCard(
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $DeckCardsTable createAlias(String alias) {
    return $DeckCardsTable(attachedDatabase, alias);
  }
}

class DeckCard extends DataClass implements Insertable<DeckCard> {
  final String deckId;
  final String cardId;
  final int sortOrder;
  final DateTime addedAt;
  const DeckCard({
    required this.deckId,
    required this.cardId,
    required this.sortOrder,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['deck_id'] = Variable<String>(deckId);
    map['card_id'] = Variable<String>(cardId);
    map['sort_order'] = Variable<int>(sortOrder);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  DeckCardsCompanion toCompanion(bool nullToAbsent) {
    return DeckCardsCompanion(
      deckId: Value(deckId),
      cardId: Value(cardId),
      sortOrder: Value(sortOrder),
      addedAt: Value(addedAt),
    );
  }

  factory DeckCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeckCard(
      deckId: serializer.fromJson<String>(json['deckId']),
      cardId: serializer.fromJson<String>(json['cardId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deckId': serializer.toJson<String>(deckId),
      'cardId': serializer.toJson<String>(cardId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  DeckCard copyWith({
    String? deckId,
    String? cardId,
    int? sortOrder,
    DateTime? addedAt,
  }) => DeckCard(
    deckId: deckId ?? this.deckId,
    cardId: cardId ?? this.cardId,
    sortOrder: sortOrder ?? this.sortOrder,
    addedAt: addedAt ?? this.addedAt,
  );
  DeckCard copyWithCompanion(DeckCardsCompanion data) {
    return DeckCard(
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeckCard(')
          ..write('deckId: $deckId, ')
          ..write('cardId: $cardId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(deckId, cardId, sortOrder, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeckCard &&
          other.deckId == this.deckId &&
          other.cardId == this.cardId &&
          other.sortOrder == this.sortOrder &&
          other.addedAt == this.addedAt);
}

class DeckCardsCompanion extends UpdateCompanion<DeckCard> {
  final Value<String> deckId;
  final Value<String> cardId;
  final Value<int> sortOrder;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const DeckCardsCompanion({
    this.deckId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeckCardsCompanion.insert({
    required String deckId,
    required String cardId,
    required int sortOrder,
    required DateTime addedAt,
    this.rowid = const Value.absent(),
  }) : deckId = Value(deckId),
       cardId = Value(cardId),
       sortOrder = Value(sortOrder),
       addedAt = Value(addedAt);
  static Insertable<DeckCard> custom({
    Expression<String>? deckId,
    Expression<String>? cardId,
    Expression<int>? sortOrder,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (deckId != null) 'deck_id': deckId,
      if (cardId != null) 'card_id': cardId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeckCardsCompanion copyWith({
    Value<String>? deckId,
    Value<String>? cardId,
    Value<int>? sortOrder,
    Value<DateTime>? addedAt,
    Value<int>? rowid,
  }) {
    return DeckCardsCompanion(
      deckId: deckId ?? this.deckId,
      cardId: cardId ?? this.cardId,
      sortOrder: sortOrder ?? this.sortOrder,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deckId.present) {
      map['deck_id'] = Variable<String>(deckId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeckCardsCompanion(')
          ..write('deckId: $deckId, ')
          ..write('cardId: $cardId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeakItemsTable extends WeakItems
    with TableInfo<$WeakItemsTable, WeakItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeakItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastAnsweredAtMeta = const VerificationMeta(
    'lastAnsweredAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAnsweredAt =
      GeneratedColumn<DateTime>(
        'last_answered_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    wrongCount,
    correctCount,
    lastAnsweredAt,
    version,
    updatedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weak_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeakItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('last_answered_at')) {
      context.handle(
        _lastAnsweredAtMeta,
        lastAnsweredAt.isAcceptableOrUnknown(
          data['last_answered_at']!,
          _lastAnsweredAtMeta,
        ),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeakItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeakItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      lastAnsweredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_answered_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $WeakItemsTable createAlias(String alias) {
    return $WeakItemsTable(attachedDatabase, alias);
  }
}

class WeakItem extends DataClass implements Insertable<WeakItem> {
  final String id;
  final String cardId;
  final int wrongCount;
  final int correctCount;
  final DateTime? lastAnsweredAt;
  final int version;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;
  const WeakItem({
    required this.id,
    required this.cardId,
    required this.wrongCount,
    required this.correctCount,
    this.lastAnsweredAt,
    required this.version,
    required this.updatedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['card_id'] = Variable<String>(cardId);
    map['wrong_count'] = Variable<int>(wrongCount);
    map['correct_count'] = Variable<int>(correctCount);
    if (!nullToAbsent || lastAnsweredAt != null) {
      map['last_answered_at'] = Variable<DateTime>(lastAnsweredAt);
    }
    map['version'] = Variable<int>(version);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  WeakItemsCompanion toCompanion(bool nullToAbsent) {
    return WeakItemsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      wrongCount: Value(wrongCount),
      correctCount: Value(correctCount),
      lastAnsweredAt: lastAnsweredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAnsweredAt),
      version: Value(version),
      updatedAt: Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory WeakItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeakItem(
      id: serializer.fromJson<String>(json['id']),
      cardId: serializer.fromJson<String>(json['cardId']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      lastAnsweredAt: serializer.fromJson<DateTime?>(json['lastAnsweredAt']),
      version: serializer.fromJson<int>(json['version']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cardId': serializer.toJson<String>(cardId),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'correctCount': serializer.toJson<int>(correctCount),
      'lastAnsweredAt': serializer.toJson<DateTime?>(lastAnsweredAt),
      'version': serializer.toJson<int>(version),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  WeakItem copyWith({
    String? id,
    String? cardId,
    int? wrongCount,
    int? correctCount,
    Value<DateTime?> lastAnsweredAt = const Value.absent(),
    int? version,
    DateTime? updatedAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => WeakItem(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    wrongCount: wrongCount ?? this.wrongCount,
    correctCount: correctCount ?? this.correctCount,
    lastAnsweredAt: lastAnsweredAt.present
        ? lastAnsweredAt.value
        : this.lastAnsweredAt,
    version: version ?? this.version,
    updatedAt: updatedAt ?? this.updatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  WeakItem copyWithCompanion(WeakItemsCompanion data) {
    return WeakItem(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      lastAnsweredAt: data.lastAnsweredAt.present
          ? data.lastAnsweredAt.value
          : this.lastAnsweredAt,
      version: data.version.present ? data.version.value : this.version,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeakItem(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('lastAnsweredAt: $lastAnsweredAt, ')
          ..write('version: $version, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cardId,
    wrongCount,
    correctCount,
    lastAnsweredAt,
    version,
    updatedAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeakItem &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.wrongCount == this.wrongCount &&
          other.correctCount == this.correctCount &&
          other.lastAnsweredAt == this.lastAnsweredAt &&
          other.version == this.version &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class WeakItemsCompanion extends UpdateCompanion<WeakItem> {
  final Value<String> id;
  final Value<String> cardId;
  final Value<int> wrongCount;
  final Value<int> correctCount;
  final Value<DateTime?> lastAnsweredAt;
  final Value<int> version;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const WeakItemsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.lastAnsweredAt = const Value.absent(),
    this.version = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeakItemsCompanion.insert({
    required String id,
    required String cardId,
    this.wrongCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.lastAnsweredAt = const Value.absent(),
    this.version = const Value.absent(),
    required DateTime updatedAt,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cardId = Value(cardId),
       updatedAt = Value(updatedAt);
  static Insertable<WeakItem> custom({
    Expression<String>? id,
    Expression<String>? cardId,
    Expression<int>? wrongCount,
    Expression<int>? correctCount,
    Expression<DateTime>? lastAnsweredAt,
    Expression<int>? version,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (correctCount != null) 'correct_count': correctCount,
      if (lastAnsweredAt != null) 'last_answered_at': lastAnsweredAt,
      if (version != null) 'version': version,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeakItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? cardId,
    Value<int>? wrongCount,
    Value<int>? correctCount,
    Value<DateTime?>? lastAnsweredAt,
    Value<int>? version,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return WeakItemsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      wrongCount: wrongCount ?? this.wrongCount,
      correctCount: correctCount ?? this.correctCount,
      lastAnsweredAt: lastAnsweredAt ?? this.lastAnsweredAt,
      version: version ?? this.version,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (lastAnsweredAt.present) {
      map['last_answered_at'] = Variable<DateTime>(lastAnsweredAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeakItemsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('lastAnsweredAt: $lastAnsweredAt, ')
          ..write('version: $version, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudyProgressEntriesTable extends StudyProgressEntries
    with TableInfo<$StudyProgressEntriesTable, StudyProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lessonIdMeta = const VerificationMeta(
    'lessonId',
  );
  @override
  late final GeneratedColumn<String> lessonId = GeneratedColumn<String>(
    'lesson_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedCardIdsMeta = const VerificationMeta(
    'completedCardIds',
  );
  @override
  late final GeneratedColumn<String> completedCardIds = GeneratedColumn<String>(
    'completed_card_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lessonId,
    completedCardIds,
    version,
    updatedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyProgressEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lesson_id')) {
      context.handle(
        _lessonIdMeta,
        lessonId.isAcceptableOrUnknown(data['lesson_id']!, _lessonIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lessonIdMeta);
    }
    if (data.containsKey('completed_card_ids')) {
      context.handle(
        _completedCardIdsMeta,
        completedCardIds.isAcceptableOrUnknown(
          data['completed_card_ids']!,
          _completedCardIdsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedCardIdsMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudyProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyProgressEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      lessonId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson_id'],
      )!,
      completedCardIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_card_ids'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $StudyProgressEntriesTable createAlias(String alias) {
    return $StudyProgressEntriesTable(attachedDatabase, alias);
  }
}

class StudyProgressEntry extends DataClass
    implements Insertable<StudyProgressEntry> {
  final String id;
  final String lessonId;
  final String completedCardIds;
  final int version;
  final DateTime updatedAt;
  final DateTime? lastSyncedAt;
  const StudyProgressEntry({
    required this.id,
    required this.lessonId,
    required this.completedCardIds,
    required this.version,
    required this.updatedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lesson_id'] = Variable<String>(lessonId);
    map['completed_card_ids'] = Variable<String>(completedCardIds);
    map['version'] = Variable<int>(version);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  StudyProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return StudyProgressEntriesCompanion(
      id: Value(id),
      lessonId: Value(lessonId),
      completedCardIds: Value(completedCardIds),
      version: Value(version),
      updatedAt: Value(updatedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory StudyProgressEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyProgressEntry(
      id: serializer.fromJson<String>(json['id']),
      lessonId: serializer.fromJson<String>(json['lessonId']),
      completedCardIds: serializer.fromJson<String>(json['completedCardIds']),
      version: serializer.fromJson<int>(json['version']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lessonId': serializer.toJson<String>(lessonId),
      'completedCardIds': serializer.toJson<String>(completedCardIds),
      'version': serializer.toJson<int>(version),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  StudyProgressEntry copyWith({
    String? id,
    String? lessonId,
    String? completedCardIds,
    int? version,
    DateTime? updatedAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => StudyProgressEntry(
    id: id ?? this.id,
    lessonId: lessonId ?? this.lessonId,
    completedCardIds: completedCardIds ?? this.completedCardIds,
    version: version ?? this.version,
    updatedAt: updatedAt ?? this.updatedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  StudyProgressEntry copyWithCompanion(StudyProgressEntriesCompanion data) {
    return StudyProgressEntry(
      id: data.id.present ? data.id.value : this.id,
      lessonId: data.lessonId.present ? data.lessonId.value : this.lessonId,
      completedCardIds: data.completedCardIds.present
          ? data.completedCardIds.value
          : this.completedCardIds,
      version: data.version.present ? data.version.value : this.version,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyProgressEntry(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('completedCardIds: $completedCardIds, ')
          ..write('version: $version, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lessonId,
    completedCardIds,
    version,
    updatedAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyProgressEntry &&
          other.id == this.id &&
          other.lessonId == this.lessonId &&
          other.completedCardIds == this.completedCardIds &&
          other.version == this.version &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class StudyProgressEntriesCompanion
    extends UpdateCompanion<StudyProgressEntry> {
  final Value<String> id;
  final Value<String> lessonId;
  final Value<String> completedCardIds;
  final Value<int> version;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncedAt;
  final Value<int> rowid;
  const StudyProgressEntriesCompanion({
    this.id = const Value.absent(),
    this.lessonId = const Value.absent(),
    this.completedCardIds = const Value.absent(),
    this.version = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudyProgressEntriesCompanion.insert({
    required String id,
    required String lessonId,
    required String completedCardIds,
    this.version = const Value.absent(),
    required DateTime updatedAt,
    this.lastSyncedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lessonId = Value(lessonId),
       completedCardIds = Value(completedCardIds),
       updatedAt = Value(updatedAt);
  static Insertable<StudyProgressEntry> custom({
    Expression<String>? id,
    Expression<String>? lessonId,
    Expression<String>? completedCardIds,
    Expression<int>? version,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lessonId != null) 'lesson_id': lessonId,
      if (completedCardIds != null) 'completed_card_ids': completedCardIds,
      if (version != null) 'version': version,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudyProgressEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? lessonId,
    Value<String>? completedCardIds,
    Value<int>? version,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? lastSyncedAt,
    Value<int>? rowid,
  }) {
    return StudyProgressEntriesCompanion(
      id: id ?? this.id,
      lessonId: lessonId ?? this.lessonId,
      completedCardIds: completedCardIds ?? this.completedCardIds,
      version: version ?? this.version,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lessonId.present) {
      map['lesson_id'] = Variable<String>(lessonId.value);
    }
    if (completedCardIds.present) {
      map['completed_card_ids'] = Variable<String>(completedCardIds.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyProgressEntriesCompanion(')
          ..write('id: $id, ')
          ..write('lessonId: $lessonId, ')
          ..write('completedCardIds: $completedCardIds, ')
          ..write('version: $version, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DecksTable decks = $DecksTable(this);
  late final $DeckCardsTable deckCards = $DeckCardsTable(this);
  late final $WeakItemsTable weakItems = $WeakItemsTable(this);
  late final $StudyProgressEntriesTable studyProgressEntries =
      $StudyProgressEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    decks,
    deckCards,
    weakItems,
    studyProgressEntries,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'decks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('deck_cards', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DecksTableCreateCompanionBuilder =
    DecksCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      required DateTime createdAt,
      Value<int> version,
      required DateTime updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$DecksTableUpdateCompanionBuilder =
    DecksCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<int> version,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

final class $$DecksTableReferences
    extends BaseReferences<_$AppDatabase, $DecksTable, Deck> {
  $$DecksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DeckCardsTable, List<DeckCard>>
  _deckCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.deckCards,
    aliasName: 'decks__id__deck_cards__deck_id',
  );

  $$DeckCardsTableProcessedTableManager get deckCardsRefs {
    final manager = $$DeckCardsTableTableManager(
      $_db,
      $_db.deckCards,
    ).filter((f) => f.deckId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_deckCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DecksTableFilterComposer extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> deckCardsRefs(
    Expression<bool> Function($$DeckCardsTableFilterComposer f) f,
  ) {
    final $$DeckCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deckCards,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeckCardsTableFilterComposer(
            $db: $db,
            $table: $db.deckCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DecksTableOrderingComposer
    extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  Expression<T> deckCardsRefs<T extends Object>(
    Expression<T> Function($$DeckCardsTableAnnotationComposer a) f,
  ) {
    final $$DeckCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deckCards,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DeckCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.deckCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DecksTable,
          Deck,
          $$DecksTableFilterComposer,
          $$DecksTableOrderingComposer,
          $$DecksTableAnnotationComposer,
          $$DecksTableCreateCompanionBuilder,
          $$DecksTableUpdateCompanionBuilder,
          (Deck, $$DecksTableReferences),
          Deck,
          PrefetchHooks Function({bool deckCardsRefs})
        > {
  $$DecksTableTableManager(_$AppDatabase db, $DecksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecksCompanion(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                version: version,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                Value<int> version = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecksCompanion.insert(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
                version: version,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$DecksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({deckCardsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (deckCardsRefs) db.deckCards],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (deckCardsRefs)
                    await $_getPrefetchedData<Deck, $DecksTable, DeckCard>(
                      currentTable: table,
                      referencedTable: $$DecksTableReferences
                          ._deckCardsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DecksTableReferences(db, table, p0).deckCardsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.deckId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DecksTable,
      Deck,
      $$DecksTableFilterComposer,
      $$DecksTableOrderingComposer,
      $$DecksTableAnnotationComposer,
      $$DecksTableCreateCompanionBuilder,
      $$DecksTableUpdateCompanionBuilder,
      (Deck, $$DecksTableReferences),
      Deck,
      PrefetchHooks Function({bool deckCardsRefs})
    >;
typedef $$DeckCardsTableCreateCompanionBuilder =
    DeckCardsCompanion Function({
      required String deckId,
      required String cardId,
      required int sortOrder,
      required DateTime addedAt,
      Value<int> rowid,
    });
typedef $$DeckCardsTableUpdateCompanionBuilder =
    DeckCardsCompanion Function({
      Value<String> deckId,
      Value<String> cardId,
      Value<int> sortOrder,
      Value<DateTime> addedAt,
      Value<int> rowid,
    });

final class $$DeckCardsTableReferences
    extends BaseReferences<_$AppDatabase, $DeckCardsTable, DeckCard> {
  $$DeckCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DecksTable _deckIdTable(_$AppDatabase db) =>
      db.decks.createAlias('deck_cards__deck_id__decks__id');

  $$DecksTableProcessedTableManager get deckId {
    final $_column = $_itemColumn<String>('deck_id')!;

    final manager = $$DecksTableTableManager(
      $_db,
      $_db.decks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DeckCardsTableFilterComposer
    extends Composer<_$AppDatabase, $DeckCardsTable> {
  $$DeckCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DecksTableFilterComposer get deckId {
    final $$DecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableFilterComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeckCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $DeckCardsTable> {
  $$DeckCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DecksTableOrderingComposer get deckId {
    final $$DecksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableOrderingComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeckCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeckCardsTable> {
  $$DeckCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  $$DecksTableAnnotationComposer get deckId {
    final $$DecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableAnnotationComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DeckCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeckCardsTable,
          DeckCard,
          $$DeckCardsTableFilterComposer,
          $$DeckCardsTableOrderingComposer,
          $$DeckCardsTableAnnotationComposer,
          $$DeckCardsTableCreateCompanionBuilder,
          $$DeckCardsTableUpdateCompanionBuilder,
          (DeckCard, $$DeckCardsTableReferences),
          DeckCard,
          PrefetchHooks Function({bool deckId})
        > {
  $$DeckCardsTableTableManager(_$AppDatabase db, $DeckCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeckCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeckCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeckCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> deckId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeckCardsCompanion(
                deckId: deckId,
                cardId: cardId,
                sortOrder: sortOrder,
                addedAt: addedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String deckId,
                required String cardId,
                required int sortOrder,
                required DateTime addedAt,
                Value<int> rowid = const Value.absent(),
              }) => DeckCardsCompanion.insert(
                deckId: deckId,
                cardId: cardId,
                sortOrder: sortOrder,
                addedAt: addedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DeckCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({deckId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (deckId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deckId,
                                referencedTable: $$DeckCardsTableReferences
                                    ._deckIdTable(db),
                                referencedColumn: $$DeckCardsTableReferences
                                    ._deckIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DeckCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeckCardsTable,
      DeckCard,
      $$DeckCardsTableFilterComposer,
      $$DeckCardsTableOrderingComposer,
      $$DeckCardsTableAnnotationComposer,
      $$DeckCardsTableCreateCompanionBuilder,
      $$DeckCardsTableUpdateCompanionBuilder,
      (DeckCard, $$DeckCardsTableReferences),
      DeckCard,
      PrefetchHooks Function({bool deckId})
    >;
typedef $$WeakItemsTableCreateCompanionBuilder =
    WeakItemsCompanion Function({
      required String id,
      required String cardId,
      Value<int> wrongCount,
      Value<int> correctCount,
      Value<DateTime?> lastAnsweredAt,
      Value<int> version,
      required DateTime updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$WeakItemsTableUpdateCompanionBuilder =
    WeakItemsCompanion Function({
      Value<String> id,
      Value<String> cardId,
      Value<int> wrongCount,
      Value<int> correctCount,
      Value<DateTime?> lastAnsweredAt,
      Value<int> version,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$WeakItemsTableFilterComposer
    extends Composer<_$AppDatabase, $WeakItemsTable> {
  $$WeakItemsTableFilterComposer({
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

  ColumnFilters<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeakItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeakItemsTable> {
  $$WeakItemsTableOrderingComposer({
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

  ColumnOrderings<String> get cardId => $composableBuilder(
    column: $table.cardId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeakItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeakItemsTable> {
  $$WeakItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cardId =>
      $composableBuilder(column: $table.cardId, builder: (column) => column);

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$WeakItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeakItemsTable,
          WeakItem,
          $$WeakItemsTableFilterComposer,
          $$WeakItemsTableOrderingComposer,
          $$WeakItemsTableAnnotationComposer,
          $$WeakItemsTableCreateCompanionBuilder,
          $$WeakItemsTableUpdateCompanionBuilder,
          (WeakItem, BaseReferences<_$AppDatabase, $WeakItemsTable, WeakItem>),
          WeakItem,
          PrefetchHooks Function()
        > {
  $$WeakItemsTableTableManager(_$AppDatabase db, $WeakItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeakItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeakItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeakItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<DateTime?> lastAnsweredAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeakItemsCompanion(
                id: id,
                cardId: cardId,
                wrongCount: wrongCount,
                correctCount: correctCount,
                lastAnsweredAt: lastAnsweredAt,
                version: version,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cardId,
                Value<int> wrongCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<DateTime?> lastAnsweredAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeakItemsCompanion.insert(
                id: id,
                cardId: cardId,
                wrongCount: wrongCount,
                correctCount: correctCount,
                lastAnsweredAt: lastAnsweredAt,
                version: version,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeakItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeakItemsTable,
      WeakItem,
      $$WeakItemsTableFilterComposer,
      $$WeakItemsTableOrderingComposer,
      $$WeakItemsTableAnnotationComposer,
      $$WeakItemsTableCreateCompanionBuilder,
      $$WeakItemsTableUpdateCompanionBuilder,
      (WeakItem, BaseReferences<_$AppDatabase, $WeakItemsTable, WeakItem>),
      WeakItem,
      PrefetchHooks Function()
    >;
typedef $$StudyProgressEntriesTableCreateCompanionBuilder =
    StudyProgressEntriesCompanion Function({
      required String id,
      required String lessonId,
      required String completedCardIds,
      Value<int> version,
      required DateTime updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });
typedef $$StudyProgressEntriesTableUpdateCompanionBuilder =
    StudyProgressEntriesCompanion Function({
      Value<String> id,
      Value<String> lessonId,
      Value<String> completedCardIds,
      Value<int> version,
      Value<DateTime> updatedAt,
      Value<DateTime?> lastSyncedAt,
      Value<int> rowid,
    });

class $$StudyProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $StudyProgressEntriesTable> {
  $$StudyProgressEntriesTableFilterComposer({
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

  ColumnFilters<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedCardIds => $composableBuilder(
    column: $table.completedCardIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyProgressEntriesTable> {
  $$StudyProgressEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get lessonId => $composableBuilder(
    column: $table.lessonId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedCardIds => $composableBuilder(
    column: $table.completedCardIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyProgressEntriesTable> {
  $$StudyProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lessonId =>
      $composableBuilder(column: $table.lessonId, builder: (column) => column);

  GeneratedColumn<String> get completedCardIds => $composableBuilder(
    column: $table.completedCardIds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$StudyProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyProgressEntriesTable,
          StudyProgressEntry,
          $$StudyProgressEntriesTableFilterComposer,
          $$StudyProgressEntriesTableOrderingComposer,
          $$StudyProgressEntriesTableAnnotationComposer,
          $$StudyProgressEntriesTableCreateCompanionBuilder,
          $$StudyProgressEntriesTableUpdateCompanionBuilder,
          (
            StudyProgressEntry,
            BaseReferences<
              _$AppDatabase,
              $StudyProgressEntriesTable,
              StudyProgressEntry
            >,
          ),
          StudyProgressEntry,
          PrefetchHooks Function()
        > {
  $$StudyProgressEntriesTableTableManager(
    _$AppDatabase db,
    $StudyProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyProgressEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyProgressEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$StudyProgressEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> lessonId = const Value.absent(),
                Value<String> completedCardIds = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyProgressEntriesCompanion(
                id: id,
                lessonId: lessonId,
                completedCardIds: completedCardIds,
                version: version,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String lessonId,
                required String completedCardIds,
                Value<int> version = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudyProgressEntriesCompanion.insert(
                id: id,
                lessonId: lessonId,
                completedCardIds: completedCardIds,
                version: version,
                updatedAt: updatedAt,
                lastSyncedAt: lastSyncedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyProgressEntriesTable,
      StudyProgressEntry,
      $$StudyProgressEntriesTableFilterComposer,
      $$StudyProgressEntriesTableOrderingComposer,
      $$StudyProgressEntriesTableAnnotationComposer,
      $$StudyProgressEntriesTableCreateCompanionBuilder,
      $$StudyProgressEntriesTableUpdateCompanionBuilder,
      (
        StudyProgressEntry,
        BaseReferences<
          _$AppDatabase,
          $StudyProgressEntriesTable,
          StudyProgressEntry
        >,
      ),
      StudyProgressEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DecksTableTableManager get decks =>
      $$DecksTableTableManager(_db, _db.decks);
  $$DeckCardsTableTableManager get deckCards =>
      $$DeckCardsTableTableManager(_db, _db.deckCards);
  $$WeakItemsTableTableManager get weakItems =>
      $$WeakItemsTableTableManager(_db, _db.weakItems);
  $$StudyProgressEntriesTableTableManager get studyProgressEntries =>
      $$StudyProgressEntriesTableTableManager(_db, _db.studyProgressEntries);
}
