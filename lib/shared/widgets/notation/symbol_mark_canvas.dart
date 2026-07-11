import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/notation/symbol_mark_glyph.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_glyph_paint.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

/// Renders a single symbol glyph large enough to read without a staff.
class SymbolMarkCanvas extends StatelessWidget {
  const SymbolMarkCanvas({
    super.key,
    required this.mark,
    this.height = StaffMetrics.defaultCanvasHeight,
  });

  final String mark;
  final double height;

  @override
  Widget build(BuildContext context) {
    final codepoint = SymbolMarkGlyph.codepointForMark(mark);
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
        painter: _SymbolMarkPainter(
          codepoint: codepoint,
          color: color,
        ),
      ),
    );
  }
}

class _SymbolMarkPainter extends CustomPainter {
  const _SymbolMarkPainter({
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
  bool shouldRepaint(covariant _SymbolMarkPainter oldDelegate) {
    return oldDelegate.codepoint != codepoint || oldDelegate.color != color;
  }
}