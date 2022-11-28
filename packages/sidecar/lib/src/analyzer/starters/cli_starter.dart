import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../reports/stdout_reporter.dart';
import '../client/cli_client.dart';
import '../client/client.dart';
import '../client/hot_reloader.dart';

/// Run Sidecar from CLI or Debugger.
Future<void> startSidecarCli(
  SendPort sendPort,
  List<String> args,
) async {
  final isDebug = args.any((arg) => arg == 'debug' || arg == '--debug');
  final container = ProviderContainer(overrides: [
    analyzerClientProvider.overrideWith((ref) => ref.watch(cliClientProvider)),
  ]);
  await runZonedGuarded<Future<void>>(
    () async {
      final client = container.read(analyzerClientProvider);
      await client.openWorkspace();

      if (!isDebug) {
        client.closeWorkspace();
        exit(0);
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
