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

    test('isTopRow places D F A above C E G B', () {
      expect(StudyAnswerChoices.isTopRow(0), isFalse); // C
      expect(StudyAnswerChoices.isTopRow(1), isTrue); // D
      expect(StudyAnswerChoices.isTopRow(2), isFalse); // E
      expect(StudyAnswerChoices.isTopRow(3), isTrue); // F
      expect(StudyAnswerChoices.isTopRow(4), isFalse); // G
      expect(StudyAnswerChoices.isTopRow(5), isTrue); // A
      expect(StudyAnswerChoices.isTopRow(6), isFalse); // B
    });
  });
}