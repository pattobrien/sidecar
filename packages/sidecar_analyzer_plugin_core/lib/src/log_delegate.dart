import 'dart:io';

import 'package:sidecar/sidecar.dart';

abstract class LogDelegate {
  void sidecarError(
    Object error,
    StackTrace stackTrace,
  );

  void sidecarMessage(
    String message,
  );

  void pluginInitializationFail(
    Object err,
    StackTrace stackTrace,
  );

  void lintMessage(
    LintRule lint,
    String message,
  );

  void editMessage(
    CodeEdit edit,
    String message,
  );

  void lintError(
    LintRule lint,
    String err,
    String stackTrace,
  );
}

class DebuggerLogDelegate implements LogDelegate {
  const DebuggerLogDelegate();
  @override
  void lintError(LintRule lint, String err, String stackTrace) {
    // print('DebuggerLogDelegate: lintError');
    stderr.writeln('DebuggerLogDelegate: $err\n$stackTrace');
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    // print('DebuggerLogDelegate: pluginInitializationFail $err');
    stderr.writeln('DebuggerLogDelegate: $err\n$stackTrace');
  }

  @override
  void lintMessage(LintRule lint, String message) {
    // print('DebuggerLogDelegate: lintMessage ${lint.code} $message');
    final label = '[${lint.packageName}.${lint.code}]';

    final msg = message
        .split('\n')
        .map((e) => e.isEmpty ? '$label\n' : '$label $e\n')
        .join();

    stdout.write('DebuggerLogDelegate: LintRule $msg');
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    // print('DebuggerLogDelegate: sidecarError $error');
    stderr.writeln('DebuggerLogDelegate: $error\n$stackTrace');
  }

  @override
  void sidecarMessage(String message) {
    // print('DebuggerLogDelegate: sidecarMessage $message');
    stdout.writeln('DebuggerLogDelegate: $message');
  }

  @override
  void editMessage(CodeEdit edit, String message) {
    final label = '[${edit.packageName}.${edit.code}]';

    final msg = message
        .split('\n')
        .map((e) => e.isEmpty ? '$label\n' : '$label $e\n')
        .join();

    stdout.write('DebuggerLogDelegate: CodeEdit $msg');
  }
}

class EmptyDelegate implements LogDelegate {
  const EmptyDelegate();

  @override
  void editMessage(CodeEdit edit, String message) {
    // do nothing
  }

  @override
  void lintError(LintRule lint, String err, String stackTrace) {
    // do nothing
  }

  @override
  void lintMessage(LintRule lint, String message) {
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
  void sidecarMessage(String message) {
    // do nothing
  }
}
