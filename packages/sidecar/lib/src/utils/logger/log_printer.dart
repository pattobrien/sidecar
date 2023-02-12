import 'dart:io' as io;
import 'dart:math' hide log;

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:file/file.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

import '../../protocol/models/log_record.dart';
import '../../rules/rules.dart';
import '../file_paths.dart';

class LogPrinter {
  LogPrinter(
    this.constructors,
    this.workspaceRoot,
  ) {
    _longestId = longestId(constructors);
    initFile();
  }

  final List<SidecarBaseConstructor> constructors;
  final Uri workspaceRoot;

  late IOSink sink;
  late io.File logFile;

  late int _longestId;

  void initFile() {
    if (io.Platform.isWindows) return;
    const currentSession = 'latest.log';
    final workspacePath = workspaceRoot.toFilePath();
    final latestLogPath =
        join(workspacePath, kDartTool, kLogsFolder, currentSession);

    logFile = io.File(latestLogPath);
    if (logFile.existsSync()) {
      final firstLine = logFile.readAsLinesSync().first;
      final tryDate = DateTime.tryParse(firstLine);
      final resourceProvider = PhysicalResourceProvider.INSTANCE;

      final latestLogFile = resourceProvider.getFile(latestLogPath);
      final previousLogContent = latestLogFile.readAsStringSync();

      final parentFolder = resourceProvider
          .getFolder(join(workspacePath, kDartTool, kLogsFolder, 'archive'));
      parentFolder.create();

      final oldLogFile = parentFolder.getChildAssumingFile(
          'log-${tryDate?.millisecondsSinceEpoch ?? const Uuid().v1()}.log');
      oldLogFile.writeAsStringSync(previousLogContent);
      latestLogFile.delete();
    }
    logFile.createSync(recursive: true);
    sink = logFile.openWrite(mode: io.FileMode.append);
    sink.writeln(DateTime.now().toIso8601String());
    sink.writeln('ANALYZER ROOT: ${workspaceRoot.toFilePath()}');
  }

  void handleLog(LogRecord record) {
    if (io.Platform.isWindows) return;
    final id = record.map(
        simple: (simple) => 'SIMPLE',
        fromAnalyzer: (value) =>
            value.targetRoot.pathSegments.reversed.toList()[1],
        fromRule: (value) => value.lintCode.prettyPrint());

    final msg = '${record.severity.prettified} | '
        '${record.timestamp.toIso8601String().padRight(26)} | '
        '${id.padRight(_longestId)} | '
        '${record.message}'
        '${record.stackTrace != null ? '\n${record.stackTrace}' : ''}';

    sink.writeln(msg);
  }

  Future<void> onDispose() => sink.close();
}

int longestId(List<SidecarBaseConstructor> constructors) {
  var longestId = 0;
  for (final constructor in constructors) {
    longestId = max(longestId, constructor().code.prettyPrint().length);
  }
  return longestId;
}
