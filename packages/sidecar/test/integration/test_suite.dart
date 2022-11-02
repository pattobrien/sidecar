// ignore_for_file: overridden_fields, implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/instrumentation/noop_service.dart';
import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:analyzer/src/test_utilities/resource_provider_mixin.dart';
import 'package:cli_util/cli_util.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';

import 'package:sidecar/sidecar.dart';
import 'package:sidecar/src/analyzer/options_provider.dart';
import 'package:sidecar/src/analyzer/plugin/plugin.dart';
import 'package:sidecar/src/analyzer/server/log_delegate.dart';
import 'package:sidecar/src/analyzer/server/runner/notification_providers.dart';
import 'package:sidecar/src/analyzer/server/runner/runner.dart';
import 'package:sidecar/src/analyzer/server/server.dart';
import 'package:sidecar/src/cli/options/cli_options.dart';
import 'package:sidecar/src/test/assets/project_creator.dart';
import 'package:sidecar/src/test/project_notifier.dart';
import 'package:sidecar/src/test/test_suite.dart';
import 'package:sidecar/src/utils/logger/cli_observer.dart';
import 'package:sidecar/src/utils/logger/logger.dart';

import 'string_lint.dart';

// TEST CASES:
// given a project with a dependency on another project
// expect that both projects will be analyzed

final _ruleConstructorProvider =
    Provider<List<SidecarBaseConstructor>>((ref) => [AvoidStringLiterals.new]);

void main() async {
  final cliOptions = CliOptions.fromArgs(['--cli'], isPlugin: false);
  // final receivePort = ReceivePort('sidecar receivePort');
  // receivePort.listen((dynamic message) => print(message.toString()));
  // final channel = PluginIsolateChannel(receivePort.sendPort);
  final logDelegate = DebuggerLogDelegate(cliOptions);
  logger.onRecord.listen((event) {
    logDelegate.sidecarMessage(event.message);
  });

  final resourceProvider = MemoryResourceProvider();
  final testSuite = TestSuite(resourceProvider);
  final creator = ProjectCreator(
      parentDirectoryPath: testSuite.workspace.path,
      resourceProvider: resourceProvider,
      projectName: 'my_app');
  final dep = Uri.parse(join(testSuite.workspace.path, 'packages'));

  final container = ProviderContainer(
    overrides: [
      // masterPluginChannelProvider.overrideWithValue(channel),
      // masterServerChannel.overrideWithValue(serverChannel),
      activeRunnerDirectory.overrideWithValue(
          Directory(canonicalize('../../examples/my_analyzed_codebase'))),
      ruleConstructorProvider.overrideWithProvider(_ruleConstructorProvider),
      cliOptionsProvider.overrideWithValue(cliOptions),
      logDelegateProvider.overrideWithValue(logDelegate),
    ],
    observers: [
      // CliObserver(cliOptions),
    ],
  );
  final newProject =
      container.read(projectNotifierProvider('my_app', testSuite.workspace));

  // final collection = AnalysisContextCollection(
  //   includedPaths: [testSuite.workspace.path],
  //   resourceProvider: testSuite.resourceProvider,
  //   sdkPath: testSuite.sdk.path,
  // );
  // print(collection.contexts.length);
  // print(collection.contexts.first.contextRoot.root.path);

  final mainRelativePath = join('lib', 'main.dart');
  newProject.modifyFile(mainRelativePath, mainContent);
  final mainFile = newProject.getFile(mainRelativePath);

  print('starting...');
  final runner = container.read(runnerProvider);
  await runner.initialize();
  // final middleman = container.read(middlemanPluginProvider);
  // middleman.start(channel);
  // middleman.;

  // final plugin = container.read(pluginProvider);
  // plugin.start(channel);
  // await plugin.initializationCompleter.future;
  print('done');
  exit(0);
  // final errors = await runner.requestAnalysisForFile(mainFile);

  // print('# of errors: ${errors.length}');
  // runner.server.analyzeFile(analysisContext: analysisContext, path: path);
  // final results = await container.read(analysisResultsForFileProvider().future);
  // print('done: ${results.length}');
}

const mainContent = '''
void main() {
  final abc = 'string value';
}
''';
