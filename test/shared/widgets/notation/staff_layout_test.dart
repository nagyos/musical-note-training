import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/widgets/notation/staff_layout.dart';

void main() {
  group('StaffLayout', () {
    test('maps staff steps to increasing y offsets', () {
      const layout = StaffLayout(size: Size(320, 140));

      final bottom = layout.yForStaffStep(0);
      final higher = layout.yForStaffStep(4);

      expect(higher, lessThan(bottom));
    });
  });

  group('demoMiddleCQuarter', () {
    test('uses treble clef with one quarter note', () {
      expect(demoMiddleCQuarter.clef.name, 'treble');
      expect(demoMiddleCQuarter.elements, hasLength(1));
      expect(demoMiddleCQuarter.elements.first.staffStep, -2);
    });
  });
}