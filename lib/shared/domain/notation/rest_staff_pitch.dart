/// Treble-clef rest positions on the staff (half-line steps).
abstract final class RestStaffPitch {
  /// Official seed card IDs mapped to expected [staffStep] values.
  static const Map<String, int> seedCardStaffSteps = {
    'rest-whole': 6,
    'rest-half': 4,
    'rest-quarter': 3,
    'rest-eighth': 2,
    'rest-sixteenth': 2,
  };

  static int? staffStepForCardId(String cardId) => seedCardStaffSteps[cardId];
}