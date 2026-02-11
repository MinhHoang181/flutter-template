part of '../app.dart';

Completer<void>? _overlayCompleter;

final _LoadingOverlay _loadingOverlay = _LoadingOverlay();

extension OverlayExt on _AppExt {
  static final RegExp _bottomSheetRegex = RegExp('BOTTOMSHEET');
  static final RegExp _dialogRegex = RegExp('DIALOG');

  Future<void> waitCurrentOverlayClose() {
    return _overlayCompleter?.future ?? Future.sync(() => null);
  }

  Future<T?> showDialog<T>({
    required Widget child,
    bool waitOverlayComplete = false,
    bool barrierDismissible = true,
  }) async {
    if (waitOverlayComplete && _overlayCompleter != null && !_overlayCompleter!.isCompleted) {
      await _overlayCompleter?.future;
    }

    _overlayCompleter ??= Completer();

    if (!context.mounted) return null;
    final data = await material.showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return child;
      },
    );
    if (!(_overlayCompleter?.isCompleted ?? true)) {
      _overlayCompleter?.complete(null);
      _overlayCompleter = null;
    }

    return data;
  }

  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool waitOverlayComplete = false,
    bool isDismissible = true,
    bool isScrollControlled = false,
    Color? backgroundColor,
    ShapeBorder? shape,
  }) async {
    if (waitOverlayComplete && _overlayCompleter != null && !_overlayCompleter!.isCompleted) {
      await _overlayCompleter?.future;
    }

    _overlayCompleter ??= Completer();

    if (!context.mounted) return null;
    final data = await material.showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      backgroundColor: backgroundColor,
      shape: shape,
      builder: (_) => child,
    );

    if (!(_overlayCompleter?.isCompleted ?? true)) {
      _overlayCompleter?.complete(null);
      _overlayCompleter = null;
    }

    return data;
  }

  /// Close bottom sheet (number of bottom sheets to close)
  ///
  /// If null, close all
  void closeBottomSheet([int? number = 1]) {
    Navigator.of(context).popUntil((route) {
      final String type = route.runtimeType.toString().toUpperCase();
      if (number != null && number! <= 0) return true;

      if (route is PopupRoute) {
        if (type.contains(_bottomSheetRegex)) {
          if (number != null) {
            number = number! - 1;
          }

          return false;
        }
      }
      return true;
    });
  }

  /// Close dialog (number of dialogs to close)
  ///
  /// If null, close all
  void closeDialog([int? number = 1]) {
    Navigator.of(context).popUntil((route) {
      final String type = route.runtimeType.toString().toUpperCase();
      if (number != null && number! <= 0) return true;

      if (route is PopupRoute) {
        if (type.contains(_dialogRegex)) {
          if (number != null) {
            number = number! - 1;
          }

          return false;
        }
      }
      return true;
    });
  }

  void showLoading({bool lockOnly = false}) => _loadingOverlay.showLoading(context, lockOnly: lockOnly);

  void hideLoading() => _loadingOverlay.hideLoading();
}

class _LoadingOverlay {
  _LoadingOverlay();

  @protected
  bool layerWaiting = false;

  @protected
  OverlayEntry? overlayEntryOpacity;

  @protected
  OverlayEntry? overlayEntryLoader;

  @protected
  OverlayEntry? overlayEntryLock;

  void showLoading(BuildContext context, {bool lockOnly = false}) async {
    if (layerWaiting) return;
    layerWaiting = true;
    final NavigatorState? navigatorState = Navigator.maybeOf(context, rootNavigator: false);
    final OverlayState? overlayState = navigatorState?.overlay;

    if (overlayState != null) {
      if (lockOnly) {
        overlayEntryLock = lockBuilder();
        overlayState.insert(overlayEntryLock!);
      } else {
        overlayEntryOpacity = opacityBuilder();
        overlayEntryLoader = loadingBuilder();

        overlayState.insert(overlayEntryOpacity!);
        overlayState.insert(overlayEntryLoader!);
      }
    }
  }

  void hideLoading() {
    if (layerWaiting) {
      layerWaiting = false;
      overlayEntryLoader?.remove();
      overlayEntryLoader = null;
      overlayEntryOpacity?.remove();
      overlayEntryOpacity = null;
      overlayEntryLock?.remove();
      overlayEntryLock = null;
    }
  }

  @protected
  OverlayEntry opacityBuilder() => OverlayEntry(
    builder: (context) {
      return const ColoredBox(color: Color(0x80000000));
    },
  );

  @protected
  OverlayEntry loadingBuilder() => OverlayEntry(
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );

  @protected
  OverlayEntry lockBuilder() => OverlayEntry(
    builder: (context) {
      return const AbsorbPointer(child: SizedBox.expand());
    },
  );
}
