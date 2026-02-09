import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/async_deduplicator.dart';

void main() {
  group('AsyncDeduplicator', () {
    late AsyncDeduplicator<int> deduplicator;

    setUp(() {
      deduplicator = AsyncDeduplicator<int>();
    });

    test('should return the same future for concurrent calls', () async {
      int callCount = 0;
      Future<int> fetch() async {
        callCount++;
        await Future.delayed(const Duration(milliseconds: 50));
        return 42;
      }

      final f1 = deduplicator.fetch(fetch);
      final f2 = deduplicator.fetch(fetch);

      expect(f1, equals(f2));

      final results = await Future.wait([f1, f2]);
      expect(results[0], 42);
      expect(results[1], 42);
      expect(callCount, 1);
    });

    test('should allow new calls after previous one completes', () async {
      int callCount = 0;
      Future<int> fetch() async {
        callCount++;
        return callCount;
      }

      final r1 = await deduplicator.fetch(fetch);
      expect(r1, 1);
      expect(callCount, 1);

      final r2 = await deduplicator.fetch(fetch);
      expect(r2, 2);
      expect(callCount, 2);
    });

    test('should clear inflight even if future fails', () async {
      int callCount = 0;
      Future<int> fetch() async {
        callCount++;
        throw Exception('failed');
      }

      await expectLater(deduplicator.fetch(fetch), throwsException);
      expect(deduplicator.isRunning, isFalse);

      await expectLater(deduplicator.fetch(fetch), throwsException);
      expect(callCount, 2);
    });
  });

  group('KeyedAsyncDeduplicator', () {
    late KeyedAsyncDeduplicator<String, int> deduplicator;

    setUp(() {
      deduplicator = KeyedAsyncDeduplicator<String, int>();
    });

    test('should deduplicate by key', () async {
      int callCount1 = 0;
      Future<int> fetch1() async {
        callCount1++;
        await Future.delayed(const Duration(milliseconds: 50));
        return 1;
      }

      int callCount2 = 0;
      Future<int> fetch2() async {
        callCount2++;
        await Future.delayed(const Duration(milliseconds: 50));
        return 2;
      }

      final f1a = deduplicator.fetch('key1', fetch1);
      final f1b = deduplicator.fetch('key1', fetch1);
      final f2 = deduplicator.fetch('key2', fetch2);

      expect(f1a, equals(f1b));
      expect(f1a, isNot(equals(f2)));

      final results = await Future.wait([f1a, f1b, f2]);
      expect(results[0], 1);
      expect(results[1], 1);
      expect(results[2], 2);
      expect(callCount1, 1);
      expect(callCount2, 1);
    });

    test('should allow new calls for same key after completion', () async {
      int callCount = 0;
      Future<int> fetch() async {
        callCount++;
        return callCount;
      }

      await deduplicator.fetch('key', fetch);
      await deduplicator.fetch('key', fetch);
      expect(callCount, 2);
    });
  });
}
