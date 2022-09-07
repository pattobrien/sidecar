import 'dart:isolate';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/starter.dart';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'plugin_bootstrapper.dart';
import 'plugin_code_edit_bootstrapper.dart';
import 'analyzer_plugin.dart';

void start(
  List<String> args,
  SendPort sendPort,
  // List<LintError> allLints,
  // List<CodeEdit> allCodeEdits,
  // NodeLintRegistry nodeRegistry,
  // ProviderContainer ref,
) async {
  final resourceProvider = PhysicalResourceProvider.INSTANCE;
  final ref = ProviderContainer();
  final nodeRegistry = NodeLintRegistry();
  final allLints = pluginBootstrapper(nodeRegistry, ref);
  final allCodeEdits = pluginCodeFixBootstrapper(ref);

  final plugin = SidecarAnalyzerPlugin(
    resourceProvider: resourceProvider,
    ref: ref,
    nodeRegistry: nodeRegistry,
    allLints: allLints,
    allCodeEdits: allCodeEdits,
  );

  ServerPluginStarter(plugin).start(sendPort);
}
