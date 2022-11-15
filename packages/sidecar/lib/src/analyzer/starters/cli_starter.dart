import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../reports/stdout_report.dart';
import '../client/cli_client.dart';
import '../client/client.dart';
import '../client/hot_reloader.dart';
import '../server/server.dart';

Future<void> startSidecarCli(
  SendPort sendPort,
  List<String> args,
) async {
  final cliOptions = CliOptions.fromArgs(args, isPlugin: false);
  final container = ProviderContainer(overrides: [
    analyzerClientProvider.overrideWithProvider(cliClientProvider),
  ]);
  await runZonedGuarded<Future<void>>(
    () async {
      final client = container.read(analyzerClientProvider);
      await client.openWorkspace();
      client.closeWorkspace();

      if (cliOptions.mode.isCli) exit(0);
      if (cliOptions.mode.isDebug) {
        await container.read(hotReloaderProvider.future);
      }
    },
    container.read(stdoutReportProvider).handleError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => stdout.writeln(line),
    ),
  );
}
