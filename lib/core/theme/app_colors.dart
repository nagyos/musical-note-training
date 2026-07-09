import 'package:flutter/material.dart';

/// Calm, age-neutral palette (see docs/decisions.md — UI / ビジュアル方針).
abstract final class AppColors {
  /// Muted blue-gray seed for Material 3 tonal palettes.
  static const seed = Color(0xFF5C6770);

  static const lightSurface = Color(0xFFF7F6F3);
  static const darkSurface = Color(0xFF1A1B1E);

  /// Subdued semantic colors (not neon).
  static const success = Color(0xFF4A7C59);
  static const error = Color(0xFFB85C5C);
}