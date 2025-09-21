part of '../extensions.dart';

/// Color extension
extension ColorExt on Color {
  /// Get darker color by %
  ///
  /// [percent] is between 1 and 100.
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100, 'percent must be between 1 and 100');
    final f = 1 - percent / 100;
    return Color.fromARGB(
      (a * 255).toInt(),
      (r * f * 255).clamp(0, 255).toInt(),
      (g * f * 255).clamp(0, 255).toInt(),
      (b * f * 255).clamp(0, 255).toInt(),
    );
  }

  /// Get lighter color by %
  ///
  /// [percent] is between 1 and 100.
  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100, 'percent must be between 1 and 100');
    final p = percent / 100;
    return Color.fromARGB(
      (a * 255).toInt(),
      (r * 255 + ((255 - r * 255) * p)).clamp(0, 255).toInt(),
      (g * 255 + ((255 - g * 255) * p)).clamp(0, 255).toInt(),
      (b * 255 + ((255 - b * 255) * p)).clamp(0, 255).toInt(),
    );
  }

  /// Get color as hex string
  ///
  /// [leadingHashSign] is whether to include leading hash sign.
  ///
  /// [includeAlpha] is whether to include alpha value.
  String toHex({bool leadingHashSign = true, bool includeAlpha = false}) {
    return '${leadingHashSign ? '#' : ''}'
        '${includeAlpha ? (a * 255).toInt().toRadixString(16).padLeft(2, '0') : ''}'
        '${(r * 255).toInt().toRadixString(16).padLeft(2, '0')}'
        '${(g * 255).toInt().toRadixString(16).padLeft(2, '0')}'
        '${(b * 255).toInt().toRadixString(16).padLeft(2, '0')}';
  }
}
