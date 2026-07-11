import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/notation/rest_mark_glyph.dart';

void main() {
  group('RestMarkGlyph', () {
    test('maps seed card ids to rest marks', () {
      expect(RestMarkGlyph.markForCardId('rest-whole'), 'whole');
      expect(RestMarkGlyph.markForCardId('rest-half'), 'half');
      expect(RestMarkGlyph.markForCardId('rest-quarter'), 'quarter');
      expect(RestMarkGlyph.markForCardId('rest-eighth'), 'eighth');
      expect(RestMarkGlyph.markForCardId('rest-sixteenth'), 'sixteenth');
    });

    test('resolves SMuFL codepoints for known marks', () {
      expect(RestMarkGlyph.codepointForMark('whole'), isNotNull);
      expect(RestMarkGlyph.codepointForMark('unknown'), isNull);
    });
  });
}