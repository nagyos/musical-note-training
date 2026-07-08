import 'dart:math' as math;

/// Layout and geometry constants for staff notation rendering.
///
/// Ratios are relative to [StaffLayout.lineSpacing] or canvas [Size] unless noted.
abstract final class StaffMetrics {
  // --- Staff frame ---
  static const int lineCount = 5;
  static const double padding = 16;
  static const double defaultCanvasHeight = 140;

  /// Width reserved for the clef as a fraction of total canvas width.
  static const double clefAreaWidthRatio = 0.12;

  /// Horizontal position of the note head along the staff span (0 = left, 1 = right).
  static const double noteXRatio = 0.55;

  /// Gap between clef area and staff lines, as a fraction of [padding].
  static const double clefRightPaddingRatio = 0.25;

  // --- Clef bounds (staffStep coordinates) ---
  static const int trebleClefTopStep = 8;
  static const int trebleClefBottomStep = -2;

  // --- Note heads (multiples of lineSpacing) ---
  static const double wholeNoteHeadScale = 0.42;
  static const double quarterNoteHeadScale = 0.36;

  // --- Stems ---
  static const double stemHeightScale = 3.2;

  /// Notes at or above this staff step draw stems upward.
  static const int stemUpThresholdStep = 6;

  // --- Paint / drawing ---
  static const double strokeWidth = 1.2;
  static const double trebleClefFontSizeScale = 1.05;
  static const double noteHeadWidthScale = 2.4;
  static const double noteHeadHeightScale = 1.6;
  static const double noteHeadRotationRadians = math.pi / 6;
  static const double stemHorizontalInset = 1;
  static const double restWidthScale = 2.2;
  static const double restHeightScale = 0.35;
}