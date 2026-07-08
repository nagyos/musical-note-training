import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Decks extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DeckCards extends Table {
  TextColumn get deckId =>
      text().references(Decks, #id, onDelete: KeyAction.cascade)();
  TextColumn get cardId => text()();
  IntColumn get sortOrder => integer()();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {deckId, cardId};
}

class WeakItems extends Table {
  TextColumn get id => text()();
  TextColumn get cardId => text().unique()();
  IntColumn get wrongCount => integer().withDefault(const Constant(0))();
  IntColumn get correctCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastAnsweredAt => dateTime().nullable()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class StudyProgressEntries extends Table {
  TextColumn get id => text()();
  TextColumn get lessonId => text()();
  TextColumn get completedCardIds => text()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [Decks, DeckCards, WeakItems, StudyProgressEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.inMemory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}

Future<AppDatabase> openAppDatabase() async {
  final executor = driftDatabase(name: 'musical_note_training');
  return AppDatabase(executor);
}