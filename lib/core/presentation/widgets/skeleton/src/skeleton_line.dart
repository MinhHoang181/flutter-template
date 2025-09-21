part of '../skeleton.dart';

class SkeletonLine extends Skeleton {
  const SkeletonLine({
    super.key,
    this.height = 18,
    this.width,
    this.minLength,
    this.maxLength,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    super.hasEffect,
  }) : assert(
         minLength == null || (minLength > 0 && (maxLength == null || maxLength > minLength)),
         'minLength must be greater than 0 and less than maxLength',
       ),
       assert(
         maxLength == null || (maxLength > 0 && (minLength == null || minLength < maxLength)),
         'maxLength must be greater than 0 and more than minLength',
       );

  /// The width of the skeleton line
  final double? width;

  /// The height of the skeleton line
  final double? height;

  /// The minimum length of the skeleton line
  final double? minLength;

  /// The maximum length of the skeleton line
  final double? maxLength;

  /// The border radius of the skeleton line
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget skeletonBuilder(BuildContext context, Color baseColor, Color highlightColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width =
            this.width ??
            randomInRange(minLength ?? ((maxLength ?? constraints.maxWidth) / 3), maxLength ?? constraints.maxWidth);

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(borderRadius: borderRadius, color: baseColor),
        );
      },
    );
  }
}
