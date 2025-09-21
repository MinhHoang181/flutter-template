import 'package:async/async.dart';

class SafeAsyncMemoizer<T> {
  late AsyncMemoizer<T> _cache = AsyncMemoizer<T>();

  bool _isRunning = false;

  bool _isCompleted = false;

  bool get isRunning => _isRunning;

  bool get isCompleted => _isCompleted;

  Future<T> runOnce(Future<T> Function() loader) {
    if (!_isRunning && !_isCompleted) {
      _isRunning = true;
    }
    return _cache.runOnce(
      () async {
        try {
          final result = await loader();
          _isCompleted = true;
          return result;
        } catch (_) {
          invalidate();
          rethrow;
        } finally {
          _isRunning = false;
        }
      },
    );
  }

  void invalidate() {
    // create new async memoizer
    _cache = AsyncMemoizer<T>();
    _isRunning = false;
    _isCompleted = false;
  }
}
