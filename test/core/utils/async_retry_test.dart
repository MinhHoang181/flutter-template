import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/async_retry.dart';

void main() {
  group('AsyncRetry', () {
    test('should return result if first attempt is successful', () async {
      final retry = AsyncRetry<int>(
        maxAttempts: 3,
        delay: const Duration(milliseconds: 100),
        shouldRetry: (result) => result == null,
      );

      int attempts = 0;
      final result = await retry.run(() async {
        attempts++;
        return 42;
      });

      expect(result, 42);
      expect(attempts, 1);
    });

    test('should retry if shouldRetry returns true', () {
      fakeAsync((async) {
        final retry = AsyncRetry<int>(
          maxAttempts: 3,
          delay: const Duration(milliseconds: 100),
          shouldRetry: (result) => result == null,
        );

        int attempts = 0;
        int? result;
        bool completed = false;

        retry.run(() async {
          attempts++;
          if (attempts < 2) return null;
          return 42;
        }).then((value) {
          result = value;
          completed = true;
        });

        // First attempt happens immediately
        async.flushMicrotasks();
        expect(attempts, 1);
        expect(completed, false);

        // Wait for delay
        async.elapse(const Duration(milliseconds: 100));
        async.flushMicrotasks();

        expect(attempts, 2);
        expect(result, 42);
        expect(completed, true);
      });
    });

    test('should exhaust all attempts if shouldRetry always returns true', () {
      fakeAsync((async) {
        final retry = AsyncRetry<int>(
          maxAttempts: 3,
          delay: const Duration(milliseconds: 100),
          shouldRetry: (result) => result == null,
        );

        int attempts = 0;
        int? result;
        bool completed = false;

        retry.run(() async {
          attempts++;
          return null;
        }).then((value) {
          result = value;
          completed = true;
        });

        // Attempt 1
        async.flushMicrotasks();
        expect(attempts, 1);

        // Attempt 2
        async.elapse(const Duration(milliseconds: 100));
        async.flushMicrotasks();
        expect(attempts, 2);

        // Attempt 3
        async.elapse(const Duration(milliseconds: 100));
        async.flushMicrotasks();
        expect(attempts, 3);

        expect(result, null);
        expect(completed, true);
      });
    });

    test('should rethrow error on the last attempt', () {
      fakeAsync((async) {
        final retry = AsyncRetry<int>(
          maxAttempts: 3,
          delay: const Duration(milliseconds: 100),
          shouldRetry: null,
        );

        int attempts = 0;
        Object? capturedError;

        retry.run(() async {
          attempts++;
          throw Exception('Failed');
        }).catchError((error) {
          capturedError = error;
          return null;
        });

        // Attempt 1
        async.flushMicrotasks();
        expect(attempts, 1);

        // Attempt 2
        async.elapse(const Duration(milliseconds: 100));
        async.flushMicrotasks();
        expect(attempts, 2);

        // Attempt 3
        async.elapse(const Duration(milliseconds: 100));
        async.flushMicrotasks();
        expect(attempts, 3);

        expect(capturedError, isA<Exception>());
      });
    });

    test('default shouldRetry (null) retries if result is null', () {
      fakeAsync((async) {
        final retry = AsyncRetry<int>(
          maxAttempts: 2,
          delay: const Duration(milliseconds: 100),
          shouldRetry: null,
        );

        int attempts = 0;
        retry.run(() async {
          attempts++;
          return null;
        });

        async.flushMicrotasks();
        expect(attempts, 1);

        async.elapse(const Duration(milliseconds: 100));
        async.flushMicrotasks();
        expect(attempts, 2);
      });
    });
  });
}
