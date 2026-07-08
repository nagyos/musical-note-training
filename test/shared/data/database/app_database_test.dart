import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/data/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.inMemory();
  });

  tearDown(() async {
    await database.close();
  });

  test('opens in-memory database and writes a deck row', () async {
    final now = DateTime.utc(2026, 7, 8);

    await database.into(database.decks).insert(
          DecksCompanion.insert(
            id: 'deck-1',
            name: '復習デッキ',
            createdAt: now,
            updatedAt: now,
          ),
        );

    final rows = await database.select(database.decks).get();
    expect(rows, hasLength(1));
    expect(rows.first.name, '復習デッキ');
  });
}