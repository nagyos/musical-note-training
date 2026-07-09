import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/notation/tempo_mark_label.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

/// Renders an Italian tempo mark in score style (large italic text).
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
    final text = TempoMarkLabel.textForMark(mark) ?? mark;
    final color = Theme.of(context).colorScheme.onSurface;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: color,
              ),
        ),
      ),
    );
  }
}