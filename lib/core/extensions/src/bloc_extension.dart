part of '../extensions.dart';

extension BlocContextExt on BuildContext {
  T bloc<T extends StateStreamableSource<Object?>>({bool listen = false}) {
    return BlocProvider.of(this, listen: listen);
  }

  T? blocOrNull<T extends StateStreamableSource<Object?>>({
    bool listen = false,
  }) {
    try {
      return BlocProvider.of(this, listen: listen);
    } catch (_) {
      return null;
    }
  }
}
