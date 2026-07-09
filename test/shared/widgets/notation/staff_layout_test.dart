import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/domain/models/note_value.dart';
import 'package:musical_note_training/shared/domain/models/notation_element.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_layout.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

void main() {
  group('StaffLayout', () {
    test('maps staff steps to increasing y offsets', () {
      const layout = StaffLayout(size: Size(320, 140));

      final bottom = layout.yForStaffStep(0);
      final higher = layout.yForStaffStep(4);

      expect(higher, lessThan(bottom));
    });

    test('staff lines start at padding with clef overlapping left edge', () {
      const layout = StaffLayout(size: Size(320, 140));
      final notationLayout = StaffNotationLayout(layout, clef: Clef.treble);

      expect(layout.staffLeft, StaffMetrics.padding);
      expect(layout.linePositions().first.dx, StaffMetrics.padding);

      final clefBounds = notationLayout.trebleClefBounds();
      expect(clefBounds.left, lessThan(layout.staffLeft));
      expect(clefBounds.right, greaterThan(layout.staffLeft));
    });

    test('treble clef font size fits within staff span', () {
      const layout = StaffLayout(size: Size(320, 140));
      final notationLayout = StaffNotationLayout(layout, clef: Clef.treble);
      final staffSpan = layout.lineSpacing * (StaffMetrics.lineCount - 1);

      expect(
        notationLayout.trebleClefFontSize,
        lessThanOrEqualTo(staffSpan * 1.1),
      );
    });

    test('bass clef overlaps staff left edge', () {
      const layout = StaffLayout(size: Size(320, 140));
      final notationLayout = StaffNotationLayout(layout, clef: Clef.bass);

      final clefBounds = notationLayout.bassClefBounds();
      expect(clefBounds.left, lessThan(layout.staffLeft));
      expect(clefBounds.right, greaterThan(layout.staffLeft));
    });

    test('clef glyphs respect left canvas margin', () {
      const layout = StaffLayout(size: Size(320, 140));
      final minLeft =
          StaffMetrics.padding + layout.lineSpacing * StaffMetrics.clefCanvasLeftMarginInSpaces;

      for (final clef in [Clef.treble, Clef.bass]) {
        final notationLayout = StaffNotationLayout(layout, clef: clef);
        final codepoint = clef == Clef.treble
            ? StaffMetrics.smuflTrebleClef
            : StaffMetrics.smuflBassClef;
        final fontSize = clef == Clef.treble
            ? notationLayout.trebleClefFontSize
            : notationLayout.bassClefFontSize;
        final textPainter = TextPainter(
          text: TextSpan(
            text: String.fromCharCode(codepoint),
            style: TextStyle(
              fontFamily: StaffMetrics.notationFontFamily,
              fontSize: fontSize,
              height: 1,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        final offset = clef == Clef.treble
            ? notationLayout.trebleClefOffset(textPainter)
            : notationLayout.bassClefOffset(textPainter);

        expect(offset.dx, greaterThanOrEqualTo(minLeft));
      }
    });

    test('bass clef anchor aligns to F line with nudge right of bounds', () {
      const layout = StaffLayout(size: Size(320, 140));
      final notationLayout = StaffNotationLayout(layout, clef: Clef.bass);
      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(StaffMetrics.smuflBassClef),
          style: TextStyle(
            fontFamily: StaffMetrics.notationFontFamily,
            fontSize: notationLayout.bassClefFontSize,
            height: 1,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final offset = notationLayout.bassClefOffset(textPainter);
      final fLineY = notationLayout.bassClefAnchorY;
      final glyphCenterY =
          offset.dy + textPainter.height * StaffMetrics.bassClefFLineAnchorRatio;

      expect(glyphCenterY, closeTo(fLineY, layout.lineSpacing * 0.05));
      expect(
        offset.dx,
        greaterThan(notationLayout.bassClefBounds().left),
      );
    });

    test('keeps middle C ledger note inside canvas', () {
      const layout = StaffLayout(size: Size(320, 140));
      final notationLayout = StaffNotationLayout(layout, clef: Clef.treble);
      const element = NotationElement(staffStep: -2, value: NoteValue.quarter);

      final center = notationLayout.noteCenter(element);
      final radius = notationLayout.noteHeadRadius(element);
      final headHalfHeight =
          radius * StaffMetrics.noteHeadHeightScale / 2;

      expect(center.dy - headHalfHeight, greaterThanOrEqualTo(0));
      expect(center.dy + headHalfHeight, lessThanOrEqualTo(140));
    });
  });

  group('demoMiddleCQuarter', () {
    test('uses treble clef with one quarter note', () {
      expect(demoMiddleCQuarter.clef?.name, 'treble');
      expect(demoMiddleCQuarter.elements, hasLength(1));
      expect(demoMiddleCQuarter.elements.first.staffStep, -2);
    });
  });
}