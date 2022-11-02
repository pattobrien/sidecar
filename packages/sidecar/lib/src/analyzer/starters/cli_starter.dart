// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer_plugin/src/channel/isolate_channel.dart';
import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../rules/rules.dart';
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
  final channel = PluginIsolateChannel(sendPort);
  final logDelegate = DebuggerLogDelegate(cliOptions);
  logger.onRecord.listen((event) {
    logDelegate.sidecarMessage(event.message);
  });
  await runZonedGuarded<Future<void>>(
    () async {
      final container = ProviderContainer(
        overrides: [
          masterPluginChannelProvider.overrideWithValue(channel),
          ruleConstructorProvider.overrideWithValue(constructors ?? []),
          cliOptionsProvider.overrideWithValue(cliOptions),
          logDelegateProvider.overrideWithValue(logDelegate),
        ],
        observers: [
          // CliObserver(cliOptions),
        ],
      );

      try {
        final plugin = container.read(pluginProvider);
        plugin.start(channel);
        final runner = container.read(runnerProvider);
        await runner.initialize();
        logDelegate.dumpResults();
        print('mode: ${cliOptions.mode}');
        if (cliOptions.mode.isCli) {
          channel.close();
          exit(0);
        }
      } catch (error, stackTrace) {
        logDelegate.sidecarError(error, stackTrace);
      }
    },
    logDelegate.sidecarError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => logDelegate.sidecarMessage(line),
    ),
  );
}
