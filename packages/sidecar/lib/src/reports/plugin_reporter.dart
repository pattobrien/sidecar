import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../protocol/communication/communication.dart';
import '../protocol/logging/log_record.dart';
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
    logFile = io.File.fromUri(workspaceRoot
        .resolve(join(kDartTool, 'sidecar_logs', '$timestamp.txt')));
    logFile.createSync(recursive: true);
    sink = logFile.openWrite(mode: io.FileMode.append);
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
