import 'dart:io';

import 'package:characters/characters.dart';
import 'package:path/path.dart' as p;
import 'package:sidecar/sidecar.dart';

import 'log_delegate_base.dart';

class DebuggerLogDelegate implements LogDelegateBase {
  const DebuggerLogDelegate({
    this.isVerboseEnabled = false,
  });

  final bool isVerboseEnabled;

  @override
  void analysisResultError(
      AnalysisResult result, Object err, StackTrace stackTrace) {
    stderr.writeln('analysisResultError: $err \n$stackTrace');
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    stderr.writeln('pluginInitializationFail: $err\n$stackTrace');
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    stderr.writeln('sidecarError: $error\n$stackTrace');
  }

  @override
  void sidecarVerboseMessage(String message) {
    if (!isVerboseEnabled) return;
    stdout.writeln(message);
  }

  @override
  void pluginRestart() {
    stdout.writeln('pluginRestart');
  }

  @override
  void sidecarMessage(String message) {
    stdout.writeln(message);
  }

  @override
  void analysisResults(String path, List<AnalysisResult> results) {
    if (results.isEmpty) return;
    final stringBuffer = StringBuffer();

    final relativePath = p.relative(path, from: Directory.current.path);

    for (final result in results) {
      final sourceLocation =
          '$relativePath:${result.sourceSpan.start.line}:${result.sourceSpan.start.column}';
      // final lintErrorType = result.rule.defaultType.coloredNamedd; $lintErrorType
      final lintPackage =
          result.rule.packageName.padRight(20).characters.take(20);
      final lintCode = result.rule.code.padRight(20).characters.take(20);
      final lintMessage = result.message.padRight(40).characters.take(40);
      stringBuffer.writeln(
          '${DateTime.now().toIso8601String()}   • $sourceLocation • $lintMessage • $lintPackage • $lintCode');
    }
    stdout.write(stringBuffer.toString());
  }
}
