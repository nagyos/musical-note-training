import 'dart:math' as math;

import 'package:musical_note_training/shared/domain/models/note_value.dart';

/// Layout and geometry constants for staff notation rendering.
///
/// Ratios are relative to [StaffLayout.lineSpacing] or canvas [Size] unless noted.
abstract final class StaffMetrics {
  // --- Staff frame ---
  static const int lineCount = 5;
  static const double padding = 16;
  static const double defaultCanvasHeight = 140;

  /// Half-line slots reserved below step 0 / above step 8 for ledger notes.
  static const int ledgerSlotsBelow = 2;
  static const int ledgerSlotsAbove = 2;

  // --- SMuFL font (Bravura) ---
  static const String notationFontFamily = 'Bravura';
  static const int smuflTrebleClef = 0xE050;
  static const int smuflBassClef = 0xE062;

  /// Inset from canvas [padding] before either clef glyph's left edge.
  static const double clefCanvasLeftMarginInSpaces = 0.5;

  // --- Treble clef (overlaps staff left edge; SMuFL / engraving convention) ---
  static const int trebleClefAnchorStep = 2;

  /// Bravura g-clef optical height in staff-line spacings (~4 is standard).
  static const double trebleClefFontSizeInSpaces = 3.35;

  /// G-line (step 2) as a fraction from the top of the laid-out glyph (0–1).
  static const double trebleClefGLineAnchorRatio = 0.56;

  /// How far the clef extends right across the staff, in [lineSpacing] units.
  static const double trebleClefStaffWidthScale = 2.5;

  /// How far the clef tail extends left of the staff edge, in [lineSpacing] units.
  static const double trebleClefLeftOverhangScale = 0.25;

  // --- Bass clef (F line anchor at step 6; tuned like treble clef) ---
  static const int bassClefAnchorStep = 6;

  static const double bassClefFontSizeInSpaces = 3.5;

  /// F line (step 6) as a fraction from the top of the laid-out glyph (0–1).
  static const double bassClefFLineAnchorRatio = 0.54;

  static const double bassClefStaffWidthScale = 2.5;

  static const double bassClefLeftOverhangScale = 0.25;

  /// Optical nudge right so the glyph sits on the staff like the treble clef.
  static const double bassClefHorizontalNudgeInSpaces = 0.22;

  // --- Note heads (multiples of lineSpacing) ---
  static const double wholeNoteHeadScale = 0.42;
  static const double quarterNoteHeadScale = 0.36;

  // --- Stems ---
  static const double stemHeightScale = 3.2;

  /// Notes at or above this staff step draw stems upward.
  static const int stemUpThresholdStep = 6;

  // --- Paint / drawing ---
  static const double strokeWidth = 1.2;
  static const double noteHeadWidthScale = 2.4;
  static const double noteHeadHeightScale = 1.6;
  static const double noteHeadRotationRadians = math.pi / 6;
  static const double stemHorizontalInset = 1;
  // --- Rests (SMuFL / Bravura) ---
  static const int smuflWholeRest = 0xE4E3;
  static const int smuflHalfRest = 0xE4E4;
  static const int smuflQuarterRest = 0xE4E5;
  static const int smuflEighthRest = 0xE4E6;
  static const int smuflSixteenthRest = 0xE4E7;

  static int smuflRestFor(NoteValue value) => switch (value) {
        NoteValue.whole => smuflWholeRest,
        NoteValue.half => smuflHalfRest,
        NoteValue.quarter => smuflQuarterRest,
        NoteValue.eighth => smuflEighthRest,
        NoteValue.sixteenth => smuflSixteenthRest,
      };

  /// Rest glyph size in staff spaces (all values share one scale until #24).
  static const double restFontSizeInSpaces = 4.5;

  /// Vertical anchor as a fraction from glyph top (0–1) to [staffStep] y.
  static const double restAnchorRatio = 0.5;

  /// Ledger half-width as a multiple of the note-head half-width.
  static const double ledgerHalfWidthNoteScale = 0.55;
}