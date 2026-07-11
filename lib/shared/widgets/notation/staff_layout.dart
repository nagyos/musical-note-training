import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/models/notation_element.dart';
import 'package:musical_note_training/shared/domain/models/notation_payload.dart';
import 'package:musical_note_training/shared/domain/models/note_value.dart';
import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_engraving_rules.dart';
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

  /// Distance between adjacent staff-line centers (spatium / staff space).
  double get spatium => lineSpacing;

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
      lineSpacing * StaffEngravingRules.trebleClefStaffWidthInSpaces;

  /// Horizontal space the bass clef occupies before the first note.
  double get bassClefAdvance =>
      lineSpacing * StaffEngravingRules.bassClefStaffWidthInSpaces;

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

  double get spatium => layout.spatium;

  double get clefAdvance => switch (clef) {
        Clef.treble => layout.trebleClefAdvance,
        Clef.bass => layout.bassClefAdvance,
      };

  /// Horizontal center of the five staff lines (independent of clef width).
  double get staffCenterX => (layout.staffLeft + layout.staffRight) / 2;

  Offset noteCenter(NotationElement element) {
    final y = layout.yForStaffStep(element.staffStep);
    return Offset(staffCenterX, y);
  }

  double noteHeadRadius(NotationElement element) {
    return switch (element.value) {
      NoteValue.whole || NoteValue.half =>
        spatium * StaffEngravingRules.wholeNoteHeadRadiusInSpaces,
      _ => spatium * StaffEngravingRules.quarterNoteHeadRadiusInSpaces,
    };
  }

  bool isFilled(NotationElement element) {
    return switch (element.value) {
      NoteValue.whole || NoteValue.half => false,
      _ => true,
    };
  }

  double stemHeight(NotationElement element) {
    return spatium * StaffEngravingRules.stemHeightInSpaces;
  }

  bool stemUp(NotationElement element) {
    return element.staffStep >= StaffEngravingRules.stemUpThresholdStep;
  }

  double get trebleClefFontSize =>
      spatium * StaffEngravingRules.trebleClefFontSizeInSpaces;

  Rect trebleClefBounds() {
    final left = layout.staffLeft -
        spatium * StaffEngravingRules.trebleClefLeftOverhangInSpaces;
    final right = layout.staffLeft +
        spatium * StaffEngravingRules.trebleClefStaffWidthInSpaces;
    return Rect.fromLTRB(left, layout.padding, right, layout.size.height - layout.padding);
  }

  double get trebleClefAnchorY =>
      layout.yForStaffStep(StaffEngravingRules.trebleClefAnchorStep);

  double get _clefMinLeftX =>
      layout.padding +
      spatium * StaffEngravingRules.clefCanvasLeftMarginInSpaces;

  Offset trebleClefOffset(TextPainter textPainter) {
    final bounds = trebleClefBounds();
    return Offset(
      math.max(bounds.left, _clefMinLeftX),
      trebleClefAnchorY -
          textPainter.height * StaffEngravingRules.trebleClefGLineAnchorRatio,
    );
  }

  double get bassClefFontSize =>
      spatium * StaffEngravingRules.bassClefFontSizeInSpaces;

  Rect bassClefBounds() {
    final left = layout.staffLeft -
        spatium * StaffEngravingRules.bassClefLeftOverhangInSpaces;
    final right = layout.staffLeft +
        spatium * StaffEngravingRules.bassClefStaffWidthInSpaces;
    return Rect.fromLTRB(left, layout.padding, right, layout.size.height - layout.padding);
  }

  double get bassClefAnchorY =>
      layout.yForStaffStep(StaffEngravingRules.bassClefAnchorStep);

  Offset restGlyphOffset(NotationElement element, TextPainter textPainter) {
    final anchorY = layout.yForStaffStep(element.staffStep);
    return Offset(
      noteCenter(element).dx - textPainter.width / 2,
      anchorY - textPainter.height * StaffEngravingRules.restAnchorRatio,
    );
  }

  Offset bassClefOffset(TextPainter textPainter) {
    final bounds = bassClefBounds();
    final x = bounds.left +
        spatium * StaffEngravingRules.bassClefHorizontalNudgeInSpaces;
    return Offset(
      math.max(x, _clefMinLeftX),
      bassClefAnchorY -
          textPainter.height * StaffEngravingRules.bassClefFLineAnchorRatio,
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