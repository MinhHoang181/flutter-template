import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/debouncer.dart';

void main() {
  group('Debouncer', () {
    test('should delay execution', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 100);
        bool executed = false;

        debouncer.run(() {
          executed = true;
        });

        expect(executed, false);

        async.elapse(const Duration(milliseconds: 50));
        expect(executed, false);

        async.elapse(const Duration(milliseconds: 60));
        expect(executed, true);
      });
    });

    test('should cancel previous calls', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 100);
        int executionCount = 0;

        debouncer.run(() {
          executionCount++;
        });

        async.elapse(const Duration(milliseconds: 50));
        expect(executionCount, 0);

        // Call again before the first one executes
        debouncer.run(() {
          executionCount++;
        });

        async.elapse(const Duration(milliseconds: 60));
        // First call should have been cancelled, second not yet executed
        expect(executionCount, 0);

        async.elapse(const Duration(milliseconds: 50));
        expect(executionCount, 1);
      });
    });

    test('run returns a future that completes when the action is done', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 100);
        bool executed = false;
        bool futureCompleted = false;

        debouncer.run(() async {
          executed = true;
        }).then((_) => futureCompleted = true);

        expect(executed, false);
        expect(futureCompleted, false);

        async.elapse(const Duration(milliseconds: 100));
        // We need to flush microtasks to see the 'then' callback execute
        async.flushMicrotasks();

        expect(executed, true);
        expect(futureCompleted, true);
      });
    });

    test('dispose cancels the timer', () {
      fakeAsync((async) {
        final debouncer = Debouncer(milliseconds: 100);
        bool executed = false;

        debouncer.run(() {
          executed = true;
        });

        debouncer.dispose();

        async.elapse(const Duration(milliseconds: 150));
        expect(executed, false);
      });
    });
  });
}
