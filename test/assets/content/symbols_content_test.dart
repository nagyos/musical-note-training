import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/notation/symbol_mark_glyph.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('symbols.json seed content', () {
    late List<Card> cards;

    setUpAll(() async {
      final json = await rootBundle.loadString('assets/content/symbols.json');
      final map = jsonDecode(json) as Map<String, dynamic>;
      cards = (map['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList();
    });

    test('each card uses symbol-only notation', () {
      for (final card in cards) {
        expect(card.notation?.isSymbolOnly, isTrue);
      }
    });

    test('symbol marks match seed map', () {
      for (final card in cards) {
        expect(
          card.notation?.symbolMark,
          SymbolMarkGlyph.markForCardId(card.id),
        );
      }
    });

    test('covers all registered seed symbol cards', () {
      final ids = cards.map((c) => c.id).toSet();
      expect(ids, containsAll(SymbolMarkGlyph.seedCardMarks.keys));
    });
  });
}