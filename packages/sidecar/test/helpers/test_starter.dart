import 'dart:async';
import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/analyzer/client/cli_client.dart';
import 'package:sidecar/src/analyzer/client/client.dart';
import 'package:sidecar/src/analyzer/starters/cli_starter.dart';
import 'package:sidecar/src/reports/stdout_reporter.dart';

late ProviderContainer container;

Future<AnalyzerClient> analyzeTestResources(
  Uri root,
  StdoutReporter reporter,
) async {
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
      // client.closeWorkspace();
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
  try {
    process = await Process.start(
      'dart',
      ['pub', 'get'],
      workingDirectory: root.path,
    );
  } catch (e, stack) {
    //
    print('pub get failed: $e $stack');
  }
  return process?.exitCode ?? Future.value(1);
  // process.stdout.listen((event) => stdout.add(event));
}
