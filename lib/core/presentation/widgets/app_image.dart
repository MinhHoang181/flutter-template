import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:template/core/extensions/extensions.dart';

/// A builder function for loading
typedef AppImageLoadingBuilder = Widget Function(BuildContext context, {Widget? child});

/// A builder function for error
typedef AppImageErrorBuilder = Widget Function(BuildContext context, dynamic error);

/// A widget that displays an image.
class AppImage extends StatefulWidget {
  /// Creates an image.
  const AppImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.none,
    this.decoration,
    this.padding,
    this.margin,
    this.color,
    this.colorBlendMode,
    this.filterQuality = FilterQuality.medium,
    this.cacheManager,
    this.headers,
    this.loadingBuilder,
    this.errorBuilder,
    this.fadeInDuration = const Duration(milliseconds: 250),
    this.fadeOutDuration = const Duration(milliseconds: 500),
    this.maxHeightDiskCache = 1000,
    this.maxWidthDiskCache = 1000,
  });

  /// The image to display.
  final dynamic image;

  /// The height of the image.
  final double? height;

  /// The width of the image.
  final double? width;

  /// How to inscribe the image into the space allocated during layout.
  final BoxFit fit;

  /// How to align the image within its bounds.
  final Alignment alignment;

  /// The decoration to paint behind the image.
  final Decoration? decoration;

  /// The clip behavior when the image is smaller than its parent.
  final Clip clipBehavior;

  /// Empty space to inscribe inside the decoration.
  final EdgeInsetsGeometry? padding;

  /// Empty space to surround the decoration.
  final EdgeInsetsGeometry? margin;

  /// A color to paint behind the image.
  final Color? color;

  /// How to apply the [color] to the image.
  final BlendMode? colorBlendMode;

  /// Quality level used for image sampling when scaling.
  final FilterQuality filterQuality;

  /// The cache manager used to download and cache files
  final BaseCacheManager? cacheManager;

  /// Set headers for the image provider, for example for authentication
  final Map<String, String>? headers;

  /// A builder function for loading
  final AppImageLoadingBuilder? loadingBuilder;

  /// A builder function for error
  final AppImageErrorBuilder? errorBuilder;

  /// The duration of the fade-in animation.
  ///
  /// Only work for cached network image.
  final Duration fadeInDuration;

  /// The duration of the fade-out animation.
  ///
  /// Only work for cached network image.
  final Duration fadeOutDuration;

  /// Will resize the image and store the resized image in the disk cache.
  ///
  /// Only work for cached network image.
  final int? maxHeightDiskCache;

  /// Will resize the image and store the resized image in the disk cache.
  ///
  /// Only work for cached network image.
  final int? maxWidthDiskCache;

  @override
  AppImageState createState() => AppImageState();
}

/// The state of the [AppImage].
class AppImageState extends State<AppImage> {
  /// The image value.
  @protected
  Object? image;

  Object? _memoizedImageData;
  Object? _lastImageInput;

  @override
  void initState() {
    super.initState();
    image = widget.image;
  }

  @override
  void didUpdateWidget(covariant AppImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image) {
      image = widget.image;
      if (mounted) {
        setState(() {});
      }
    }
  }

  /// Transforms the image to a supported type.
  @protected
  Object? transformImage(Object? image) {
    if (image is ImageProvider) return image;
    if (image is Uint8List) return getMemoryImageProvider(image);
    if (image is File) return getFileImageProvider(image);

    if (image is String) {
      final String path = image;

      if (path.isSvg || path.isSvgFile) return getSvgLoader(path);
      if (path.isAsset) return getAssetImageProvider(path);
      if (path.isURL()) return getCachedImageProvider(path);
    }

    return null;
  }

  /// Get the cached image provider.
  @protected
  ImageProvider getCachedImageProvider(String url) {
    return CachedNetworkImageProvider(
      url,
      cacheKey: url,
      cacheManager: widget.cacheManager,
      headers: widget.headers,
      maxHeight: widget.maxHeightDiskCache,
      maxWidth: widget.maxWidthDiskCache,
    );
  }

  /// Get the memory image provider.
  @protected
  ImageProvider getMemoryImageProvider(Uint8List bytes) {
    return MemoryImage(bytes);
  }

  /// Get the asset image provider.
  @protected
  ImageProvider getAssetImageProvider(String url) {
    return AssetImage(url);
  }

  /// Get the file image provider.
  @protected
  ImageProvider getFileImageProvider(File file) {
    return FileImage(file);
  }

  /// Get the svg loader.
  @protected
  SvgLoader getSvgLoader(String path) {
    if (path.isAsset) return SvgAssetLoader(path);
    if (path.isURL()) {
      return SvgNetworkLoader(path, headers: widget.headers);
    }

    final String trimmed = path.trimLeft();
    if (trimmed.startsWith('<svg')) {
      return SvgStringLoader(path);
    }

    // Fallback: treat as asset to avoid mis-detecting non-SVG strings
    return SvgAssetLoader(path);
  }

  @override
  Widget build(BuildContext context) {
    if (_lastImageInput != image) {
      _memoizedImageData = transformImage(image);
      _lastImageInput = image;
    }

    final Object? imageData = _memoizedImageData;

    final Widget child = imageBuilder(context, imageData);

    return decorationBuilder(context, child);
  }

  /// Builds the decoration for the image.
  @protected
  Widget decorationBuilder(BuildContext context, Widget child) {
    final Decoration? decoration = widget.decoration;

    Widget content = Container(
      clipBehavior: widget.clipBehavior,
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      margin: widget.margin,
      decoration: decoration,
      child: child,
    );

    if (decoration is BoxDecoration && decoration.borderRadius != null && widget.clipBehavior != Clip.none) {
      content = ClipRRect(clipBehavior: widget.clipBehavior, borderRadius: decoration.borderRadius!, child: content);
    }

    return content;
  }

  /// Builds the image with the given [imageData].
  ///
  /// The [imageData] can be a [CachedNetworkImageProvider], [ImageProvider], or [SvgLoader].
  @protected
  Widget imageBuilder(BuildContext context, Object? imageData) {
    if (imageData is CachedNetworkImageProvider) return cachedImageBuilder(context, imageData);
    if (imageData is ImageProvider) return normalImageBuilder(context, imageData);
    if (imageData is SvgLoader) return svgImageBuilder(context, imageData);

    return errorBuilder(context, 'not supported type: ${image.runtimeType} with value: $image');
  }

  /// Builds the cached image with the given [CachedNetworkImageProvider].
  @protected
  Widget cachedImageBuilder(BuildContext context, CachedNetworkImageProvider imageProvider) {
    return CachedNetworkImage(
      key: ValueKey(imageProvider.cacheKey ?? imageProvider.url),
      imageUrl: imageProvider.url,
      cacheKey: imageProvider.cacheKey,
      cacheManager: imageProvider.cacheManager,
      httpHeaders: imageProvider.headers,
      scale: imageProvider.scale,
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      alignment: widget.alignment,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      fadeInDuration: widget.fadeInDuration,
      fadeOutDuration: widget.fadeOutDuration,
      useOldImageOnUrlChange: true,
      maxHeightDiskCache: widget.maxHeightDiskCache,
      maxWidthDiskCache: widget.maxWidthDiskCache,
      errorListener: imageProvider.errorListener,
      errorWidget: (context, _, error) => errorBuilder(context, error),
      progressIndicatorBuilder: (context, _, progress) =>
          progressIndicatorBuilder(context, current: progress.downloaded, total: progress.totalSize),
    );
  }

  /// Builds the normal image with the given [ImageProvider].
  @protected
  Widget normalImageBuilder(BuildContext context, ImageProvider imageProvider) {
    return Image(
      image: imageProvider,
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      alignment: widget.alignment,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      filterQuality: widget.filterQuality,
      errorBuilder: (context, error, _) => errorBuilder(context, error),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }
        return loadingBuilder(context);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return progressIndicatorBuilder(
          context,
          current: loadingProgress.cumulativeBytesLoaded,
          total: loadingProgress.expectedTotalBytes,
        );
      },
    );
  }

  /// Builds the svg image with the given [SvgLoader].
  @protected
  Widget svgImageBuilder(BuildContext context, SvgLoader imageLoader) {
    return SvgPicture(
      imageLoader,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      alignment: widget.alignment,
      colorFilter: widget.color != null ? ColorFilter.mode(widget.color!, BlendMode.srcIn) : null,
      placeholderBuilder: loadingBuilder,
    );
  }

  /// Builds the error widget with the given [error].
  @protected
  Widget errorBuilder(BuildContext context, dynamic error) {
    return widget.errorBuilder?.call(context, error) ?? SizedBox(width: widget.width, height: widget.height);
  }

  /// Builds the loading widget.
  @protected
  Widget loadingBuilder(BuildContext context, {Widget? child}) {
    return widget.loadingBuilder?.call(context) ?? SizedBox(width: widget.width, height: widget.height, child: child);
  }

  /// Builds the progress indicator widget.
  @protected
  Widget progressIndicatorBuilder(BuildContext context, {required int? current, required int? total}) {
    final double? progress = current != null && total != null ? (current / total).clamp(0.0, 1.0) : null;

    return loadingBuilder(
      context,
      child: progress != null
          ? Center(
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 2,
                backgroundColor: const Color(0xFFE6E6E6),
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
    );
  }
}
