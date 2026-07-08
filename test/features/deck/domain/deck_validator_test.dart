import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/features/deck/domain/deck_validator.dart';

void main() {
  group('DeckValidator', () {
    test('rejects empty name', () {
      expect(
        () => DeckValidator.validateName(''),
        throwsA(isA<DeckValidationException>()),
      );
    });

    test('rejects whitespace-only name', () {
      expect(
        () => DeckValidator.validateName('   '),
        throwsA(isA<DeckValidationException>()),
      );
    });

    test('returns trimmed name for valid input', () {
      expect(DeckValidator.validateName('  復習  '), '復習');
    });
  });
}