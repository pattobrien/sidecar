// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:hotreloader/hotreloader.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../protocol/models/models.dart';
import '../../rules/rules.dart';
import '../../services/active_project_service.dart';
import '../../utils/logger/logger.dart';
import '../../utils/printer/lint_printer.dart';
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
  print('mode: ${cliOptions.mode}\n');
  final logDelegate = DebuggerLogDelegate(cliOptions);
  // logger.onRecord.listen(print);
  await runZonedGuarded<Future<void>>(
    () async {
      final container = ProviderContainer(
        overrides: [
          ruleConstructorProvider.overrideWithValue(constructors ?? []),
          cliOptionsProvider.overrideWithValue(cliOptions),
          logDelegateProvider.overrideWithValue(logDelegate),
        ],
        observers: [
          // CliObserver(cliOptions),
        ],
      );

      try {
        final directory = Directory.current;

        final service = container.read(activeProjectServiceProvider);
        final resourceProvider = container.read(runnerResourceProvider);
        final activeContext = service.initActiveContextFromUri(directory.uri,
            resourceProvider: resourceProvider);

        if (activeContext == null) {
          throw UnimplementedError(
              'This is not a valid Sidecar directory: ${directory.path}');
        }
        container.read(runnerActiveContextsProvider.notifier).update = [
          activeContext
        ];

        //TODO: make the plugin path dynamic
        final pluginUri = activeContext.sidecarPluginPackage.root;
        final runners = container.read(runnersProvider);
        for (final runner in runners) {
          runner.lints.listen((notification) {
            if (notification.lints.isNotEmpty) {
              print(
                  '${notification.file.relativePath}: ${notification.lints.length} results\n');
              print(notification.lints.prettyPrint());
            }
          });
          // runner.logs.listen((event) {
          //   stdout.writeln(event.toString());
          // });
        }
        await container.read(runnersInitializerProvider.future);
        logDelegate.dumpResults();
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
              print('${c.events?.length ?? 0} file changes: ${c.events ?? []}');
              final elements = container.getAllProviderElements();
              final numberOfRunners =
                  elements.where((e) => e.origin == runnersProvider);
              // print('# of active runners: ${numberOfRunners.length}');
              final events = c.events ?? [];
              // TODO: check for any changes to lint rules
              // if (events.any((event) => event.path))

              for (final runner in runners) {
                // print('runner: ${runner.context.activeRoot.root.path}');
                for (final event in events) {
                  // print('event: ${event.path}');
                  final filePath = event.path;
                  final rootPath = runner.context.activeRoot.root.path;
                  if (p.isWithin(rootPath, event.path)) {
                    final file = runner.getAnalyzedFileForPath(filePath);
                    if (file == null) continue;
                    print('reanalyzing: $filePath\n');
                    runner.requestLintsForFile(file);
                  } else if (p.isWithin(pluginUri.path, filePath)) {
                    print(
                        'rebuilding runner: ${runner.context.contextRoot.root.path}\n');

                    // print('activeContexts: ${contextNumber.length}');
                    container.refresh(runnersProvider);
                    break;
                  }
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
      print: (self, parent, zone, line) => stdout.writeln(line),
    ),
  );
}
