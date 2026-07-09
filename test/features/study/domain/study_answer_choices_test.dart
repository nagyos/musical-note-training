import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/study/domain/study_answer_choices.dart';

void main() {
  group('StudyAnswerChoices', () {
    test('forLocale returns fixed solfege scale in ja order', () {
      expect(
        StudyAnswerChoices.forLocale('ja'),
        ['ド', 'レ', 'ミ', 'ファ', 'ソ', 'ラ', 'シ'],
      );
    });

    test('forLocale returns fixed letter scale in en order', () {
      expect(
        StudyAnswerChoices.forLocale('en'),
        ['C', 'D', 'E', 'F', 'G', 'A', 'B'],
      );
    });

    test('zigzagRows alternates bottom and top like C E G B / D F A', () {
      expect(StudyAnswerChoices.zigzagRows, hasLength(7));
      // C E G B (even indices) low; D F A (odd indices) high
      expect(StudyAnswerChoices.zigzagRows, [1, 0, 1, 0, 1, 0, 1]);
    });
  });
}