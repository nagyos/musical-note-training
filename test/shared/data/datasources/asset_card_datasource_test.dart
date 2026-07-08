import 'package:flutter_test/flutter_test.dart';

import 'package:musical_note_training/shared/data/datasources/asset_card_datasource.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AssetCardDatasource', () {
    const datasource = AssetCardDatasource();

    test('loads note seed with two lessons and eight cards', () async {
      final bundle = await datasource.loadCategoryBundle('note');

      expect(bundle.lessons, hasLength(2));
      expect(bundle.cards, hasLength(8));
      expect(bundle.lessons.map((l) => l.id), [
        'note-middle-c',
        'note-treble-staff',
      ]);
    });
  });
}