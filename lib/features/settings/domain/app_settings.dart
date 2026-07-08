import 'package:flutter/material.dart';

import 'package:musical_note_training/features/settings/domain/note_name_style.dart';

class AppSettings {
  const AppSettings({
    required this.uiLocaleCode,
    required this.noteNameStyle,
  });

  final String uiLocaleCode;
  final NoteNameStyle noteNameStyle;

  Locale get uiLocale => Locale(uiLocaleCode);

  String get answerLocaleKey => noteNameStyle.answerLocaleKey;

  static const defaults = AppSettings(
    uiLocaleCode: 'ja',
    noteNameStyle: NoteNameStyle.solfege,
  );

  AppSettings copyWith({
    String? uiLocaleCode,
    NoteNameStyle? noteNameStyle,
  }) {
    return AppSettings(
      uiLocaleCode: uiLocaleCode ?? this.uiLocaleCode,
      noteNameStyle: noteNameStyle ?? this.noteNameStyle,
    );
  }
}