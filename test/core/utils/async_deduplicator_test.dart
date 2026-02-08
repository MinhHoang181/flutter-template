import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/utils/async_deduplicator.dart';

abstract class _Callback {
  Future<int> call();
}

class MockCallback extends Mock implements _Callback {}

void main() {
  group('AsyncDeduplicator', () {
    late AsyncDeduplicator<int> deduplicator;
    late MockCallback mockCallback;

    setUp(() {
      deduplicator = AsyncDeduplicator<int>();
      mockCallback = MockCallback();
    });

    test('fetch returns the same future for concurrent calls', () async {
      final completer = Completer<int>();
      when(() => mockCallback.call()).thenAnswer((_) => completer.future);

      final f1 = deduplicator.fetch(() => mockCallback.call());
      final f2 = deduplicator.fetch(() => mockCallback.call());

      expect(f1, equals(f2));
      verify(() => mockCallback.call()).called(1);
      expect(deduplicator.isRunning, isTrue);

      completer.complete(42);
      final result1 = await f1;
      final result2 = await f2;

      expect(result1, equals(42));
      expect(result2, equals(42));
      expect(deduplicator.isRunning, isFalse);
    });

    test('fetch allows new call after completion', () async {
      when(() => mockCallback.call()).thenAnswer((_) async => 1);
      await deduplicator.fetch(() => mockCallback.call());

      when(() => mockCallback.call()).thenAnswer((_) async => 2);
      await deduplicator.fetch(() => mockCallback.call());

      verify(() => mockCallback.call()).called(2);
    });

    test('fetch clears inflight even on error', () async {
      when(() => mockCallback.call()).thenThrow(Exception('error'));

      await expectLater(
        () => deduplicator.fetch(() => mockCallback.call()),
        throwsA(isA<Exception>()),
      );

      expect(deduplicator.isRunning, isFalse);
    });

    test('invalidate clears inflight future', () async {
      final completer = Completer<int>();
      when(() => mockCallback.call()).thenAnswer((_) => completer.future);

      deduplicator.fetch(() => mockCallback.call());

      expect(deduplicator.isRunning, isTrue);
      deduplicator.invalidate();
      expect(deduplicator.isRunning, isFalse);
    });
  });

  group('KeyedAsyncDeduplicator', () {
    late KeyedAsyncDeduplicator<String, int> deduplicator;
    late MockCallback mockCallback;

    setUp(() {
      deduplicator = KeyedAsyncDeduplicator<String, int>();
      mockCallback = MockCallback();
    });

    test('fetch returns the same future for same key', () async {
      final completer = Completer<int>();
      when(() => mockCallback.call()).thenAnswer((_) => completer.future);

      final f1 = deduplicator.fetch('key1', () => mockCallback.call());
      final f2 = deduplicator.fetch('key1', () => mockCallback.call());

      expect(f1, equals(f2));
      verify(() => mockCallback.call()).called(1);

      completer.complete(42);
      expect(await f1, equals(42));
    });

    test('fetch returns different futures for different keys', () async {
      when(() => mockCallback.call()).thenAnswer((_) async => 1);
      final f1 = deduplicator.fetch('key1', () => mockCallback.call());

      when(() => mockCallback.call()).thenAnswer((_) async => 2);
      final f2 = deduplicator.fetch('key2', () => mockCallback.call());

      expect(f1, isNot(equals(f2)));
      expect(await f1, equals(1));
      expect(await f2, equals(2));
      verify(() => mockCallback.call()).called(2);
    });

    test('isRunning and invalidate work as expected', () async {
      final completer = Completer<int>();
      when(() => mockCallback.call()).thenAnswer((_) => completer.future);
      deduplicator.fetch('key1', () => mockCallback.call());

      expect(deduplicator.isRunning('key1'), isTrue);
      expect(deduplicator.isRunning('key2'), isFalse);

      deduplicator.invalidate('key1');
      expect(deduplicator.isRunning('key1'), isFalse);
    });

    test('clearAll clears all keys', () async {
      final completer = Completer<int>();
      when(() => mockCallback.call()).thenAnswer((_) => completer.future);
      deduplicator.fetch('key1', () => mockCallback.call());
      deduplicator.fetch('key2', () => mockCallback.call());

      expect(deduplicator.isRunning('key1'), isTrue);
      expect(deduplicator.isRunning('key2'), isTrue);

      deduplicator.clearAll();
      expect(deduplicator.isRunning('key1'), isFalse);
      expect(deduplicator.isRunning('key2'), isFalse);
    });
  });
}
