/// App-wide spacing scale (4px base). Use for layout padding and gaps.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  /// Minimum height for study answer choices (comfortable tap target).
  static const double studyChoiceButtonHeight = 52;

  /// Vertical offset per zigzag row in the study choice strip.
  static const double studyChoiceZigzagRowStep = 14;
}