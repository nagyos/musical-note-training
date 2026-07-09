import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/domain/models/note_value.dart';
import 'package:musical_note_training/shared/domain/models/notation_element.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_layout.dart';
import 'package:musical_note_training/shared/widgets/notation/staff_metrics.dart';

void main() {
  group('StaffLayout', () {
    test('maps staff steps to increasing y offsets', () {
      const layout = StaffLayout(size: Size(320, 140));

      final bottom = layout.yForStaffStep(0);
      final higher = layout.yForStaffStep(4);

      expect(higher, lessThan(bottom));
    });

    test('keeps middle C ledger note inside canvas', () {
      const layout = StaffLayout(size: Size(320, 140));
      final notationLayout = StaffNotationLayout(layout);
      const element = NotationElement(staffStep: -2, value: NoteValue.quarter);

      final center = notationLayout.noteCenter(element);
      final radius = notationLayout.noteHeadRadius(element);
      final headHalfHeight =
          radius * StaffMetrics.noteHeadHeightScale / 2;

      expect(center.dy - headHalfHeight, greaterThanOrEqualTo(0));
      expect(center.dy + headHalfHeight, lessThanOrEqualTo(140));
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