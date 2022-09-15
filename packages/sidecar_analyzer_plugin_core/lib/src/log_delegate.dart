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
    print('lintError');
    stderr.writeln('$err\n$stackTrace');
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    print('pluginInitializationFail');
    stderr.writeln('$err\n$stackTrace');
  }

  @override
  void lintMessage(LintRule lint, String message) {
    print('lintMessage');
    final label = '[${lint.packageName}.${lint.code}]';

    final msg = message
        .split('\n')
        .map((e) => e.isEmpty ? '$label\n' : '$label $e\n')
        .join();

    stdout.write(msg);
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    print('sidecarError');
    stderr.writeln('$error\n$stackTrace');
  }

  @override
  void sidecarMessage(String message) {
    print('sidecarMessage');
    stderr.writeln('$message');
  }
}
