import 'dart:io';

import 'package:sidecar/sidecar.dart';
import 'package:path/path.dart' as p;
import 'package:characters/characters.dart';

import 'log_delegate_base.dart';

class DebuggerLogDelegate implements LogDelegateBase {
  const DebuggerLogDelegate({
    this.isVerboseEnabled = false,
  });

  final bool isVerboseEnabled;

  @override
  void analysisResultError(
      AnalysisResult result, Object err, String stackTrace) {
    // print('DebuggerLogDelegate: lintError');
    stderr.writeln('DebuggerLogDelegate: $err\n$stackTrace');
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    // print('DebuggerLogDelegate: pluginInitializationFail $err');
    stderr.writeln('DebuggerLogDelegate: $err\n$stackTrace');
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    // print('DebuggerLogDelegate: sidecarError $error');
    stderr.writeln('sidecarError: $error\n$stackTrace');
  }

  @override
  void sidecarVerboseMessage(String message) {
    // print('DebuggerLogDelegate: sidecarMessage $message');
    if (!isVerboseEnabled) return;

    stdout.writeln('${DateTime.now().toIso8601String()} $message');
  }

  @override
  void pluginRestart() {}

  @override
  void sidecarMessage(String message) {
    stdout.writeln('sidecarMessage: $message');
  }

  @override
  void sendLints() {
    // TODO: implement sendLints
  }

  @override
  void analysisResult(AnalysisResult result) {
    final path = result.sourceSpan.sourceUrl!.path;
    final relativePath = p.relative(path, from: Directory.current.path);

    final sourceLocation =
        '$relativePath:${result.sourceSpan.start.line}:${result.sourceSpan.start.column}';
    // final lintErrorType = result.rule.defaultType.coloredNamedd; $lintErrorType
    final lintPackage =
        result.rule.packageName.padRight(20).characters.take(20);
    final lintCode = result.rule.code.padRight(20).characters.take(20);
    final lintMessage = result.message.padRight(40).characters.take(40);
    // final msg = message
    //     .split('\n')
    //     .map((e) => e.isEmpty ? '$label\n' : '$label $e\n')
    //     .join();

    stdout.writeln(
        '${DateTime.now().toIso8601String()}   • $sourceLocation • $lintMessage • $lintPackage • $lintCode');
  }

  @override
  void analysisResults(List<AnalysisResult> results) {
    // final path = result.sourceSpan.sourceUrl!.path;
    // final relativePath = p.relative(path, from: Directory.current.path);

    // final sourceLocation =
    //     '$relativePath:${result.sourceSpan.start.line}:${result.sourceSpan.start.column}';
    // // final lintErrorType = result.rule.defaultType.coloredNamedd; $lintErrorType
    // final lintPackage =
    //     result.rule.packageName.padRight(20).characters.take(20);
    // final lintCode = result.rule.code.padRight(20).characters.take(20);
    // final lintMessage = result.message.padRight(40).characters.take(40);
    // // final msg = message
    // //     .split('\n')
    // //     .map((e) => e.isEmpty ? '$label\n' : '$label $e\n')
    // //     .join();

    // stdout.writeln(
    //     '${DateTime.now().toIso8601String()}   • $sourceLocation • $lintMessage • $lintPackage • $lintCode');
  }
}
