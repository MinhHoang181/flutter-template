part of '../app.dart';

extension DeviceExt on _AppExt {
  ///The number of device pixels for each logical pixel.
  double get pixelRatio => PlatformDispatcher.instance.views.first.devicePixelRatio;

  Size get size => PlatformDispatcher.instance.views.first.physicalSize / pixelRatio;

  ///The horizontal extent of this size.
  double get width => size.width;

  ///The vertical extent of this size
  double get height => size.height;
}

extension FocusExt on _AppExt {
  FocusNode? get focusScope => FocusManager.instance.primaryFocus;

  void unfocus() {
    focusScope?.unfocus();
  }
}
