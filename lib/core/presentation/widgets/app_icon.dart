import 'package:core_widget/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:icon/icon.dart';
import 'package:template/gen/assets.gen.dart';

/// A widget that displays an icon.
class AppIcon extends BaseIcon {
  /// Creates an icon.
  const AppIcon({
    super.key,
    required super.icon,
    super.size,
    super.color,
    super.colorBlendMode,
    super.filterQuality,
    super.fit,
    super.alignment,
    super.headers,
    super.errorBuilder,
    super.loadingBuilder,
    super.cacheManager,
    this.duotoneSecondaryOpacity = 0.20,
    this.duotoneSecondaryColor,
  });

  /// Creates an icon with a specific size.
  const AppIcon.resize({
    super.key,
    required super.icon,
    super.size,
    super.color,
    super.colorBlendMode,
    super.filterQuality,

    super.fit,
    super.alignment,
    super.headers,
    super.errorBuilder,
    super.loadingBuilder,
    super.cacheManager,
    this.duotoneSecondaryOpacity = 0.20,
    this.duotoneSecondaryColor,
  });

  final double duotoneSecondaryOpacity;
  final Color? duotoneSecondaryColor;

  @override
  BaseIconState createState() => AppIconState();
}

/// The state of the [AppIcon].
class AppIconState extends BaseIconState {
  @override
  AppIcon get widget => super.widget as AppIcon;

  static final RegExp _iconifyRegex = RegExp(
    r'^([a-z0-9](?:[a-z0-9-]*[a-z0-9])?):([a-z0-9](?:[a-z0-9-]*[a-z0-9])?)$',
  );

  bool _isIconify(Object? icon) {
    return icon is String && _iconifyRegex.hasMatch(icon);
  }

  @override
  Object? transformIcon(Object? icon) {
    if (icon is SvgGenImage) {
      return icon.path;
    }

    if (icon is AssetGenImage) {
      return icon.path;
    }

    return super.transformIcon(icon);
  }

  /// build manager for the icon
  @override
  @protected
  Widget builder(BuildContext context, Object? iconData) {
    if (iconData is String && _isIconify(iconData)) {
      return iconifyBuilder(context, iconData);
    }

    if (iconData is PhosphorIconData) {
      return phosphorBuilder(context, iconData);
    }

    return super.builder(context, iconData);
  }

  @protected
  Widget iconifyBuilder(BuildContext context, String icon) {
    return IconifyIcon(
      icon: icon,
      size: size,
      color: widget.color,
      fit: widget.fit,
      alignment: widget.alignment,
      cacheManager: widget.cacheManager,
      errorBuilder: (context, error, _) => errorBuilder(context, error),
      placeholderBuilder: loadingBuilder,
    );
  }

  Widget phosphorBuilder(BuildContext context, PhosphorIconData icon) {
    return PhosphorIcon(
      icon,
      size: size,
      color: widget.color,
      duotoneSecondaryOpacity: widget.duotoneSecondaryOpacity,
      duotoneSecondaryColor: widget.duotoneSecondaryColor,
    );
  }

  /// build loading widget
  @override
  @protected
  Widget loadingBuilder(BuildContext context) {
    if (widget.loadingBuilder != null) {
      return widget.loadingBuilder!(context);
    }

    return SkeletonContainer(
      width: widget.width,
      height: widget.height,
      shape: BoxShape.circle,
    );
  }
}
