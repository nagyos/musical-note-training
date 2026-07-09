import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/card.dart';
import 'package:musical_note_training/shared/domain/notation/rest_staff_pitch.dart';

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

    test('each seed card staffStep matches rest pitch map', () {
      for (final card in cards) {
        final expected = RestStaffPitch.staffStepForCardId(card.id);
        if (expected == null) continue;

        final element = card.notation!.elements.first;
        expect(element.isRest, isTrue);
        expect(
          element.staffStep,
          expected,
          reason: '${card.id} staffStep should match rest position',
        );
      }
    });

    test('covers all five seed rest cards', () {
      final ids = cards.map((c) => c.id).toSet();
      expect(ids, containsAll(RestStaffPitch.seedCardStaffSteps.keys));
    });
  });
}