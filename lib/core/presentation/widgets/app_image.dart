import 'package:core_widget/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:template/gen/assets.gen.dart';

import 'app_icon.dart';

class AppImage extends BaseImage {
  const AppImage({
    super.key,
    required super.image,
    super.height,
    super.width,
    super.fit,
    super.alignment,
    super.clipBehavior,
    super.decoration,
    super.padding,
    super.margin,
    super.color,
    super.colorBlendMode,
    super.filterQuality,
    super.cacheManager,
    super.headers,
    super.loadingBuilder,
    super.errorBuilder,
    super.fadeInDuration,
    super.fadeOutDuration,
    super.maxHeightDiskCache,
    super.maxWidthDiskCache,
  });

  @override
  BaseImageState createState() => _AppImageState();
}

class _AppImageState extends BaseImageState {
  @override
  Object? transformImage(Object? image) {
    if (image is AssetGenImage) {
      return super.transformImage(image.path);
    }

    if (image is SvgGenImage) {
      return super.transformImage(image.path);
    }

    return super.transformImage(image);
  }

  @override
  Widget loadingBuilder(BuildContext context, {Widget? child}) {
    if (widget.loadingBuilder != null) {
      return widget.loadingBuilder!(context, child: child);
    }

    return SkeletonContainer(height: widget.height, width: widget.width);
  }

  @override
  Widget errorBuilder(BuildContext context, Object? error) {
    if (widget.errorBuilder != null) {
      return widget.errorBuilder!(context, error);
    }

    handleError(error);

    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey.shade300,
      child: Center(
        child: AppIcon(
          icon: Assets.icons.errorImage,
          size: widget.height != null ? widget.height! * 0.4 : null,
        ),
      ),
    );
  }
}
