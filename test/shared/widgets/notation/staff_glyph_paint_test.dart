import 'package:flutter_test/flutter_test.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_engraving_rules.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_glyph_paint.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_scale.dart';

void main() {
  group('StaffGlyphPaint font sizes', () {
    const canvasHeight = StaffMetrics.defaultCanvasHeight;

    test('tempo mark uses score-scale coefficient', () {
      final spatium = StaffScale.spatiumForCanvasHeight(canvasHeight);
      expect(
        StaffGlyphPaint.tempoMarkFontSize(canvasHeight),
        spatium * StaffEngravingRules.tempoMarkFontSizeInSpaces,
      );
    });

    test('tempo mark is smaller than isolated quiz glyphs', () {
      expect(
        StaffGlyphPaint.tempoMarkFontSize(canvasHeight),
        lessThan(StaffGlyphPaint.isolatedFontSize(canvasHeight)),
      );
    });

    test('rest font em-box fits within staff height in spatiums', () {
      expect(StaffEngravingRules.restFontSizeInSpaces, lessThanOrEqualTo(4.0));
    });
  });
}