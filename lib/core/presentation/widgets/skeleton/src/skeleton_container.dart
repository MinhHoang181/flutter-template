part of '../skeleton.dart';

class SkeletonContainer extends Skeleton {
  const SkeletonContainer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = const BorderRadius.all(Radius.circular(2)),
    this.child,
    this.shape = BoxShape.rectangle,
    super.hasEffect,
  });

  /// The height of the skeleton container
  final double? height;

  /// The width of the skeleton container
  final double? width;

  /// The border radius of the skeleton container
  final BorderRadius borderRadius;

  /// The child widget of the skeleton container
  final Widget? child;

  /// The shape of the skeleton container
  final BoxShape shape;

  @override
  Widget skeletonBuilder(BuildContext context, Color baseColor, Color highlightColor) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: shape == BoxShape.circle ? null : borderRadius,
        shape: shape,
        color: baseColor,
      ),
      child: child,
    );
  }
}
