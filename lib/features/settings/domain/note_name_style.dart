/// How study answer choices are resolved from [LocalizedText] card data.
enum NoteNameStyle {
  solfege,
  letter;

  String get answerLocaleKey => switch (this) {
        NoteNameStyle.solfege => 'ja',
        NoteNameStyle.letter => 'en',
      };

  static NoteNameStyle fromStorage(String? value) {
    return switch (value) {
      'letter' => NoteNameStyle.letter,
      _ => NoteNameStyle.solfege,
    };
  }

  String get storageValue => name;
}