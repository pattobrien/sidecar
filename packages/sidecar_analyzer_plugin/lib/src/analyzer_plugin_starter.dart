import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/src/log_delegate.dart';
import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'code_edit_constructors.dart';
import 'lint_rule_constructors.dart';

Future<void> start(List<String> args, SendPort sendPort) async {
  print('start');
  LogDelegate delegate;
  if (args.contains('release')) {
    delegate = DebuggerLogDelegate();
  } else {
    delegate = DebuggerLogDelegate();
  }
  final plugin = SidecarAnalyzerPlugin(
    lintRuleConstructors: lintRuleConstructors,
    codeEditConstructors: codeEditConstructors,
    delegate: delegate,
  );
  startSidecarPlugin(sendPort, plugin);
}
