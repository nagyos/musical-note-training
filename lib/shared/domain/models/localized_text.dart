/// UI-facing text keyed by locale code (e.g. `ja`, `en`).
class LocalizedText {
  const LocalizedText({required this.values});

  final Map<String, String> values;

  String resolve(String locale) => values[locale] ?? values['en'] ?? values.values.first;

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(
      values: json.map((key, value) => MapEntry(key, value as String)),
    );
  }

  Map<String, dynamic> toJson() => values;
}