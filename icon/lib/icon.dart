import 'package:flutter/material.dart';
abstract class BaseIcon extends StatefulWidget {
  const BaseIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.colorBlendMode,
    this.filterQuality,
    this.fit,
    this.alignment,
    this.headers,
    this.errorBuilder,
    this.loadingBuilder,
    this.cacheManager,
    this.width,
    this.height,
  });
  final Object? icon;
  final double? size;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality? filterQuality;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;
  final Map<String, String>? headers;
  final Widget Function(BuildContext, Object)? errorBuilder;
  final Widget Function(BuildContext)? loadingBuilder;
  final dynamic cacheManager;
  final double? width;
  final double? height;
}
abstract class BaseIconState<T extends BaseIcon> extends State<T> {
  Object? transformIcon(Object? icon) => icon;
  Widget builder(BuildContext context, Object? iconData) => const SizedBox();
  double? get size => widget.size;
  @override
  Widget build(BuildContext context) => builder(context, transformIcon(widget.icon));
  Widget errorBuilder(BuildContext context, Object error) => const SizedBox();
}
class PhosphorIconData {}
class PhosphorIcon extends StatelessWidget {
  const PhosphorIcon(this.iconData, {super.key, this.size, this.color, this.duotoneSecondaryOpacity, this.duotoneSecondaryColor});
  final dynamic iconData;
  final double? size;
  final Color? color;
  final double? duotoneSecondaryOpacity;
  final Color? duotoneSecondaryColor;
  @override
  Widget build(BuildContext context) => const SizedBox();
}
class IconifyIcon extends StatelessWidget {
  const IconifyIcon({super.key, required this.icon, this.size, this.color, this.fit, this.alignment, this.cacheManager, this.errorBuilder, this.placeholderBuilder});
  final String icon;
  final double? size;
  final Color? color;
  final BoxFit? fit;
  final AlignmentGeometry? alignment;
  final dynamic cacheManager;
  final Widget Function(BuildContext, dynamic, dynamic)? errorBuilder;
  final Widget Function(BuildContext)? placeholderBuilder;
  @override
  Widget build(BuildContext context) => const SizedBox();
}
dynamic iconLogger;
class IconLogger {
  static custom({dynamic logDebug, dynamic logError}) => null;
}
