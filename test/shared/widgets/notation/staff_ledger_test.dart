import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/widgets/notation/staff_ledger.dart';

void main() {
  group('StaffLedger.ledgerStepsForNote', () {
    test('returns no ledger lines inside the staff', () {
      expect(StaffLedger.ledgerStepsForNote(0), isEmpty);
      expect(StaffLedger.ledgerStepsForNote(4), isEmpty);
      expect(StaffLedger.ledgerStepsForNote(8), isEmpty);
    });

    test('returns lower ledger line for middle C', () {
      expect(StaffLedger.ledgerStepsForNote(-2), [-2]);
    });

    test('returns lower ledger line for D4 in the bottom space', () {
      expect(StaffLedger.ledgerStepsForNote(-1), [-2]);
    });

    test('returns upper ledger line above the staff', () {
      expect(StaffLedger.ledgerStepsForNote(10), [10]);
      expect(StaffLedger.ledgerStepsForNote(12), [10, 12]);
    });
  });
}