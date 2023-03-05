import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../client/cli_client.dart';
import '../../client/client.dart';
import '../../client/hot_reloader.dart';
import '../../reports/stdout_reporter.dart';

/// Run Sidecar from CLI or Debugger.
Future<void> startSidecarCli(
  SendPort sendPort,
  List<String> args,
) async {
  final isDebug = args.any((arg) => arg == 'debug' || arg == '--debug');
  final container = ProviderContainer(overrides: [
    analyzerClientProvider.overrideWithProvider(cliClientProvider),
  ]);
  await runZonedGuarded<Future<void>>(
    () async {
      final client = container.read(analyzerClientProvider);
      final reporter = container.read(stdoutReportProvider);
      await client.openWorkspace();
      final hasErrors = reporter.hasErrors;
      reporter.print();

      if (!isDebug) {
        client.closeWorkspace();
        hasErrors ? stdout.writeln('exiting with 1') : stdout.writeln('0');
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
