import 'package:flutter/material.dart';
class FlavorBanner extends StatelessWidget {
  const FlavorBanner({super.key, required this.child, required this.isShow, required this.env});
  final Widget child;
  final bool isShow;
  final String env;
  @override
  Widget build(BuildContext context) => child;
}
class SkeletonTheme extends ThemeExtension<SkeletonTheme> {
  const SkeletonTheme({this.baseColor, this.highlightColor, this.child});
  final Color? baseColor;
  final Color? highlightColor;
  final Widget? child;
  @override
  SkeletonTheme copyWith({Color? baseColor, Color? highlightColor}) => SkeletonTheme(baseColor: baseColor ?? this.baseColor, highlightColor: highlightColor ?? this.highlightColor);
  @override
  SkeletonTheme lerp(ThemeExtension<SkeletonTheme>? other, double t) => this;
}
class SkeletonContainer extends StatelessWidget {
  const SkeletonContainer({super.key, this.width, this.height, this.shape});
  final double? width;
  final double? height;
  final BoxShape? shape;
  @override
  Widget build(BuildContext context) => const SizedBox();
}
dynamic coreWidgetLogger;
class CoreWidgetLogger {
  static custom({dynamic logDebug, dynamic logError}) => null;
}
