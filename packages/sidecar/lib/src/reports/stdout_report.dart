import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:riverpod/riverpod.dart';

import '../protocol/logging/log_record.dart';
import '../protocol/responses/notification_union.dart';
import '../utils/printer/lint_printer.dart';
import '../utils/utils.dart';
import 'report.dart';

class StdoutReport extends Report {
  StdoutReport();

  late Uri uri;
  late Progress progress;

  final Stopwatch watch = Stopwatch();

  void init(Uri uri) {
    this.uri = uri;
    progress = Logger.standard().progress('Analyzing');
    watch.start();
  }

  @override
  void handleError(Object object, StackTrace stackTrace) {
    throw UnimplementedError();
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

  void save() {
    progress.finish();
    final stringBuffer = StringBuffer();

    // stringBuffer.writeln();
    // stringBuffer.writeln('project:\u001b[35m ${root.toFilePath()} \u001b[0m');
    // stringBuffer.writeln('plugin:  ${pluginPackage.root.toFilePath()}');
    // stringBuffer.writeln();

    for (final resultEntry in _notifications) {
      final lintResults = resultEntry.lints;
      final relativePath = resultEntry.file.relativePath;

      if (lintResults.isNotEmpty) {
        stringBuffer.writeln('$relativePath: ${lintResults.length} results\n');
        stringBuffer.writeln(lintResults.toList().prettyPrint());
      }
    }
    stringBuffer
        .writeln('analysis completed in:  ${watch.elapsed.prettified()}');
    stdout.writeln();
    stdout.write(stringBuffer.toString());
    watch.stop();
  }
}

final stdoutReportProvider = Provider((ref) => StdoutReport());
