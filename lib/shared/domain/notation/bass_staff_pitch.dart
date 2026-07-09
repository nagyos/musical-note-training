/// Bass-clef pitch positions on the staff (half-line steps).
///
/// See [NotationElement.staffStep]: 0 = bottom line (G2), +1 per half-step up.
abstract final class BassStaffPitch {
  /// Official seed card IDs mapped to expected [staffStep] values.
  static const Map<String, int> seedCardStaffSteps = {
    'note-g2': 0,
    'note-a2': 1,
    'note-b2': 2,
    'note-c3': 3,
    'note-d3': 4,
    'note-e3': 5,
    'note-f3': 6,
    'note-g3': 7,
    'note-a3': 8,
    'note-c4-bass': 10,
  };

  static int? staffStepForCardId(String cardId) => seedCardStaffSteps[cardId];
}