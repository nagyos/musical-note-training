class DeckValidationException implements Exception {
  DeckValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract final class DeckValidator {
  static String validateName(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      throw DeckValidationException('Deck name must not be empty');
    }
    return trimmed;
  }
}