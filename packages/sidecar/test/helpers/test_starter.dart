import 'dart:async';
import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/client/cli_client.dart';
import 'package:sidecar/src/client/client.dart';
import 'package:sidecar/src/reports/stdout_reporter.dart';
import 'package:sidecar/src/server/starters/cli_starter.dart';
import 'package:test/scaffolding.dart';

late ProviderContainer container;

Future<AnalyzerClient> analyzeTestResources(
  Uri root,
  StdoutReporter reporter,
) async {
  final testPath = root.toFilePath();
  container = ProviderContainer(overrides: [
    analyzerClientProvider.overrideWithProvider(cliClientProvider),
    cliDirectoryProvider.overrideWithValue(root),
    stdoutReportProvider.overrideWithValue(reporter),
  ]);
  final client = await runZoned<Future<AnalyzerClient>>(
    () async {
      await runPubGet(root);
      final client = container.read(cliClientProvider);
      await client.openWorkspace();
      addTearDown(client.closeWorkspace);
      return client;
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => stdout.writeln(line),
    ),
  );
  return client;
}

Future<int> runPubGet(Uri root) async {
  Process? process;
  // try {
  process = await Process.start(
    'dart',
    ['pub', 'get', '--offline'],
    workingDirectory: root.toFilePath(),
  );
  // } catch (e, stack) {
  //   //
  //   print('pub get failed: $e $stack');
  // }
  process.stdout.listen((event) => stdout.add(event));
  return process.exitCode;
}
