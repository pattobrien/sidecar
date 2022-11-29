import '../protocol/models/log_record.dart';
import '../protocol/protocol.dart';

abstract class Reporter {
  void handleLintNotification(LintNotification notification);
  void handleError(Object object, StackTrace stackTrace);
  void handleLog(LogRecord log);
}
