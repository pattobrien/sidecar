import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'code_edit_constructors.dart';
import 'lint_rule_constructors.dart';

Future<void> start(List<String> args, SendPort sendPort, bool isPlugin) async {
  await startSidecarPlugin(
    sendPort,
    args,
    isPlugin,
    codeEditConstructors,
    lintRuleConstructors,
  );
}
