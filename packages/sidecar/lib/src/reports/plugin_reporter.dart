import 'dart:io' as io;

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

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
    final workspacePath = workspaceRoot.toFilePath();
    final latestLogPath =
        join(workspacePath, kDartTool, kLogsFolder, currentSession);

    logFile = io.File(latestLogPath);
    //TODO: reinstate below
    if (logFile.existsSync()) {
      final firstLine = logFile.readAsLinesSync().first;
      final tryDate = DateTime.tryParse(firstLine);
      final resourceProvider = PhysicalResourceProvider.INSTANCE;
      // final parentPath = logFile.parent.uri.toFilePath();
      // logFile.renameSync(join(parentPath, 'log-$firstLine.log'));
      final latestLogFile = resourceProvider.getFile(latestLogPath);
      final previousLogContent = latestLogFile.readAsStringSync();
      // final newFile = resourceProvider.getFile(
      //     join(workspacePath, kDartTool, kLogsFolder, 'log-$firstLine.log'));
      final parentFolder = resourceProvider
          .getFolder(join(workspacePath, kDartTool, kLogsFolder, 'archive'));
      parentFolder.create();
      final oldLogFile = parentFolder.getChildAssumingFile(
          'log-${tryDate?.millisecondsSinceEpoch ?? const Uuid().v1()}.log');
      oldLogFile.writeAsStringSync(previousLogContent);
      latestLogFile.delete();
      // logFile.copySync(
      //     join(workspacePath, kDartTool, kLogsFolder, 'log-$firstLine.log'));
      // logFile.delete();
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
    // sink.writeln(log.prettified());
  }

  void close() => sink.close();

  @override
  bool hasErrors({bool isStrictMode = false}) {
    throw UnimplementedError();
  }

  @override
  void print({bool toDisk = true}) {
    throw UnimplementedError();
  }
}

final pluginReporterProvider = Provider((ref) {
  final workspaceRoot = ref.watch(runnerWorkspaceRoot);
  return PluginReporter(workspaceRoot);
});

final runnerWorkspaceRoot = Provider<Uri>((ref) => throw UnimplementedError());
