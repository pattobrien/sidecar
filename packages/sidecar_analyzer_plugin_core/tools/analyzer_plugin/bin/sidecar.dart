import 'dart:isolate';

import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';
import 'package:sidecar/sidecar.dart';
import 'package:design_system_lints/design_system_lints.dart';

Future<void> main(List<String> args, SendPort sendPort) async {
  args.add('--instrumentation-log-file=sidecar_logs.txt');

  await startSidecarPlugin(
      sendPort, args, true, codeEditConstructors, lintRuleConstructors,
      isMiddleman: false);
}

Map<Id, CodeEditConstructor> codeEditConstructors = {
  // CreateTextEditControllerProvider.new
};
Map<Id, LintRuleConstructor> lintRuleConstructors = {
  // CreateTextEditControllerProvider.new
  Id(
    type: IdType.lintRule,
    id: 'avoid_icon_literal',
    packageId: 'design_system_lints',
  ): AvoidIconLiteral.new,
  Id(
    type: IdType.lintRule,
    id: 'avoid_edge_insets_literal',
    packageId: 'design_system_lints',
  ): AvoidEdgeInsetsLiteral.new,
};
