import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'code_edit_constructors.dart';
import 'lint_rule_constructors.dart';

Future<void> start(List<String> args, SendPort sendPort) async {
  LogDelegate delegate;
  bool isDebugMode;
  SidecarAnalyzerPluginMode mode;
  if (args.contains('--debug')) {
    delegate = DebuggerLogDelegate();
    isDebugMode = true;
    mode = SidecarAnalyzerPluginMode.debug;
  } else {
    delegate = EmptyDelegate();
    isDebugMode = false;
    mode = SidecarAnalyzerPluginMode.plugin;
  }
  final plugin = SidecarAnalyzerPlugin(
    lintRuleConstructors: lintRuleConstructors,
    codeEditConstructors: codeEditConstructors,
    delegate: delegate,
    mode: mode,
  );
  startSidecarPlugin(sendPort, plugin, isDebugMode: isDebugMode);
}
