import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/weak_items/domain/weak_item_recorder.dart';
import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';
import 'package:musical_note_training/shared/domain/repositories/weak_item_repository.dart';

void main() {
  late _FakeWeakItemRepository repository;
  late WeakItemRecorder recorder;
  final answeredAt = DateTime.utc(2026, 7, 8, 12);

  setUp(() {
    repository = _FakeWeakItemRepository();
    recorder = WeakItemRecorder(repository: repository);
  });

  group('WeakItemRecorder', () {
    test('records wrong answer through repository', () async {
      await recorder.onAnswer(
        cardId: 'note-c4',
        isCorrect: false,
        answeredAt: answeredAt,
      );

      expect(repository.wrongCalls, 1);
      expect(repository.correctCalls, 0);
    });

    test('updates correct stats only when weak item exists', () async {
      repository.items['note-c4'] = _item('note-c4');

      await recorder.onAnswer(
        cardId: 'note-c4',
        isCorrect: true,
        answeredAt: answeredAt,
      );

      expect(repository.correctCalls, 1);
    });

    test('skips correct recording for non-weak cards', () async {
      await recorder.onAnswer(
        cardId: 'note-c4',
        isCorrect: true,
        answeredAt: answeredAt,
      );

      expect(repository.correctCalls, 0);
    });
  });
}

WeakItem _item(String cardId) {
  return WeakItem(
    id: 'weak-$cardId',
    cardId: cardId,
    wrongCount: 1,
    correctCount: 0,
    sync: SyncMetadata(version: 1, updatedAt: DateTime.utc(2026, 7, 8)),
  );
}

class _FakeWeakItemRepository implements WeakItemRepository {
  final items = <String, WeakItem>{};
  int wrongCalls = 0;
  int correctCalls = 0;

  @override
  Future<void> addWeakItemManually(String cardId) async {}

  @override
  Future<WeakItem?> getByCardId(String cardId) async => items[cardId];

  @override
  Future<List<WeakItem>> getWeakItems() async => items.values.toList();

  @override
  Future<WeakItem> recordCorrectAnswer({
    required String cardId,
    required DateTime answeredAt,
  }) async {
    correctCalls += 1;
    return items[cardId]!;
  }

  @override
  Future<WeakItem> recordWrongAnswer({
    required String cardId,
    required DateTime answeredAt,
  }) async {
    wrongCalls += 1;
    return _item(cardId);
  }

  @override
  Future<void> removeWeakItem(String id) async {}
}