import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';
import 'package:sidecar/sidecar.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  args.add('--instrumentation-log-file=sidecar_logs.txt');

  await startSidecarPlugin(
      sendPort, args, true, codeEditConstructors, lintRuleConstructors,
      isMiddleman: true);
}

Map<Id, CodeEditConstructor> codeEditConstructors = {
  // CreateTextEditControllerProvider.new
};
Map<Id, LintRuleConstructor> lintRuleConstructors = {
  // CreateTextEditControllerProvider.new
};
