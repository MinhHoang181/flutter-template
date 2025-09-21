import 'package:async/async.dart';

class SafeAsyncCache<T> {
  SafeAsyncCache(Duration duration) : _cache = AsyncCache<T>(duration);

  final AsyncCache<T> _cache;

  Future<T> fetch(Future<T> Function() loader) {
    return _cache.fetch(
      () async {
        try {
          return await loader();
        } catch (_) {
          _cache.invalidate();
          rethrow;
        }
      },
    );
  }

  void invalidate() => _cache.invalidate();
}
