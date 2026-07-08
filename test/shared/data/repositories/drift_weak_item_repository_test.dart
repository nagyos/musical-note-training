import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/core/utils/id_generator.dart';
import 'package:musical_note_training/shared/data/database/app_database.dart';
import 'package:musical_note_training/shared/data/repositories/drift_weak_item_repository.dart';

void main() {
  late AppDatabase database;
  late DriftWeakItemRepository repository;

  setUp(() {
    database = AppDatabase.inMemory();
    repository = DriftWeakItemRepository(
      database: database,
      idGenerator: SequentialIdGenerator('weak'),
    );
  });

  tearDown(() async {
    await database.close();
  });

  group('DriftWeakItemRepository', () {
    test('recordWrongAnswer creates new weak item', () async {
      final item = await repository.recordWrongAnswer(
        cardId: 'note-c4',
        answeredAt: DateTime.utc(2026, 7, 8),
      );

      expect(item.cardId, 'note-c4');
      expect(item.wrongCount, 1);
      expect(item.correctCount, 0);
    });

    test('recordWrongAnswer increments existing item', () async {
      await repository.recordWrongAnswer(
        cardId: 'note-c4',
        answeredAt: DateTime.utc(2026, 7, 8),
      );
      final second = await repository.recordWrongAnswer(
        cardId: 'note-c4',
        answeredAt: DateTime.utc(2026, 7, 9),
      );

      expect(second.wrongCount, 2);
      expect((await repository.getWeakItems()), hasLength(1));
    });

    test('removeWeakItem deletes row', () async {
      final item = await repository.recordWrongAnswer(
        cardId: 'note-c4',
        answeredAt: DateTime.utc(2026, 7, 8),
      );
      await repository.removeWeakItem(item.id);

      expect(await repository.getWeakItems(), isEmpty);
    });

    test('addWeakItemManually creates entry with zero counts', () async {
      await repository.addWeakItemManually('note-d4');
      final items = await repository.getWeakItems();

      expect(items, hasLength(1));
      expect(items.first.cardId, 'note-d4');
      expect(items.first.wrongCount, 0);
    });
  });
}