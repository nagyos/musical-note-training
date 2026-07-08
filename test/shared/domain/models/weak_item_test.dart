import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/sync_metadata.dart';
import 'package:musical_note_training/shared/domain/models/weak_item.dart';

void main() {
  group('WeakItem', () {
    final base = WeakItem(
      id: 'weak-1',
      cardId: 'note-c4',
      wrongCount: 2,
      correctCount: 1,
      sync: SyncMetadata(
        version: 1,
        updatedAt: DateTime.utc(2026, 7, 8),
      ),
    );

    test('recordAnswer increments wrong count', () {
      final answeredAt = DateTime.utc(2026, 7, 8, 12);
      final updated = base.recordAnswer(isCorrect: false, answeredAt: answeredAt);

      expect(updated.wrongCount, 3);
      expect(updated.correctCount, 1);
      expect(updated.sync.version, 2);
    });

    test('accuracy reflects answer ratio', () {
      expect(base.accuracy, closeTo(1 / 3, 0.001));
    });
  });
}