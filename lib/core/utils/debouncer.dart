import 'dart:async';

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;

  Timer? _timer;
  Completer<void>? _currentCompleter;

  Future<void> run(FutureOr<void> Function() action) {
    _timer?.cancel();

    _currentCompleter?.complete();
    _currentCompleter = Completer<void>();

    _timer = Timer(Duration(milliseconds: milliseconds), () async {
      await action();
      _currentCompleter?.complete();
      _currentCompleter = null;
    });

    return _currentCompleter!.future;
  }

  void dispose() {
    _timer?.cancel();
    _currentCompleter?.complete();
    _currentCompleter = null;
  }
}
