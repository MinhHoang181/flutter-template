class AsyncRetry<T> {
  AsyncRetry({
    required this.maxAttempts,
    required this.delay,
    required this.shouldRetry,
  });

  final int maxAttempts;

  final Duration delay;

  final bool Function(T? result)? shouldRetry;

  Future<T?> run(Future<T?> Function() callback) async {
    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        final result = await callback();

        if (shouldRetry != null && !shouldRetry!(result)) {
          return result;
        }

        if (shouldRetry == null && result != null) {
          return result;
        }
      } catch (e) {
        if (attempt == maxAttempts - 1) rethrow;
      }

      if (attempt < maxAttempts - 1) {
        await Future.delayed(delay);
      }
    }

    return null;
  }
}
