import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:riverpod/riverpod.dart';

import '../protocol/communication/communication.dart';
import '../protocol/logging/log_record.dart';
import '../utils/duration_ext.dart';
import '../utils/printer/lint_printer.dart';
import 'reporter.dart';

class StdoutReporter extends Reporter {
  StdoutReporter();

  late Uri uri;
  late Progress progress;

  void init(Uri uri) {
    this.uri = uri;
    progress = Logger.standard().progress('Analyzing');
  }

  void refresh() {
    progress = Logger.standard().progress('Analyzing');
  }

  @override
  void handleError(Object object, StackTrace stackTrace) {
    stderr.addError(object, stackTrace);
  }

  @override
  void handleLintNotification(LintNotification notification) {
    _notifications.add(notification);
  }

  final List<LintNotification> _notifications = [];

  @override
  void handleLog(LogRecord log) {
    throw UnimplementedError();
  }

  void print() {
    // progress.finish();
    final buffer = StringBuffer();

    for (final resultEntry in _notifications) {
      final lintResults = resultEntry.lints;
      final relativePath = resultEntry.file.relativePath;

      if (lintResults.isNotEmpty) {
        buffer.writeln('$relativePath: ${lintResults.length} results\n');
        buffer.writeln(lintResults.toList().prettyPrint());
      }
    }
    buffer.writeln('analysis completed in: ${progress.elapsed.prettified()}\n');
    stdout.write(buffer.toString());
    _notifications.clear();
  }
}

final stdoutReportProvider = Provider((ref) => StdoutReporter());
