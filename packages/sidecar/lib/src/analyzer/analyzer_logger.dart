import 'package:logging/logging.dart' hide LogRecord;
import 'package:riverpod/riverpod.dart';

import '../protocol/models/models.dart';
import '../rules/rules.dart';
import '../utils/logger/log_printer.dart';

// final logger =

final loggerProvider = Provider<Logger>((ref) {
  return throw UnimplementedError();
});

extension LoggerInit on Logger {
  void initialize(Uri root, List<SidecarBaseConstructor> constructors) {
    hierarchicalLoggingEnabled = true;
    level = Level.FINEST;
    final printer = LogPrinter(constructors, root);
    onRecord.listen((log) => printer.handleLog(log.toAnalyzerLog(root)));
  }
}
