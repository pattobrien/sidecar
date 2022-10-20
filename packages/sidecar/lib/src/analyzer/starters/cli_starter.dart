// ignore_for_file: implementation_imports

import 'dart:io';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../rules/rules.dart';
import '../../utils/logger/cli_observer.dart';
import '../../utils/logger/logger.dart';
import '../options_provider.dart';
import '../plugin/plugin.dart';
import '../server/log_delegate.dart';
import '../server/runner/runner.dart';
import '../server/server.dart';

Future<void> startSidecarCli(
  SendPort sendPort,
  List<String> args, {
  List<SidecarBaseConstructor>? constructors,
}) async {
  final cliOptions = CliOptions.fromArgs(args, isPlugin: false);

  final logger = DebuggerLogDelegate(cliOptions);

  final container = ProviderContainer(
    overrides: [
      // masterPluginChannelProvider.overrideWithValue(pluginChannel),
      ruleConstructorProvider.overrideWithValue(constructors ?? []),
      cliOptionsProvider.overrideWithValue(cliOptions),
      logDelegateProvider.overrideWithValue(logger),
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
