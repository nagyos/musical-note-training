import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/notation/tempo_mark_glyph.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

/// Renders an Italian tempo mark in Bravura score typography (not UI text).
class TempoMarkCanvas extends StatelessWidget {
  const TempoMarkCanvas({
    super.key,
    required this.mark,
    this.height = StaffMetrics.defaultCanvasHeight,
  });

  final String mark;
  final double height;

  @override
  Widget build(BuildContext context) {
    final scoreText = TempoMarkGlyph.scoreTextForMark(mark);
    if (scoreText == null) {
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
        painter: _TempoMarkPainter(
          scoreText: scoreText,
          color: color,
        ),
      ),
    );
  }
}

class _TempoMarkPainter extends CustomPainter {
  const _TempoMarkPainter({
    required this.scoreText,
    required this.color,
  });

  final String scoreText;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final fontSize = size.height * 0.55;
    final textPainter = TextPainter(
      text: TextSpan(
        text: scoreText,
        style: TextStyle(
          fontFamily: StaffMetrics.notationFontFamily,
          fontSize: fontSize,
          height: 1,
          fontStyle: FontStyle.italic,
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
  bool shouldRepaint(covariant _TempoMarkPainter oldDelegate) {
    return oldDelegate.scoreText != scoreText || oldDelegate.color != color;
  }
}