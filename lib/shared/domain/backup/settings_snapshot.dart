/// User settings included in portable backups (no feature-layer types).
class SettingsSnapshot {
  const SettingsSnapshot({
    required this.uiLocaleCode,
    required this.noteNameStyle,
  });

  final String uiLocaleCode;
  final String noteNameStyle;

  static const defaults = SettingsSnapshot(
    uiLocaleCode: 'ja',
    noteNameStyle: 'solfege',
  );
}