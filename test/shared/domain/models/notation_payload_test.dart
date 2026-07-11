import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/domain/models/notation_payload.dart';

void main() {
  group('NotationPayload', () {
    test('isDynamicOnly when dynamicMark is set without clef', () {
      const payload = NotationPayload(dynamicMark: 'f');
      expect(payload.isDynamicOnly, isTrue);
    });

    test('is not dynamic-only when clef is present', () {
      const payload = NotationPayload(clef: Clef.treble);
      expect(payload.isDynamicOnly, isFalse);
    });

    test('fromJson parses dynamic-only payload', () {
      final payload = NotationPayload.fromJson({'dynamicMark': 'mp'});
      expect(payload.dynamicMark, 'mp');
      expect(payload.clef, isNull);
      expect(payload.elements, isEmpty);
    });

    test('isSymbolOnly when symbolMark is set without clef', () {
      const payload = NotationPayload(symbolMark: 'sharp');
      expect(payload.isSymbolOnly, isTrue);
      expect(payload.isDynamicOnly, isFalse);
    });

    test('fromJson parses symbol-only payload', () {
      final payload = NotationPayload.fromJson({'symbolMark': 'fermata'});
      expect(payload.symbolMark, 'fermata');
      expect(payload.clef, isNull);
    });

    test('isTempoOnly when tempoMark is set without clef', () {
      const payload = NotationPayload(tempoMark: 'allegro');
      expect(payload.isTempoOnly, isTrue);
    });

    test('fromJson parses tempo-only payload', () {
      final payload = NotationPayload.fromJson({'tempoMark': 'andante'});
      expect(payload.tempoMark, 'andante');
      expect(payload.clef, isNull);
    });

    test('isRestOnly when restMark is set without clef', () {
      const payload = NotationPayload(restMark: 'quarter');
      expect(payload.isRestOnly, isTrue);
      expect(payload.isDynamicOnly, isFalse);
    });

    test('fromJson parses rest-only payload', () {
      final payload = NotationPayload.fromJson({'restMark': 'whole'});
      expect(payload.restMark, 'whole');
      expect(payload.clef, isNull);
      expect(payload.elements, isEmpty);
    });
  });
}