import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/study/domain/study_answer_choices.dart';
import 'package:musical_note_training/shared/domain/models/card_category_type.dart';

void main() {
  group('StudyAnswerChoices', () {
    test('forCategory returns fixed solfege scale for notes', () {
      expect(
        StudyAnswerChoices.forCategory(CardCategoryType.note, 'ja'),
        ['ド', 'レ', 'ミ', 'ファ', 'ソ', 'ラ', 'シ'],
      );
    });

    test('forCategory returns fixed letter scale for notes', () {
      expect(
        StudyAnswerChoices.forCategory(CardCategoryType.note, 'en'),
        ['C', 'D', 'E', 'F', 'G', 'A', 'B'],
      );
    });

    test('localeForCategory uses ui locale for rests', () {
      expect(
        StudyAnswerChoices.localeForCategory(
          category: CardCategoryType.rest,
          noteAnswerLocale: 'en',
          uiLocale: 'ja',
        ),
        'ja',
      );
    });

    test('localeForCategory uses note answer locale for notes', () {
      expect(
        StudyAnswerChoices.localeForCategory(
          category: CardCategoryType.note,
          noteAnswerLocale: 'en',
          uiLocale: 'ja',
        ),
        'en',
      );
    });

    test('forCategory returns five rest names in ja', () {
      expect(
        StudyAnswerChoices.forCategory(CardCategoryType.rest, 'ja'),
        StudyAnswerChoices.restsJa,
      );
    });

    test('forCategory returns five rest names in en', () {
      expect(
        StudyAnswerChoices.forCategory(CardCategoryType.rest, 'en'),
        StudyAnswerChoices.restsEn,
      );
    });

    test('forCategory returns five dynamic names', () {
      expect(
        StudyAnswerChoices.forCategory(CardCategoryType.dynamic, 'ja'),
        StudyAnswerChoices.dynamicsJa,
      );
      expect(
        StudyAnswerChoices.forCategory(CardCategoryType.dynamic, 'en'),
        StudyAnswerChoices.dynamicsEn,
      );
    });

    test('forCategory returns six symbol names', () {
      expect(
        StudyAnswerChoices.forCategory(CardCategoryType.symbol, 'ja'),
        StudyAnswerChoices.symbolsJa,
      );
      expect(
        StudyAnswerChoices.forCategory(CardCategoryType.symbol, 'en'),
        StudyAnswerChoices.symbolsEn,
      );
    });

    test('uses zigzag layout only for notes', () {
      expect(StudyAnswerChoices.usesZigzagLayout(CardCategoryType.note), isTrue);
      expect(
        StudyAnswerChoices.usesZigzagLayout(CardCategoryType.dynamic),
        isFalse,
      );
    });

    test('isTopRow places D F A above C E G B', () {
      expect(StudyAnswerChoices.isTopRow(0), isFalse);
      expect(StudyAnswerChoices.isTopRow(1), isTrue);
      expect(StudyAnswerChoices.isTopRow(2), isFalse);
      expect(StudyAnswerChoices.isTopRow(3), isTrue);
      expect(StudyAnswerChoices.isTopRow(4), isFalse);
      expect(StudyAnswerChoices.isTopRow(5), isTrue);
      expect(StudyAnswerChoices.isTopRow(6), isFalse);
    });
  });
}