import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/notation/dynamic_mark_glyph.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('dynamics.json seed content', () {
    late List<Card> cards;

    setUpAll(() async {
      final json = await rootBundle.loadString('assets/content/dynamics.json');
      final map = jsonDecode(json) as Map<String, dynamic>;
      cards = (map['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList();
    });

    test('each card uses dynamic-only notation', () {
      for (final card in cards) {
        expect(card.notation?.isDynamicOnly, isTrue);
      }
    });

    test('dynamic marks match seed map', () {
      for (final card in cards) {
        expect(
          card.notation?.dynamicMark,
          DynamicMarkGlyph.markForCardId(card.id),
        );
      }
    });

    test('covers all registered seed dynamic cards', () {
      final ids = cards.map((c) => c.id).toSet();
      expect(ids, containsAll(DynamicMarkGlyph.seedCardMarks.keys));
    });
  });
}