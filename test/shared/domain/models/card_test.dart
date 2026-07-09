import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/card.dart';

void main() {
  group('Card.fromJson', () {
    test('parses notation card from seed JSON shape', () {
      final card = Card.fromJson({
        'id': 'note-c4',
        'categoryType': 'note',
        'lessonId': 'note-middle-c',
        'notation': {
          'clef': 'treble',
          'elements': [
            {'staffStep': -2, 'value': 'quarter'},
          ],
        },
        'answer': {'ja': 'ド', 'en': 'C'},
        'sortOrder': 0,
        'version': 1,
        'updatedAt': '2026-07-08T00:00:00.000Z',
      });

      expect(card.id, 'note-c4');
      expect(card.notation?.clef?.name, 'treble');
      expect(card.notation?.elements.first.staffStep, -2);
      expect(card.answer.resolve('ja'), 'ド');
      expect(card.sync.version, 1);
    });

    test('round-trips through toJson', () {
      final original = Card.fromJson({
        'id': 'note-d4',
        'categoryType': 'note',
        'lessonId': 'note-middle-c',
        'notation': {
          'clef': 'treble',
          'elements': [
            {'staffStep': 0, 'value': 'quarter'},
          ],
        },
        'answer': {'ja': 'レ', 'en': 'D'},
        'sortOrder': 1,
        'version': 1,
        'updatedAt': '2026-07-08T00:00:00.000Z',
      });

      final restored = Card.fromJson(original.toJson());
      expect(restored.id, original.id);
      expect(restored.answer.resolve('en'), 'D');
    });
  });
}