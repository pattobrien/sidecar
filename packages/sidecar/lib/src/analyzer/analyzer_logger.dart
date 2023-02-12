import 'package:logging/logging.dart' hide LogRecord;
import 'package:riverpod/riverpod.dart';

import '../protocol/models/models.dart';
import '../rules/rules.dart';
import '../utils/logger/log_printer.dart';

final loggerProvider = Provider<Logger>((ref) {
  return Logger('unknown');
});

extension LoggerInit on Logger {
  AsyncCallback initialize(
      Uri root, List<SidecarBaseConstructor> constructors) {
    hierarchicalLoggingEnabled = true;
    level = Level.FINEST;
    final printer = LogPrinter(constructors, root);
    onRecord.listen((log) => printer.handleLog(log.toAnalyzerLog(root)));
    return printer.onDispose;
  }
}

typedef AsyncCallback = Future<void> Function();
