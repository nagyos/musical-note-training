import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/domain/models/note_value.dart';
import 'package:musical_note_training/shared/domain/models/notation_element.dart';
import 'package:musical_note_training/shared/domain/models/notation_payload.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_layout.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_ledger.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';


/// Draws a five-line staff with treble or bass clef and notes.
class StaffPainter extends CustomPainter {
  StaffPainter({
    required this.payload,
    this.color = Colors.black87,
  });

  final NotationPayload payload;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final layout = StaffLayout(size: size);
    final notationLayout = StaffNotationLayout(layout, clef: payload.clef);
    final paint = Paint()
      ..color = color
      ..strokeWidth = StaffMetrics.strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final line in layout.linePositions()) {
      canvas.drawLine(
        Offset(layout.staffLeft, line.dy),
        Offset(layout.staffRight, line.dy),
        paint,
      );
    }

    switch (payload.clef) {
      case Clef.treble:
        _drawTrebleClef(canvas, notationLayout, paint);
      case Clef.bass:
        _drawBassClef(canvas, notationLayout, paint);
    }

    for (final element in payload.elements) {
      if (!element.isRest) {
        _drawLedgerLines(canvas, layout, notationLayout, element, paint);
      }
      if (element.isRest) {
        _drawRest(canvas, notationLayout, element, paint);
      } else {
        _drawNote(canvas, notationLayout, element, paint);
      }
    }
  }

  void _drawLedgerLines(
    Canvas canvas,
    StaffLayout layout,
    StaffNotationLayout notationLayout,
    NotationElement element,
    Paint paint,
  ) {
    final center = notationLayout.noteCenter(element);
    final noteRadius = notationLayout.noteHeadRadius(element);
    final halfWidth = noteRadius *
        StaffMetrics.noteHeadWidthScale *
        StaffMetrics.ledgerHalfWidthNoteScale;

    for (final step in StaffLedger.ledgerStepsForNote(element.staffStep)) {
      final y = layout.yForStaffStep(step);
      canvas.drawLine(
        Offset(center.dx - halfWidth, y),
        Offset(center.dx + halfWidth, y),
        paint,
      );
    }
  }

  void _drawTrebleClef(
    Canvas canvas,
    StaffNotationLayout layout,
    Paint paint,
  ) {
    final fontSize = layout.trebleClefFontSize;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(StaffMetrics.smuflTrebleClef),
        style: TextStyle(
          fontFamily: StaffMetrics.notationFontFamily,
          fontSize: fontSize,
          height: 1,
          color: paint.color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, layout.trebleClefOffset(textPainter));
  }

  void _drawBassClef(
    Canvas canvas,
    StaffNotationLayout layout,
    Paint paint,
  ) {
    final fontSize = layout.bassClefFontSize;
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(StaffMetrics.smuflBassClef),
        style: TextStyle(
          fontFamily: StaffMetrics.notationFontFamily,
          fontSize: fontSize,
          height: 1,
          color: paint.color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, layout.bassClefOffset(textPainter));
  }

  void _drawNote(
    Canvas canvas,
    StaffNotationLayout layout,
    NotationElement element,
    Paint paint,
  ) {
    final center = layout.noteCenter(element);
    final radius = layout.noteHeadRadius(element);
    final headRect = Rect.fromCenter(
      center: center,
      width: radius * StaffMetrics.noteHeadWidthScale,
      height: radius * StaffMetrics.noteHeadHeightScale,
    );

    final headPaint = Paint()
      ..color = paint.color
      ..style = layout.isFilled(element)
          ? PaintingStyle.fill
          : PaintingStyle.stroke
      ..strokeWidth = paint.strokeWidth;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(StaffMetrics.noteHeadRotationRadians);
    canvas.translate(-center.dx, -center.dy);
    canvas.drawOval(headRect, headPaint);
    canvas.restore();

    if (element.value == NoteValue.whole || element.value == NoteValue.half) {
      return;
    }

    final stemUp = layout.stemUp(element);
    final inset = StaffMetrics.stemHorizontalInset;
    final stemX = stemUp ? headRect.right - inset : headRect.left + inset;
    final stemTop = stemUp
        ? center.dy - layout.stemHeight(element)
        : center.dy;
    final stemBottom = stemUp
        ? center.dy
        : center.dy + layout.stemHeight(element);

    canvas.drawLine(
      Offset(stemX, stemTop),
      Offset(stemX, stemBottom),
      paint..style = PaintingStyle.stroke,
    );
  }

  void _drawRest(
    Canvas canvas,
    StaffNotationLayout layout,
    NotationElement element,
    Paint paint,
  ) {
    final fontSize =
        layout.layout.lineSpacing * StaffMetrics.restFontSizeInSpaces(element.value);
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(StaffMetrics.smuflRestFor(element.value)),
        style: TextStyle(
          fontFamily: StaffMetrics.notationFontFamily,
          fontSize: fontSize,
          height: 1,
          color: paint.color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, layout.restGlyphOffset(element, textPainter));
  }

  @override
  bool shouldRepaint(covariant StaffPainter oldDelegate) {
    return oldDelegate.payload != payload || oldDelegate.color != color;
  }
}