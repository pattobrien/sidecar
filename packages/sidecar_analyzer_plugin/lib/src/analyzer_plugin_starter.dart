import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'code_edit_constructors.dart';
import 'lint_rule_constructors.dart';

Future<void> start(List<String> args, SendPort sendPort) async {
  LogDelegate delegate;
  bool isDebugMode;
  if (args.contains('--debug')) {
    delegate = DebuggerLogDelegate();
    isDebugMode = true;
  } else {
    delegate = EmptyDelegate();
    isDebugMode = false;
  }
  final plugin = SidecarAnalyzerPlugin(
    lintRuleConstructors: lintRuleConstructors,
    codeEditConstructors: codeEditConstructors,
    delegate: delegate,
  );
  startSidecarPlugin(sendPort, plugin, isDebugMode: isDebugMode);
}
