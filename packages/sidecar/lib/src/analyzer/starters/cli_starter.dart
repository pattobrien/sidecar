import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:hotreloader/hotreloader.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../protocol/logging/log_record.dart';
import '../../rules/rules.dart';
import '../../services/active_project_service.dart';
import '../../utils/duration_ext.dart';
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
  final logDelegate = DebuggerLogDelegate(cliOptions);
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
        final path = directory.path;

        final service = container.read(activeProjectServiceProvider);
        final collection = AnalysisContextCollection(includedPaths: [path]);
        final context = collection.contextFor(path);
        final activeContext = service.getActivePackageFromContext(context);

        if (activeContext == null) {
          throw StateError('Invalid Sidecar directory: $path');
        }
        container.read(runnerActiveContextsProvider.notifier).update = [
          activeContext
        ];

        final pluginUri = activeContext.sidecarPluginPackage;
        final runners = container.read(runnersProvider);
        for (final runner in runners) {
          runner.lints.listen((event) {
            if (event.lints.isNotEmpty) {
              final numberResults = event.lints.length;
              print('${event.file.relativePath}: $numberResults results\n');
              print(event.lints.toList().prettyPrint());
            }
          });
          runner.logs.listen((event) => print(event.prettified()));
          await runner.initialize();
        }

        logDelegate.dumpResults();
        if (cliOptions.mode.isCli) exit(0);
        if (cliOptions.mode.isDebug) {
          hierarchicalLoggingEnabled = true;
          HotReloader.logLevel = Level.OFF;
          final hotReloader = await HotReloader.create(
            onAfterReload: (c) async {
              final watch = Stopwatch()..start();
              final timestamp = DateTime.now().toIso8601String();
              print('\u001b[31m\n$timestamp RELOADING...\n\u001b[0m');
              final events = c.events ?? [];
              for (final runner in runners) {
                final rootPath = runner.activePackage.root.path;
                for (final event in events) {
                  final filePath = event.path;
                  if (p.isWithin(rootPath, event.path)) {
                    final file = runner.getAnalyzedFile(filePath);
                    if (file == null) continue;

                    await runner.requestLintsForFile(file);
                  } else if (p.isWithin(pluginUri.path, filePath)) {
                    // TODO: refresh runner / analyzer
                    // container.refresh(runnersProvider);
                    // await runner.initialize();
                  }
                }
              }
              print('total time to reload: ${watch.elapsed.prettified()}');
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
