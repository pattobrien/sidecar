import 'dart:io';

import 'package:sidecar/sidecar.dart';
import 'package:path/path.dart' as p;

abstract class LogDelegate {
  void sidecarError(
    Object error,
    StackTrace stackTrace,
  );

  void sidecarVerboseMessage(
    String message,
  );

  void sidecarMessage(
    String message,
  );

  void pluginInitializationFail(
    Object err,
    StackTrace stackTrace,
  );

  void lintMessage(
    DetectedLint lint,
    String message,
  );

  void editMessage(
    CodeEdit edit,
    String message,
  );

  void pluginRestart();

  void lintError(
    LintRule lint,
    Object err,
    String stackTrace,
  );
}

class DebuggerLogDelegate implements LogDelegate {
  const DebuggerLogDelegate();
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
    final lintId = '[${lint.rule.packageName}] ${lint.rule.code}';

    final relativePath =
        p.relative(lint.unit.path, from: Directory.current.path);

    final sourceLocation =
        '$relativePath:${lint.sourceSpan.start.line}:${lint.sourceSpan.start.column}';

    // final msg = message
    //     .split('\n')
    //     .map((e) => e.isEmpty ? '$label\n' : '$label $e\n')
    //     .join();

    stdout.writeln('$lintId | ${lint.rule.message}    $sourceLocation');
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    // print('DebuggerLogDelegate: sidecarError $error');
    stderr.writeln('DebuggerLogDelegate: $error\n$stackTrace');
  }

  @override
  void sidecarVerboseMessage(String message) {
    // print('DebuggerLogDelegate: sidecarMessage $message');
    // stdout.writeln('DebuggerLogDelegate: $message');
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
}

class EmptyDelegate implements LogDelegate {
  const EmptyDelegate();

  @override
  void editMessage(CodeEdit edit, String message) {
    // do nothing
  }

  @override
  void lintError(LintRule lint, Object err, String stackTrace) {
    // do nothing
  }

  @override
  void lintMessage(DetectedLint lint, String message) {
    // do nothing
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    // do nothing
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    // do nothing
  }

  @override
  void sidecarVerboseMessage(String message) {
    // do nothing
  }

  @override
  void pluginRestart() {
    // TODO: implement pluginRestart
  }

  @override
  void sidecarMessage(String message) {
    // TODO: implement sidecarMessage
  }
}
