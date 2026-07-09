import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/notation/treble_staff_pitch.dart';

void main() {
  group('TrebleStaffPitch', () {
    test('maps seed card ids to staff steps', () {
      expect(TrebleStaffPitch.seedCardStaffSteps['note-c4'], -2);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-d4'], -1);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-e4'], 0);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-f4'], 1);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-g4'], 2);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-a4'], 3);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-b4'], 4);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-c5'], 5);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-d5'], 6);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-e5'], 7);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-f5'], 8);
      expect(TrebleStaffPitch.seedCardStaffSteps['note-g5'], 9);
    });

    test('staffStepForCardId returns null for unknown ids', () {
      expect(TrebleStaffPitch.staffStepForCardId('unknown'), isNull);
    });
  });
}