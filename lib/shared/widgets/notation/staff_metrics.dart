import 'package:musical_note_training/shared/domain/models/note_value.dart';

/// Canvas frame constants and SMuFL identifiers for staff notation.
///
/// Engraving sizes live in [StaffEngravingRules] as spatium multiples.
abstract final class StaffMetrics {
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
}