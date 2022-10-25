import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:benchmarks/benchmarks.dart' as benchmarks;
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'package:sidecar/src/analyzer/context/context.dart';
import 'package:sidecar/src/analyzer/plugin/plugin.dart';
import 'package:sidecar/src/analyzer/server/runner/runner.dart';
import 'package:sidecar/src/analyzer/server/log_delegate.dart';
import 'package:sidecar/src/cli/options/cli_options.dart';
import 'package:sidecar/src/analyzer/options_provider.dart';
import 'package:sidecar/src/utils/logger/logger.dart';
import 'package:sidecar/src/utils/logger/cli_observer.dart';
import 'package:sidecar/src/analyzer/server/analyzer_mode.dart';

import 'package:design_system_lints/design_system_lints.dart'
    as design_system_lints;

void main(List<String> arguments) async {
  final rootDirectory =
      Directory(p.join(Directory.current.path, 'assets', 'counter_app'));

  await benchmarkStartup(
      [
        design_system_lints.AvoidIconLiteral.new,
      ],
      rootDirectory,
      ['cli']);
  // final resourceProvider = PhysicalResourceProvider.INSTANCE;
  // final collection = AnalysisContextCollection(
  //   includedPaths: [rootDirectory.path],
  //   resourceProvider: resourceProvider,
  // );
  // final context = collection.contexts.single;
  // await Future.wait(context.contextRoot.analyzedFiles().map((file) async {
  //   final unit = await context.currentSession.getResolvedUnit(file);
  //   print(file);
  // }));

  // container
  //     .read(allAnalysisContextsProvider.state)
  //     .update((_) => collection.contexts);

  // final activeContexts = container.read(activeContextsProvider);
  // await Future.wait(activeContexts.map((context) async {
  //   await Future.wait(context.activeRoot.typedAnalyzedFiles().map((file) async {
  //     // final unit = await e.currentSession.getResolvedUnit(file);
  //     await container.read(resolvedUnitProvider(file).future);
  //     print(file);
  //   }));
  // }));
  // print('done');
}

Future<void> benchmarkStartup(
  List<SidecarBaseConstructor> constructors,
  Directory rootDirectory,
  List<String> args,
) async {
  final cliOptions = CliOptions.fromArgs(args, isPlugin: false);

  final logger = DebuggerLogDelegate(cliOptions);

  final container = ProviderContainer(
    overrides: [
      // masterPluginChannelProvider.overrideWithValue(pluginChannel),
      ruleConstructorProvider.overrideWithValue(constructors),
      cliOptionsProvider.overrideWithValue(cliOptions),
      logDelegateProvider.overrideWithValue(logger),
      activeRunnerDirectory.overrideWithValue(rootDirectory),
    ],
    observers: [CliObserver(cliOptions)],
  );

  try {
    final runner = container.read(runnerProvider);
    await runner.initialize();
    logger.dumpResults();
    if (cliOptions.mode.isCli) exit(0);
  } catch (error, stackTrace) {
    logger.sidecarError(error, stackTrace);
  }
}
