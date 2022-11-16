import 'dart:async';
import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/analyzer/starters/cli_starter.dart';

import '../../reports/stdout_report.dart';
import '../client/cli_client.dart';
import '../client/client.dart';

Future<void> startTestCli(
  Uri root,
  StdoutReport reporter,
) async {
  // final cliOptions = CliOptions.fromArgs(['--cli'], isPlugin: false);
  final container = ProviderContainer(overrides: [
    analyzerClientProvider.overrideWithProvider(cliClientProvider),
    cliDirectoryProvider.overrideWithValue(root),
    stdoutReportProvider.overrideWithValue(reporter),
  ]);
  await runZonedGuarded<Future<void>>(
    () async {
      final client = container.read(cliClientProvider);
      await client.openWorkspace();
      client.closeWorkspace();
      return;
    },
    container.read(stdoutReportProvider).handleError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => stdout.writeln(line),
    ),
  );
}
