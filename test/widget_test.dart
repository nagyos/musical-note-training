import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/app/app.dart';

void main() {
  testWidgets('App shows home with category list', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MusicalNoteTrainingApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Musical Note Training'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
  });
}