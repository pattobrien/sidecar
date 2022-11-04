// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:hotreloader/hotreloader.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../rules/rules.dart';
import '../../services/active_project_service.dart';
import '../../utils/logger/logger.dart';
import '../options_provider.dart';
import '../plugin/plugin.dart';
import '../server/log_delegate.dart';
import '../server/runner/context_providers.dart';
import '../server/runner/runner_providers.dart';
import '../server/server.dart';

Future<void> startSidecarCli(
  SendPort sendPort,
  List<String> args, {
  List<SidecarBaseConstructor>? constructors,
}) async {
  final cliOptions = CliOptions.fromArgs(args, isPlugin: false);
  final logDelegate = DebuggerLogDelegate(cliOptions);
  logger.onRecord.listen((event) {
    logDelegate.sidecarMessage(event.message);
  });
  await runZonedGuarded<Future<void>>(
    () async {
      final container = ProviderContainer(
        overrides: [
          // masterPluginChannelProvider.overrideWithValue(channel),
          ruleConstructorProvider.overrideWithValue(constructors ?? []),
          cliOptionsProvider.overrideWithValue(cliOptions),
          logDelegateProvider.overrideWithValue(logDelegate),
        ],
        observers: [
          // CliObserver(cliOptions),
        ],
      );

      try {
        final service = container.read(activeProjectServiceProvider);
        final path = Directory.current.path;
        final activeContexts = service.getActiveContextsFromPath([path]);
        final runners = await container.read(newRunnerProvider.future);
        logDelegate.dumpResults();
        print('mode: ${cliOptions.mode}');
        if (cliOptions.mode.isCli) {
          // channel.close();
          exit(0);
        }
        if (cliOptions.mode.isDebug) {
          hierarchicalLoggingEnabled = true;
          HotReloader.logLevel = Level.OFF;
          final hotReloader = await HotReloader.create(
            onAfterReload: (c) {
              print('\n${DateTime.now().toIso8601String()} RELOADING...\n');

              // print(c.events?.map((e) => e.path));
              final targetDirectory = container.read(activeRunnerDirectory);
              final events = c.events ?? [];
              // TODO: check for any changes to lint rules
              // if (events.any((event) => event.path))
              for (final event in events) {
                if (isWithin(targetDirectory.path, event.path)) {
                  // print('reanalyzing: ${event.path}');
                  final filePath = event.path;
                  runners.forEach((runner) {
                    runner.requestLintsForFile(filePath);
                  });
                }
              }
            },
          );
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
