import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../protocol/logging/log_record.dart';
import 'report.dart';

class PluginReporter extends Report {
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
    // print('PRINTING LOGS');
    // logFile.writeAsString('${object.toString()} || ${stackTrace.toString()}\n',
    //     mode: io.FileMode.append);
  }

  @override
  void handleLintNotification(LintNotification notification) {
    sink.writeln(notification.toString());
    // print('PRINTING LOGS');
    // logFile.writeAsString('${notification.toString()}\n',
    //     mode: io.FileMode.append);
  }

  @override
  void handleLog(LogRecord log) {
    // print('PRINTING LOGS');
    sink.writeln(log.prettified());
    // logFile.writeAsString('${log.toString()}\n', mode: io.FileMode.append);
  }

  void close() => sink.close();
}

final pluginReporterProvider = Provider((ref) {
  final workspaceRoot = ref.watch(runnerWorkspaceRoot);
  return PluginReporter(workspaceRoot);
});

final runnerWorkspaceRoot = Provider<Uri>((ref) => throw UnimplementedError());
