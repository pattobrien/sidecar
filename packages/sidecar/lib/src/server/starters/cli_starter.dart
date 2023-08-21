import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../client/cli_client.dart';
import '../../client/client.dart';
import '../../client/hot_reloader.dart';
import '../../reports/reporter.dart';
import '../../reports/stdout_reporter.dart';

/// Run Sidecar from CLI or Debugger.
Future<void> startSidecarCli(
  SendPort sendPort,
  List<String> args, {
  bool isStrictMode = false,
}) async {
  final isDebug = args.any((arg) => arg == 'debug' || arg == '--debug');
  final _reporterProvider = stdoutReportProvider;
  final container = ProviderContainer(overrides: [
    analyzerClientProvider.overrideWithProvider(cliClientProvider),
    reporterProvider.overrideWithProvider(_reporterProvider),
  ]);
  await runZonedGuarded<Future<void>>(
    () async {
      final client = container.read(analyzerClientProvider);
      final reporter = container.read(reporterProvider);
      await client.openWorkspace();
      final hasErrors = reporter.hasErrors(isStrictMode: isStrictMode);
      reporter.print();

      if (!isDebug) {
        client.closeWorkspace();
        hasErrors
            ? stdout.writeln('Lints found; exiting with 1')
            : stdout.writeln('Exiting with 0');
        hasErrors ? exit(1) : exit(0);
      }

      await container.read(hotReloaderProvider.future);
    },
    container.read(stdoutReportProvider).handleError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => stdout.writeln(line),
    ),
  );
}

final cliDirectoryProvider = Provider<Uri>((ref) => Directory.current.uri);
