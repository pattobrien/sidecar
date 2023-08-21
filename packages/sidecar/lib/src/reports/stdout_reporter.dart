import 'dart:convert';
import 'dart:io';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../../sidecar.dart';
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

  @override
  void print({bool toDisk = true}) {
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

    if (toDisk) {
      final diagnostics = _notifications.map((e) => e.toJson()).toList();
      final json = {'diagnostics': diagnostics};
      final stringifiedJson = jsonEncode(json);
      final resourceProvider = PhysicalResourceProvider.INSTANCE;
      final sidecarFolder = resourceProvider
          .getFolder(join(uri.toFilePath(), kDartTool, 'sidecar_gen'));
      if (!sidecarFolder.exists) sidecarFolder.create();
      final genFile = sidecarFolder.getChildAssumingFile('report.json');
      genFile.writeAsStringSync(stringifiedJson);
    }
    _notifications.clear();
  }

  @override
  bool hasErrors({
    bool isStrictMode = false,
  }) {
    if (isStrictMode) {
      return _notifications.isNotEmpty;
    } else {
      final warningsAndErrors = _notifications
          .expand((element) => element.lints)
          .where((element) => element.severity != LintSeverity.info);
      return warningsAndErrors.isNotEmpty;
    }
  }
}

final stdoutReportProvider = Provider((ref) => StdoutReporter());
