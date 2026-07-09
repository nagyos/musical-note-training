/// Asset paths for official learning content JSON bundles.
abstract final class ContentAssets {
  static const categories = 'assets/content/categories.json';

  static const Map<String, String> categoryBundles = {
    'note': 'assets/content/notes.json',
    'rest': 'assets/content/rests.json',
    'dynamic': 'assets/content/dynamics.json',
    'symbol': 'assets/content/symbols.json',
  };

  static String bundleForCategory(String categoryId) {
    final path = categoryBundles[categoryId];
    if (path == null) {
      throw ArgumentError('No content bundle for category: $categoryId');
    }
    return path;
  }
}