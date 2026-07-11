import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

/// Converts canvas geometry to the engraving spatium (staff space).
abstract final class StaffScale {
  /// Spatium for a canvas of [height] using the same ledger margins as [StaffLayout].
  static double spatiumForCanvasHeight(
    double height, {
    int lineCount = StaffMetrics.lineCount,
    double padding = StaffMetrics.padding,
    int ledgerSlotsBelow = StaffMetrics.ledgerSlotsBelow,
    int ledgerSlotsAbove = StaffMetrics.ledgerSlotsAbove,
  }) {
    final staffHalfSteps = (lineCount - 1) * 2;
    final totalHalfSteps =
        staffHalfSteps + ledgerSlotsBelow + ledgerSlotsAbove;
    final availableHeight = height - padding * 2;
    return availableHeight / (totalHalfSteps / 2);
  }
}