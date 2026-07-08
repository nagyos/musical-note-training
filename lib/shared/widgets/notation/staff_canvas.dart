import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/models/notation_payload.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_layout.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_painter.dart';

/// Renders a five-line staff with notation via [StaffPainter].
class StaffCanvas extends StatelessWidget {
  const StaffCanvas({
    super.key,
    this.payload,
    this.height = StaffMetrics.defaultCanvasHeight,
  });

  final NotationPayload? payload;
  final double height;

  @override
  Widget build(BuildContext context) {
    final effectivePayload = payload ?? demoMiddleCQuarter;
    final color = Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: StaffPainter(
          payload: effectivePayload,
          color: color,
        ),
      ),
    );
  }
}