part of '../app.dart';

const _encoder = JsonEncoder.withIndent('  ');

final Talker debugTalker = Talker(
  logger: TalkerLogger(
    settings: TalkerLoggerSettings(lineSymbol: '', maxLineWidth: 0),
    formatter: const ColoredLoggerFormatter(),
    output: (message) {
      if (kDebugMode) {
        log(message, name: 'Debug');
      }
    },
  ),
);

enum LogLevel { debug, info, warning, error }

extension LogExt on _AppExt {
  void logError({required String title, required Object? error, StackTrace? stackTrace, bool takeScreenshot = false}) {
    // Network error will be handled by Dio logger
    if (error is DioException) return;

    if (error is String?) error = Exception(error);

    // implement remote log service here

    if (kDebugMode) {
      debugTalker.error('[$title]', error);
      if (stackTrace != null) {
        log('stackTrace', stackTrace: stackTrace);
      }
    } else {
      debugTalker.error('[$title]', error, stackTrace);
    }
  }

  void logDebug({required String title, required String message, Object? data, LogLevel level = LogLevel.debug}) {
    final buffer = StringBuffer('[$title] $message');

    if (data != null) {
      buffer
        ..writeln()
        ..write('Data: ')
        ..writeln(_encoder.convert(data));
    }

    if (kDebugMode) {
      switch (level) {
        case LogLevel.debug:
          debugTalker.debug(buffer.toString());
        case LogLevel.info:
          debugTalker.info(buffer.toString());
        case LogLevel.warning:
          debugTalker.warning(buffer.toString());
        case LogLevel.error:
          debugTalker.error(buffer.toString());
      }
    }
  }
}
