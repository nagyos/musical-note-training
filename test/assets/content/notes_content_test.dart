import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/domain/notation/bass_staff_pitch.dart';
import 'package:musical_note_training/shared/domain/notation/treble_staff_pitch.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('notes.json seed content', () {
    late List<Card> cards;

    setUpAll(() async {
      final json = await rootBundle.loadString('assets/content/notes.json');
      final map = jsonDecode(json) as Map<String, dynamic>;
      cards = (map['cards'] as List<dynamic>)
          .map((e) => Card.fromJson(e as Map<String, dynamic>))
          .toList();
    });

    test('each seed card staffStep matches pitch map for its clef', () {
      for (final card in cards) {
        final clef = card.notation?.clef;
        final expected = switch (clef) {
          Clef.treble => TrebleStaffPitch.staffStepForCardId(card.id),
          Clef.bass => BassStaffPitch.staffStepForCardId(card.id),
          _ => null,
        };
        if (expected == null) continue;

        final actual = card.notation?.elements.first.staffStep;
        expect(
          actual,
          expected,
          reason: '${card.id} staffStep should match answer/hint pitch',
        );
      }
    });

    test('covers all registered seed note cards', () {
      final ids = cards.map((c) => c.id).toSet();
      expect(ids, containsAll(TrebleStaffPitch.seedCardStaffSteps.keys));
      expect(ids, containsAll(BassStaffPitch.seedCardStaffSteps.keys));
    });
  });
}