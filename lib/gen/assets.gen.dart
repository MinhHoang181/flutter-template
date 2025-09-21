// dart format width=120

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Roboto-Black.ttf
  String get robotoBlack => 'assets/fonts/Roboto-Black.ttf';

  /// File path: assets/fonts/Roboto-BlackItalic.ttf
  String get robotoBlackItalic => 'assets/fonts/Roboto-BlackItalic.ttf';

  /// File path: assets/fonts/Roboto-Bold.ttf
  String get robotoBold => 'assets/fonts/Roboto-Bold.ttf';

  /// File path: assets/fonts/Roboto-BoldItalic.ttf
  String get robotoBoldItalic => 'assets/fonts/Roboto-BoldItalic.ttf';

  /// File path: assets/fonts/Roboto-ExtraBold.ttf
  String get robotoExtraBold => 'assets/fonts/Roboto-ExtraBold.ttf';

  /// File path: assets/fonts/Roboto-ExtraBoldItalic.ttf
  String get robotoExtraBoldItalic => 'assets/fonts/Roboto-ExtraBoldItalic.ttf';

  /// File path: assets/fonts/Roboto-ExtraLight.ttf
  String get robotoExtraLight => 'assets/fonts/Roboto-ExtraLight.ttf';

  /// File path: assets/fonts/Roboto-ExtraLightItalic.ttf
  String get robotoExtraLightItalic => 'assets/fonts/Roboto-ExtraLightItalic.ttf';

  /// File path: assets/fonts/Roboto-Italic.ttf
  String get robotoItalic => 'assets/fonts/Roboto-Italic.ttf';

  /// File path: assets/fonts/Roboto-Light.ttf
  String get robotoLight => 'assets/fonts/Roboto-Light.ttf';

  /// File path: assets/fonts/Roboto-LightItalic.ttf
  String get robotoLightItalic => 'assets/fonts/Roboto-LightItalic.ttf';

  /// File path: assets/fonts/Roboto-Medium.ttf
  String get robotoMedium => 'assets/fonts/Roboto-Medium.ttf';

  /// File path: assets/fonts/Roboto-MediumItalic.ttf
  String get robotoMediumItalic => 'assets/fonts/Roboto-MediumItalic.ttf';

  /// File path: assets/fonts/Roboto-Regular.ttf
  String get robotoRegular => 'assets/fonts/Roboto-Regular.ttf';

  /// File path: assets/fonts/Roboto-SemiBold.ttf
  String get robotoSemiBold => 'assets/fonts/Roboto-SemiBold.ttf';

  /// File path: assets/fonts/Roboto-SemiBoldItalic.ttf
  String get robotoSemiBoldItalic => 'assets/fonts/Roboto-SemiBoldItalic.ttf';

  /// File path: assets/fonts/Roboto-Thin.ttf
  String get robotoThin => 'assets/fonts/Roboto-Thin.ttf';

  /// File path: assets/fonts/Roboto-ThinItalic.ttf
  String get robotoThinItalic => 'assets/fonts/Roboto-ThinItalic.ttf';

  /// List of all assets
  List<String> get values => [
    robotoBlack,
    robotoBlackItalic,
    robotoBold,
    robotoBoldItalic,
    robotoExtraBold,
    robotoExtraBoldItalic,
    robotoExtraLight,
    robotoExtraLightItalic,
    robotoItalic,
    robotoLight,
    robotoLightItalic,
    robotoMedium,
    robotoMediumItalic,
    robotoRegular,
    robotoSemiBold,
    robotoSemiBoldItalic,
    robotoThin,
    robotoThinItalic,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/launcher.png
  AssetGenImage get launcher => const AssetGenImage('assets/images/launcher.png');

  /// List of all assets
  List<AssetGenImage> get values => [launcher];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/vi.json
  String get vi => 'assets/translations/vi.json';

  /// List of all assets
  List<String> get values => [vi];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}, this.animation});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({required this.isAnimation, required this.duration, required this.frames});

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
