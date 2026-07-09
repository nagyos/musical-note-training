import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/notation/tempo_mark_label.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('tempos.json seed content', () {
    late List<Card> cards;

    setUpAll(() async {
      final json = await rootBundle.loadString('assets/content/tempos.json');
      final map = jsonDecode(json) as Map<String, dynamic>;
      cards = (map['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList();
    });

    test('each card uses tempo-only notation', () {
      for (final card in cards) {
        expect(card.notation?.isTempoOnly, isTrue);
      }
    });

    test('tempo marks match seed map', () {
      for (final card in cards) {
        expect(
          card.notation?.tempoMark,
          TempoMarkLabel.markForCardId(card.id),
        );
      }
    });

    test('covers all registered seed tempo cards', () {
      final ids = cards.map((c) => c.id).toSet();
      expect(ids, containsAll(TempoMarkLabel.seedCardMarks.keys));
    });
  });
}