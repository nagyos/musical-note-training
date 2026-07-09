import 'package:flutter/material.dart';

import 'package:musical_note_training/shared/domain/models/clef.dart';
import 'package:musical_note_training/shared/domain/models/note_value.dart';
import 'package:musical_note_training/shared/domain/models/notation_element.dart';
import 'package:musical_note_training/shared/domain/models/notation_payload.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_layout.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_ledger.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

/// Draws a five-line staff with optional treble clef and notes.
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
    final notationLayout = StaffNotationLayout(layout);
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

    if (payload.clef == Clef.treble) {
      _drawTrebleClef(canvas, notationLayout, paint);
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
    final halfWidth =
        layout.lineSpacing * StaffMetrics.ledgerLineWidthScale / 2;

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
    final bounds = layout.trebleClefBounds();
    final textPainter = TextPainter(
      text: TextSpan(
        text: '\u{1D11E}',
        style: TextStyle(
          fontSize: bounds.height * StaffMetrics.trebleClefFontSizeScale,
          color: paint.color,
          fontFamily: 'serif',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final offset = Offset(
      bounds.left,
      bounds.center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);
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
    final center = layout.noteCenter(element);
    final width = layout.noteHeadRadius(element) * StaffMetrics.restWidthScale;
    final height = layout.layout.lineSpacing * StaffMetrics.restHeightScale;
    final rect = Rect.fromCenter(
      center: center,
      width: width,
      height: height,
    );
    canvas.drawRect(
      rect,
      paint
        ..style = PaintingStyle.fill
        ..color = paint.color,
    );
  }

  @override
  bool shouldRepaint(covariant StaffPainter oldDelegate) {
    return oldDelegate.payload != payload || oldDelegate.color != color;
  }
}