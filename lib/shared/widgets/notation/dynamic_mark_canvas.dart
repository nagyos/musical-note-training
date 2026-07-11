import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/notation/dynamic_mark_glyph.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_glyph_paint.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

/// Renders a single dynamic mark glyph large enough to read without a staff.
class DynamicMarkCanvas extends StatelessWidget {
  const DynamicMarkCanvas({
    super.key,
    required this.mark,
    this.height = StaffMetrics.defaultCanvasHeight,
  });

  final String mark;
  final double height;

  @override
  Widget build(BuildContext context) {
    final codepoint = DynamicMarkGlyph.codepointForMark(mark);
    if (codepoint == null) {
      return SizedBox(
        height: height,
        child: Center(child: Text(mark)),
      );
    }

    final color = Theme.of(context).colorScheme.onSurface;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _DynamicMarkPainter(
          codepoint: codepoint,
          color: color,
        ),
      ),
    );
  }
}

class _DynamicMarkPainter extends CustomPainter {
  const _DynamicMarkPainter({
    required this.codepoint,
    required this.color,
  });

  final int codepoint;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    StaffGlyphPaint.paintCenteredGlyph(
      canvas,
      size,
      text: String.fromCharCode(codepoint),
      color: color,
    );
  }

  @override
  bool shouldRepaint(covariant _DynamicMarkPainter oldDelegate) {
    return oldDelegate.codepoint != codepoint || oldDelegate.color != color;
  }
}