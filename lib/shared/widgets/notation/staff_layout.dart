import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/models/notation_element.dart';
import 'package:musical_note_training/shared/domain/models/notation_payload.dart';
import 'package:musical_note_training/shared/domain/models/note_value.dart';
import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

/// Layout constants and coordinate helpers for staff rendering.
class StaffLayout {
  const StaffLayout({
    required this.size,
    this.lineCount = StaffMetrics.lineCount,
    this.padding = StaffMetrics.padding,
  });

  final Size size;
  final int lineCount;
  final double padding;

  double get lineSpacing {
    final staffHalfSteps = (lineCount - 1) * 2;
    final totalHalfSteps = staffHalfSteps +
        StaffMetrics.ledgerSlotsBelow +
        StaffMetrics.ledgerSlotsAbove;
    final availableHeight = size.height - padding * 2;
    return availableHeight / (totalHalfSteps / 2);
  }

  double get _halfLine => lineSpacing / 2;

  double get bottomLineY =>
      size.height -
      padding -
      StaffMetrics.ledgerSlotsBelow * _halfLine;

  /// Left edge of the five staff lines (clef overlaps this region).
  double get staffLeft => padding;

  double get staffRight => size.width - padding;

  /// Horizontal space the treble clef occupies before the first note.
  double get trebleClefAdvance =>
      lineSpacing * StaffMetrics.trebleClefStaffWidthScale;

  /// Horizontal space the bass clef occupies before the first note.
  double get bassClefAdvance =>
      lineSpacing * StaffMetrics.bassClefStaffWidthScale;

  double yForStaffStep(int staffStep) {
    return bottomLineY - staffStep * _halfLine;
  }

  List<Offset> linePositions() {
    return List.generate(lineCount, (index) {
      final y = yForStaffStep(index * 2);
      return Offset(staffLeft, y);
    });
  }
}

/// Maps notation domain models to canvas geometry.
class StaffNotationLayout {
  StaffNotationLayout(this.layout, {required this.clef});

  final StaffLayout layout;
  final Clef clef;

  double get clefAdvance => switch (clef) {
        Clef.treble => layout.trebleClefAdvance,
        Clef.bass => layout.bassClefAdvance,
      };

  Offset noteCenter(NotationElement element) {
    final noteAreaLeft = layout.staffLeft + clefAdvance;
    final noteSpan = layout.staffRight - noteAreaLeft;
    final x = noteAreaLeft + noteSpan * StaffMetrics.noteXRatio;
    final y = layout.yForStaffStep(element.staffStep);
    return Offset(x, y);
  }

  double noteHeadRadius(NotationElement element) {
    return switch (element.value) {
      NoteValue.whole || NoteValue.half =>
        layout.lineSpacing * StaffMetrics.wholeNoteHeadScale,
      _ => layout.lineSpacing * StaffMetrics.quarterNoteHeadScale,
    };
  }

  bool isFilled(NotationElement element) {
    return switch (element.value) {
      NoteValue.whole || NoteValue.half => false,
      _ => true,
    };
  }

  double stemHeight(NotationElement element) {
    return layout.lineSpacing * StaffMetrics.stemHeightScale;
  }

  bool stemUp(NotationElement element) {
    return element.staffStep >= StaffMetrics.stemUpThresholdStep;
  }

  double get trebleClefFontSize =>
      layout.lineSpacing * StaffMetrics.trebleClefFontSizeInSpaces;

  Rect trebleClefBounds() {
    final left = layout.staffLeft -
        layout.lineSpacing * StaffMetrics.trebleClefLeftOverhangScale;
    final right =
        layout.staffLeft + layout.lineSpacing * StaffMetrics.trebleClefStaffWidthScale;
    return Rect.fromLTRB(left, layout.padding, right, layout.size.height - layout.padding);
  }

  /// Y coordinate of the G line used to anchor the treble clef glyph.
  double get trebleClefAnchorY =>
      layout.yForStaffStep(StaffMetrics.trebleClefAnchorStep);

  double get _clefMinLeftX =>
      layout.padding +
      layout.lineSpacing * StaffMetrics.clefCanvasLeftMarginInSpaces;

  Offset trebleClefOffset(TextPainter textPainter) {
    final bounds = trebleClefBounds();
    return Offset(
      math.max(bounds.left, _clefMinLeftX),
      trebleClefAnchorY -
          textPainter.height * StaffMetrics.trebleClefGLineAnchorRatio,
    );
  }

  double get bassClefFontSize =>
      layout.lineSpacing * StaffMetrics.bassClefFontSizeInSpaces;

  Rect bassClefBounds() {
    final left =
        layout.staffLeft - layout.lineSpacing * StaffMetrics.bassClefLeftOverhangScale;
    final right =
        layout.staffLeft + layout.lineSpacing * StaffMetrics.bassClefStaffWidthScale;
    return Rect.fromLTRB(left, layout.padding, right, layout.size.height - layout.padding);
  }

  double get bassClefAnchorY =>
      layout.yForStaffStep(StaffMetrics.bassClefAnchorStep);

  Offset bassClefOffset(TextPainter textPainter) {
    final bounds = bassClefBounds();
    final x = bounds.left +
        layout.lineSpacing * StaffMetrics.bassClefHorizontalNudgeInSpaces;
    return Offset(
      math.max(x, _clefMinLeftX),
      bassClefAnchorY -
          textPainter.height * StaffMetrics.bassClefFLineAnchorRatio,
    );
  }
}

/// Demo payload for the home screen PoC (treble clef, middle C as quarter note).
NotationPayload get demoMiddleCQuarter => const NotationPayload(
      clef: Clef.treble,
      elements: [
        NotationElement(
          staffStep: -2,
          value: NoteValue.quarter,
        ),
      ],
    );