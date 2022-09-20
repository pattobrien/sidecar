import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'code_edit_constructors.dart';
import 'lint_rule_constructors.dart';

Future<void> start(List<String> args, SendPort sendPort, bool isPlugin) async {
  LogDelegate delegate;
  SidecarAnalyzerPluginMode mode;
  if (args.contains('--debug')) {
    delegate = DebuggerLogDelegate();
    mode = SidecarAnalyzerPluginMode.debug;
  } else if (isPlugin) {
    delegate = EmptyDelegate();
    mode = SidecarAnalyzerPluginMode.plugin;
  } else {
    delegate = DebuggerLogDelegate();
    mode = SidecarAnalyzerPluginMode.cli;
  }
  final plugin = SidecarAnalyzerPlugin(
    lintRuleConstructors: lintRuleConstructors,
    codeEditConstructors: codeEditConstructors,
    delegate: delegate,
    mode: mode,
  );
  await startSidecarPlugin(sendPort, plugin, mode: mode);
}
