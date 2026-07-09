/// Treble-clef pitch positions on the staff (half-line steps).
///
/// See [NotationElement.staffStep]: 0 = bottom line (E4), +1 per half-step up.
abstract final class TrebleStaffPitch {
  /// Official seed card IDs mapped to expected [staffStep] values.
  static const Map<String, int> seedCardStaffSteps = {
    'note-c4': -2,
    'note-d4': -1,
    'note-e4': 0,
    'note-f4': 1,
    'note-g4': 2,
    'note-a4': 3,
    'note-b4': 4,
    'note-c5': 5,
  };

  static int? staffStepForCardId(String cardId) => seedCardStaffSteps[cardId];
}