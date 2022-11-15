import '../protocol/logging/log_record.dart';
import '../protocol/responses/notification_union.dart';
import 'report.dart';

class PluginReporter extends Report {
  PluginReporter(this.workspaceRoot);
  final Uri workspaceRoot;
  @override
  void handleError(Object object, StackTrace stackTrace) {
    // TODO: implement handleError
  }

  @override
  void handleLintNotification(LintNotification notification) {
    // TODO: implement handleLintNotification
  }

  @override
  void handleLog(LogRecord log) {
    // TODO: implement handleLog
  }
  //
}
