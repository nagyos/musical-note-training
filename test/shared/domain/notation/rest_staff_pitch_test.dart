import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/notation/rest_staff_pitch.dart';

void main() {
  group('RestStaffPitch', () {
    test('maps seed card ids to staff steps', () {
      expect(RestStaffPitch.seedCardStaffSteps['rest-whole'], 6);
      expect(RestStaffPitch.seedCardStaffSteps['rest-half'], 4);
      expect(RestStaffPitch.seedCardStaffSteps['rest-quarter'], 3);
      expect(RestStaffPitch.seedCardStaffSteps['rest-eighth'], 2);
      expect(RestStaffPitch.seedCardStaffSteps['rest-sixteenth'], 2);
    });
  });
}