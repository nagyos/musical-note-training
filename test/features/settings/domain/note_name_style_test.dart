import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/settings/domain/note_name_style.dart';

void main() {
  group('NoteNameStyle', () {
    test('solfege uses ja answer locale', () {
      expect(NoteNameStyle.solfege.answerLocaleKey, 'ja');
    });

    test('letter uses en answer locale', () {
      expect(NoteNameStyle.letter.answerLocaleKey, 'en');
    });

    test('fromStorage maps persisted values', () {
      expect(NoteNameStyle.fromStorage('letter'), NoteNameStyle.letter);
      expect(NoteNameStyle.fromStorage('solfege'), NoteNameStyle.solfege);
      expect(NoteNameStyle.fromStorage(null), NoteNameStyle.solfege);
    });
  });
}