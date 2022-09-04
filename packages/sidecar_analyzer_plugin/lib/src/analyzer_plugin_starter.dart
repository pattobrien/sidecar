import 'dart:isolate';

import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/starter.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'analyzer_plugin.dart';

void start(
  List<String> args,
  SendPort sendPort,
  List<LintError> allLints,
  List<CodeEdit> allCodeEdits,
  NodeLintRegistry nodeRegistry,
  ProviderContainer ref,
) async {
  final resourceProvider = PhysicalResourceProvider.INSTANCE;

  final plugin = SidecarAnalyzerPlugin(
    resourceProvider: resourceProvider,
    ref: ref,
    nodeRegistry: nodeRegistry,
    allLints: allLints,
    allCodeEdits: allCodeEdits,
  );

  ServerPluginStarter(plugin).start(sendPort);
}
