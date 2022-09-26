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
  void lintError(LintRule lint, Object err, String stackTrace) {
    // print('DebuggerLogDelegate: lintError');
    stderr.writeln('DebuggerLogDelegate: $err\n$stackTrace');
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    // print('DebuggerLogDelegate: pluginInitializationFail $err');
    stderr.writeln('DebuggerLogDelegate: $err\n$stackTrace');
  }

  @override
  void lintMessage(DetectedLint lint, String message) {
    // final lintId = '${lint.rule.packageName} • ${lint.rule.code}';

    // stdout.encoding = AsciiCodec(allowInvalid: false);
    final relativePath =
        p.relative(lint.unit.path, from: Directory.current.path);

    final sourceLocation =
        '$relativePath:${lint.sourceSpan.start.line}:${lint.sourceSpan.start.column}';
    final lintErrorType = lint.rule.defaultType.coloredNamedd;
    final lintPackage = lint.rule.packageName.padRight(20).characters.take(20);
    final lintCode = lint.rule.code.padRight(20).characters.take(20);
    final lintMessage = lint.message.padRight(40).characters.take(40);
    // final msg = message
    //     .split('\n')
    //     .map((e) => e.isEmpty ? '$label\n' : '$label $e\n')
    //     .join();

    stdout.writeln(
        '${DateTime.now().toIso8601String()}  $lintErrorType • $sourceLocation • $lintMessage • $lintPackage • $lintCode');
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    // print('DebuggerLogDelegate: sidecarError $error');
    stderr.writeln('DebuggerLogDelegate: $error\n$stackTrace');
  }

  @override
  void sidecarVerboseMessage(String message) {
    // print('DebuggerLogDelegate: sidecarMessage $message');
    if (!isVerboseEnabled) return;

    stdout.writeln('${DateTime.now().toIso8601String()} $message');
  }

  @override
  void editMessage(CodeEdit edit, String message) {
    final label = '[${edit.packageName}.${edit.code}]';

    final msg = message
        .split('\n')
        .map((e) => e.isEmpty ? '$label\n' : '$label $e\n')
        .join();

    stdout.writeln('DebuggerLogDelegate: CodeEdit $msg');
  }

  @override
  void pluginRestart() {}

  @override
  void sidecarMessage(String message) {
    stdout.writeln('DebuggerLogDelegate: $message');
  }

  @override
  void sendLints() {
    // TODO: implement sendLints
  }
}
