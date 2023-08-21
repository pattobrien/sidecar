import 'package:riverpod/riverpod.dart';

import '../protocol/communication/notifications.dart';
import '../protocol/models/log_record.dart';
import 'reporter.dart';

class JsonReporter implements Reporter {
  @override
  void handleError(Object object, StackTrace stackTrace) {
    // TODO: implement handleError
  }

  @override
  void handleLintNotification(LintNotification notification) {
    _notifications.add(notification);
  }

  final List<LintNotification> _notifications = [];

  @override
  void handleLog(LogRecord log) {
    // TODO: implement handleLog
  }

  @override
  bool hasErrors({bool isStrictMode = false}) {
    // TODO: implement hasErrors
    throw UnimplementedError();
  }

  @override
  void print({bool toDisk = true}) {
    // TODO: implement print
  }
  //
}

final jsonReporterProvider = Provider<Reporter>((_) => JsonReporter());
