import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/widgets/notation/staff_engraving_rules.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_scale.dart';

/// Shared SMuFL / score-text painting for isolated mark canvases.
abstract final class StaffGlyphPaint {
  static double isolatedFontSize(double canvasHeight) =>
      StaffScale.spatiumForCanvasHeight(canvasHeight) *
      StaffEngravingRules.isolatedGlyphFontSizeInSpaces;

  static double tempoMarkFontSize(double canvasHeight) =>
      StaffScale.spatiumForCanvasHeight(canvasHeight) *
      StaffEngravingRules.tempoMarkFontSizeInSpaces;

  static void paintCenteredGlyph(
    Canvas canvas,
    Size size, {
    required String text,
    required Color color,
    FontStyle fontStyle = FontStyle.normal,
    double? fontSize,
  }) {
    final resolvedFontSize = fontSize ?? isolatedFontSize(size.height);
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontFamily: StaffMetrics.notationFontFamily,
          fontSize: resolvedFontSize,
          height: 1,
          fontStyle: fontStyle,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }
}