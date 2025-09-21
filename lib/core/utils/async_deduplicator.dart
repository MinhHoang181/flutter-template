class AsyncDeduplicator<T> {
  Future<T>? _inflight;

  Future<T> fetch(Future<T> Function() callback) {
    // If there's already a running task → return the same Future
    final existing = _inflight;
    if (existing != null) return existing;

    // Wrap with Future.sync to catch both sync and async errors
    final future = Future.sync(callback).whenComplete(() {
      // Clear after completion (success or failure)
      _inflight = null;
    });

    _inflight = future;
    return future;
  }

  bool get isRunning => _inflight != null;

  void invalidate() => _inflight = null; // allows force clear if needed
}

class KeyedAsyncDeduplicator<K, T> {
  final Map<K, Future<T>> _inflightByKey = <K, Future<T>>{};

  Future<T> fetch(K key, Future<T> Function() callback) {
    // If there's already a running task for this key → return the same Future
    final existing = _inflightByKey[key];
    if (existing != null) return existing;

    // Use late to allow referencing the variable inside the callback
    late final Future<T> future;
    future = Future.sync(callback).whenComplete(() {
      // Only clear if it is still the current future (avoid overwrite race)
      if (_inflightByKey[key] == future) _inflightByKey.remove(key);
    });

    _inflightByKey[key] = future;
    return future;
  }

  // Check if a task is running for the provided key
  bool isRunning(K key) => _inflightByKey.containsKey(key);

  // Invalidate a specific key
  void invalidate(K key) => _inflightByKey.remove(key);

  // Clear all tracked futures
  void clearAll() => _inflightByKey.clear();
}
