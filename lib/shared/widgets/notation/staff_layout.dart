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
    final availableHeight = size.height - padding * 2;
    return availableHeight / (lineCount - 1);
  }

  double get staffLeft => padding + size.width * StaffMetrics.clefAreaWidthRatio;

  double get staffRight => size.width - padding;

  double yForStaffStep(int staffStep) {
    final bottomLineY = size.height - padding;
    return bottomLineY - staffStep * (lineSpacing / 2);
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
  StaffNotationLayout(this.layout);

  final StaffLayout layout;

  Offset noteCenter(NotationElement element) {
    final x = layout.staffLeft +
        (layout.staffRight - layout.staffLeft) * StaffMetrics.noteXRatio;
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

  Rect trebleClefBounds() {
    final top = layout.yForStaffStep(StaffMetrics.trebleClefTopStep);
    final bottom = layout.yForStaffStep(StaffMetrics.trebleClefBottomStep);
    return Rect.fromLTRB(
      layout.padding,
      top,
      layout.staffLeft - layout.padding * StaffMetrics.clefRightPaddingRatio,
      bottom,
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