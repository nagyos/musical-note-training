import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/models/notation_payload.dart';
import 'package:musical_note_training/shared/widgets/notation/dynamic_mark_canvas.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_canvas.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';
import 'package:musical_note_training/shared/widgets/notation/symbol_mark_canvas.dart';
import 'package:musical_note_training/shared/widgets/notation/tempo_mark_canvas.dart';

/// Picks the correct notation renderer for a quiz card payload.
class NotationQuestionCanvas extends StatelessWidget {
  const NotationQuestionCanvas({
    super.key,
    required this.payload,
    this.height = StaffMetrics.defaultCanvasHeight,
  });

  final NotationPayload payload;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (payload.isTempoOnly) {
      return TempoMarkCanvas(mark: payload.tempoMark!, height: height);
    }
    if (payload.isSymbolOnly) {
      return SymbolMarkCanvas(mark: payload.symbolMark!, height: height);
    }
    if (payload.isDynamicOnly) {
      return DynamicMarkCanvas(mark: payload.dynamicMark!, height: height);
    }
    return StaffCanvas(payload: payload, height: height);
  }
}