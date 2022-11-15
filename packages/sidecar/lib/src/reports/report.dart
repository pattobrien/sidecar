import '../protocol/logging/log_record.dart';
import '../protocol/protocol.dart';

abstract class Report {
  void handleLintNotification(LintNotification notification);
  void handleError(Object object, StackTrace stackTrace);
  void handleLog(LogRecord log);
}
