import '../protocol/protocol.dart';

abstract class Reporter {
  void handleLintNotification(LintNotification notification);
  void handleError(Object object, StackTrace stackTrace);
  void handleLog(LogRecord log);
  bool hasErrors({bool isStrictMode = false});
}
