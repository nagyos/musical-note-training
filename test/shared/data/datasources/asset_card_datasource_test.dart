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

    test('loads rest seed with one lesson and five cards', () async {
      final bundle = await datasource.loadCategoryBundle('rest');

      expect(bundle.lessons, hasLength(1));
      expect(bundle.cards, hasLength(5));
      expect(bundle.lessons.map((l) => l.id), ['rest']);
    });

    test('loads dynamic seed with one lesson and five cards', () async {
      final bundle = await datasource.loadCategoryBundle('dynamic');

      expect(bundle.lessons, hasLength(1));
      expect(bundle.cards, hasLength(5));
      expect(bundle.lessons.single.id, 'dynamic-basic');
    });

    test('loadCategories includes note, rest, and dynamic', () async {
      final categories = await datasource.loadCategories();
      expect(categories.map((c) => c.id), ['note', 'rest', 'dynamic']);
    });
  });
}