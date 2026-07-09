import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/notation/bass_staff_pitch.dart';

void main() {
  group('BassStaffPitch', () {
    test('maps seed card ids to staff steps', () {
      expect(BassStaffPitch.seedCardStaffSteps['note-g2'], 0);
      expect(BassStaffPitch.seedCardStaffSteps['note-a2'], 1);
      expect(BassStaffPitch.seedCardStaffSteps['note-b2'], 2);
      expect(BassStaffPitch.seedCardStaffSteps['note-c3'], 3);
      expect(BassStaffPitch.seedCardStaffSteps['note-d3'], 4);
      expect(BassStaffPitch.seedCardStaffSteps['note-e3'], 5);
      expect(BassStaffPitch.seedCardStaffSteps['note-f3'], 6);
      expect(BassStaffPitch.seedCardStaffSteps['note-g3'], 7);
      expect(BassStaffPitch.seedCardStaffSteps['note-a3'], 8);
      expect(BassStaffPitch.seedCardStaffSteps['note-c4-bass'], 10);
    });

    test('staffStepForCardId returns null for unknown ids', () {
      expect(BassStaffPitch.staffStepForCardId('unknown'), isNull);
    });
  });
}