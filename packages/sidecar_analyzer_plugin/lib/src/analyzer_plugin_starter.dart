import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'code_edit_constructors.dart';
import 'lint_rule_constructors.dart';

void start(List<String> args, SendPort sendPort) async {
  final plugin = SidecarAnalyzerPlugin(
    lintRuleConstructors: lintRuleConstructors,
    codeEditConstructors: codeEditConstructors,
  );
  startSidecarPlugin(sendPort, plugin);
}
