import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/study/domain/study_answer_choices.dart';
import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/notation/rest_mark_glyph.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('rests.json seed content', () {
    late List<Card> cards;

    setUpAll(() async {
      final json = await rootBundle.loadString('assets/content/rests.json');
      final map = jsonDecode(json) as Map<String, dynamic>;
      cards = (map['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList();
    });

    test('each card uses rest-only notation', () {
      for (final card in cards) {
        expect(card.notation?.isRestOnly, isTrue);
      }
    });

    test('rest marks match seed map', () {
      for (final card in cards) {
        expect(
          card.notation?.restMark,
          RestMarkGlyph.markForCardId(card.id),
        );
      }
    });

    test('covers all registered seed rest cards', () {
      final ids = cards.map((c) => c.id).toSet();
      expect(ids, containsAll(RestMarkGlyph.seedCardMarks.keys));
    });

    test('answers match fixed choice labels', () {
      for (final card in cards) {
        expect(
          StudyAnswerChoices.restsJa,
          contains(card.answer.resolve('ja')),
        );
        expect(
          StudyAnswerChoices.restsEn,
          contains(card.answer.resolve('en')),
        );
      }
    });
  });
}