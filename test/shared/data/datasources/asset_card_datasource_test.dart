import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/data/datasources/asset_card_datasource.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AssetCardDatasource', () {
    const datasource = AssetCardDatasource();

    test('loads note seed with five lessons and twenty-two cards', () async {
      final bundle = await datasource.loadCategoryBundle('note');

      expect(bundle.lessons, hasLength(5));
      expect(bundle.cards, hasLength(22));
      expect(bundle.lessons.map((l) => l.id), [
        'note-middle-c',
        'note-treble-staff',
        'note-treble-upper',
        'note-bass-staff',
        'note-bass-middle-c',
      ]);
    });
  });
}