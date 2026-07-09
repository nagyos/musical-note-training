import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/notation/symbol_mark_glyph.dart';
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
    final fontSize = size.height * 0.55;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(codepoint),
        style: TextStyle(
          fontFamily: StaffMetrics.notationFontFamily,
          fontSize: fontSize,
          height: 1,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _SymbolMarkPainter oldDelegate) {
    return oldDelegate.codepoint != codepoint || oldDelegate.color != color;
  }
}