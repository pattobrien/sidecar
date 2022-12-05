import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../protocol/communication/communication.dart';
import '../protocol/models/log_record.dart';
import '../utils/utils.dart';
import 'reporter.dart';

class PluginReporter extends Reporter {
  PluginReporter(
    this.workspaceRoot,
  ) {
    init();
  }

  final Uri workspaceRoot;
  late io.IOSink sink;
  late int timestamp;
  late io.File logFile;

  void init() {
    timestamp = DateTime.now().millisecondsSinceEpoch;
    _createLogFileAndSink();
  }

  void _createLogFileAndSink() {
    const currentSession = 'latest.log';
    logFile = io.File.fromUri(
        workspaceRoot.resolve(join(kDartTool, kLogsFolder, currentSession)));
    if (logFile.existsSync()) {
      final firstLine = logFile.readAsLinesSync().first;
      logFile.renameSync(join(logFile.parent.path, 'log-$firstLine.log'));
    }
    logFile.createSync(recursive: true);
    sink = logFile.openWrite(mode: io.FileMode.append);
    sink.writeln(DateTime.now().toIso8601String());
  }

  @override
  void handleError(Object object, StackTrace stackTrace) {
    sink.writeln('${object.toString()} || ${stackTrace.toString()}');
  }

  @override
  void handleLintNotification(LintNotification notification) {
    sink.writeln(notification.toString());
  }

  @override
  void handleLog(LogRecord log) {
    sink.writeln(log.prettified());
  }

  void close() => sink.close();
}

final pluginReporterProvider = Provider((ref) {
  final workspaceRoot = ref.watch(runnerWorkspaceRoot);
  return PluginReporter(workspaceRoot);
});

final runnerWorkspaceRoot = Provider<Uri>((ref) => throw UnimplementedError());
