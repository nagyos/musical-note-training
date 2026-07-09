import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

/// Helpers for ledger lines above/below the five-line staff.
abstract final class StaffLedger {
  static const int bottomStaffLineStep = 0;
  static const int topStaffLineStep =
      (StaffMetrics.lineCount - 1) * 2; // 8

  /// Even [staffStep] values that need a ledger line for [noteStaffStep].
  static List<int> ledgerStepsForNote(int noteStaffStep) {
    if (noteStaffStep < bottomStaffLineStep) {
      final steps = <int>[];
      final lowerBound = noteStaffStep - 1;
      for (var step = -2; step >= lowerBound; step -= 2) {
        steps.add(step);
      }
      return steps;
    }
    if (noteStaffStep > topStaffLineStep) {
      final steps = <int>[];
      final upperBound = noteStaffStep + 1;
      for (var step = topStaffLineStep + 2;
          step <= upperBound;
          step += 2) {
        steps.add(step);
      }
      return steps;
    }
    return const [];
  }
}