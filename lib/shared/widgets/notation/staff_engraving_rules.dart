import 'dart:math' as math;

/// Dimensionless engraving coefficients for staff notation.
///
/// All lengths derive from **spatium** (distance between adjacent staff-line
/// centers). At paint time: `pixels = spatium * coefficient`.
abstract final class StaffEngravingRules {
  // --- Staff lines ---
  static const double staffLineWidthInSpaces = 0.067;

  // --- Clefs ---
  static const int trebleClefAnchorStep = 2;
  static const double clefCanvasLeftMarginInSpaces = 0.5;
  static const double trebleClefFontSizeInSpaces = 3.35;
  static const double trebleClefGLineAnchorRatio = 0.56;
  static const double trebleClefStaffWidthInSpaces = 2.5;
  static const double trebleClefLeftOverhangInSpaces = 0.25;

  static const int bassClefAnchorStep = 6;
  static const double bassClefFontSizeInSpaces = 3.5;
  static const double bassClefFLineAnchorRatio = 0.54;
  static const double bassClefStaffWidthInSpaces = 2.5;
  static const double bassClefLeftOverhangInSpaces = 0.25;
  static const double bassClefHorizontalNudgeInSpaces = 0.22;

  // --- Note heads ---
  static const double wholeNoteHeadRadiusInSpaces = 0.42;
  static const double quarterNoteHeadRadiusInSpaces = 0.36;
  static const double noteHeadWidthInSpaces = 2.4;
  static const double noteHeadHeightInSpaces = 1.6;
  static const double noteHeadRotationRadians = math.pi / 6;

  // --- Stems ---
  static const double stemHeightInSpaces = 3.2;
  static const double stemHorizontalInsetInSpaces = 0.056;
  static const int stemUpThresholdStep = 6;

  // --- Rests (SMuFL; one scale for every rest value) ---
  /// Bravura rest em-box height in spatiums. Staff span is 4 spaces; 4.5 looked oversized.
  static const double restFontSizeInSpaces = 4.0;
  static const double restAnchorRatio = 0.5;

  // --- Ledger lines ---
  static const double ledgerHalfWidthNoteScale = 0.55;

  // --- Isolated glyphs (dynamic / symbol without a staff) ---
  static const double isolatedGlyphFontSizeInSpaces = 4.5;

  // --- Tempo marks (score typography; smaller than isolated quiz glyphs) ---
  static const double tempoMarkFontSizeInSpaces = 1.85;
}