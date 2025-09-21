import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:template/core/presentation/widgets/app_image.dart';

/// A builder that will be used when the icon is error.
typedef AppIconErrorBuilder = Widget Function(BuildContext context, dynamic error);

/// A builder that will be used when the icon is loading.
typedef AppIconLoadingBuilder = Widget Function(BuildContext context);

/// A widget that displays an icon.
class AppIcon extends StatefulWidget {
  /// Creates an icon.
  const AppIcon({
    super.key,
    required this.icon,
    double? size = 24,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.medium,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.headers,
    this.errorBuilder,
    this.loadingBuilder,
    this.cacheManager,
  }) : height = size,
       width = size;

  /// Creates an icon with a specific size.
  const AppIcon.resize({
    super.key,
    required this.icon,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.medium,
    required this.height,
    required this.width,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.headers,
    this.errorBuilder,
    this.loadingBuilder,
    this.cacheManager,
  });

  /// The icon to display.
  final dynamic icon;

  /// The height of the icon.
  final double? height;

  /// The width of the icon.
  final double? width;

  /// A color to paint behind the icon.
  final Color? color;

  /// How to apply the [color] to the image.
  final BlendMode? colorBlendMode;

  /// Quality level used for image sampling when scaling.
  final FilterQuality filterQuality;

  /// How to inscribe the image into the space allocated during layout.
  final BoxFit fit;

  /// How to align the image within its bounds.
  final Alignment alignment;

  /// The builder that will be used when the icon is loading.
  final AppIconLoadingBuilder? loadingBuilder;

  /// The builder that will be used when the icon fails to load.
  final AppIconErrorBuilder? errorBuilder;

  /// The cache manager used to download and cache files
  final BaseCacheManager? cacheManager;

  /// Set headers for the image provider, for example for authentication
  final Map<String, String>? headers;

  @override
  State<AppIcon> createState() => AppIconState();
}

/// The state of the [AppIcon].
class AppIconState extends State<AppIcon> {
  /// The icon value.
  @protected
  Object? icon;

  @override
  void initState() {
    super.initState();
    icon = widget.icon;
  }

  @override
  void didUpdateWidget(covariant AppIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.icon != widget.icon) {
      icon = widget.icon;
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// The size of the icon.
  @protected
  double? get size {
    if (widget.height == null && widget.width == null) return null;

    return math.max(widget.height ?? 0, widget.width ?? 0);
  }

  /// Transforms the icon to a supported type.
  @protected
  Object? transformIcon(Object? icon) {
    if (icon is IconData) return icon;
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final Object? iconData = transformIcon(icon);

    return builder(context, iconData);
  }

  /// build manager for the icon
  @protected
  Widget builder(BuildContext context, Object? iconData) {
    if (iconData == null) return errorBuilder(context, 'not supported type: ${icon.runtimeType} with value: $icon');

    if (iconData is IconData) return iconBuilder(context, iconData);

    return imageBuilder(context, iconData);
  }

  /// build icon with [Icon] widget if the icon is [IconData]
  @protected
  Widget iconBuilder(BuildContext context, IconData icon) {
    return Icon(icon, size: size, color: widget.color);
  }

  /// build image with [BaseImage] widget if the icon is not [IconData]
  @protected
  Widget imageBuilder(BuildContext context, Object imageData) {
    return AppImage(
      image: imageData,
      height: widget.height,
      width: widget.width,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      filterQuality: widget.filterQuality,
      fit: widget.fit,
      alignment: widget.alignment,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      errorBuilder: errorBuilder,
      loadingBuilder: (context, {Widget? child}) => loadingBuilder(context),
      cacheManager: widget.cacheManager,
      headers: widget.headers,
    );
  }

  /// build error widget
  @protected
  Widget errorBuilder(BuildContext context, dynamic error) {
    return widget.errorBuilder?.call(context, error) ??
        Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '!',
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        );
  }

  /// build loading widget
  @protected
  Widget loadingBuilder(BuildContext context) {
    return widget.loadingBuilder?.call(context) ??
        Container(
          width: widget.width,
          height: widget.height,
          decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
        );
  }
}
