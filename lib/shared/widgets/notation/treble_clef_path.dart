import 'package:flutter/material.dart';

/// Vector G-clef outline normalized to the unit square.
///
/// Drawn as paths instead of Unicode (U+1D11E) so the clef renders without
/// a music-specific font (avoids the missing-glyph black box on Linux).
abstract final class TrebleClefPath {
  static Path unitPath() {
    final path = Path();
    path.moveTo(0.78, 0.04);
    path.cubicTo(0.52, 0.0, 0.24, 0.12, 0.18, 0.36);
    path.cubicTo(0.12, 0.58, 0.24, 0.76, 0.46, 0.80);
    path.cubicTo(0.60, 0.82, 0.72, 0.76, 0.74, 0.64);
    path.cubicTo(0.76, 0.52, 0.66, 0.44, 0.52, 0.44);
    path.cubicTo(0.40, 0.44, 0.32, 0.52, 0.32, 0.64);
    path.cubicTo(0.32, 0.78, 0.44, 0.90, 0.60, 0.94);
    path.cubicTo(0.76, 0.98, 0.90, 0.92, 0.94, 0.78);
    path.cubicTo(0.98, 0.64, 0.90, 0.50, 0.76, 0.46);
    path.cubicTo(0.66, 0.44, 0.56, 0.48, 0.50, 0.54);
    path.lineTo(0.42, 0.98);
    path.cubicTo(0.40, 1.02, 0.36, 1.00, 0.36, 0.96);
    path.cubicTo(0.36, 0.70, 0.36, 0.44, 0.36, 0.20);
    path.cubicTo(0.36, 0.08, 0.44, 0.02, 0.54, 0.04);
    path.cubicTo(0.64, 0.06, 0.72, 0.12, 0.78, 0.20);
    path.close();
    return path;
  }

  static Path fit(Rect bounds) {
    final matrix = Matrix4.identity()
      ..translate(bounds.left, bounds.top)
      ..scale(bounds.width, bounds.height);
    return unitPath().transform(matrix.storage);
  }
}