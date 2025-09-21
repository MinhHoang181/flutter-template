part of '../skeleton.dart';

class SkeletonParagraph extends StatelessWidget {
  const SkeletonParagraph({
    super.key,
    this.lines = 3,
    this.style,
    this.minWidth,
    this.maxWidth,
    this.lineSpacing = 2,
    this.hasEffect = true,
  });

  /// The number of lines in the paragraph
  final int lines;

  /// The style of the paragraph
  final TextStyle? style;

  /// The minimum width of the paragraph
  final double? minWidth;

  /// The maximum width of the paragraph
  final double? maxWidth;

  /// The spacing between lines in the paragraph
  final double lineSpacing;

  /// Whether the paragraph has an effect or not
  final bool hasEffect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: getSkeletonLines(),
    );
  }

  /// Returns a list of skeleton lines
  List<Widget> getSkeletonLines() {
    final TextStyle style = this.style ?? const TextStyle(fontSize: 14);

    final List<Widget> skeletonLines = [];

    for (var i = 1; i <= lines; i++) {
      skeletonLines.add(
        SkeletonLine(
          height: (style.fontSize ?? 14) * (style.height ?? 1),
          width: i != lines ? double.infinity : null,
          minLength: minWidth,
          maxLength: maxWidth,
          hasEffect: hasEffect,
        ),
      );

      if (i != lines) {
        skeletonLines.add(SizedBox(height: lineSpacing));
      }
    }

    return skeletonLines;
  }
}
