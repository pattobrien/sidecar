import 'dart:async';
import 'dart:io';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/src/analyzer/client/cli_client.dart';
import 'package:sidecar/src/analyzer/client/client.dart';
import 'package:sidecar/src/analyzer/starters/cli_starter.dart';
import 'package:sidecar/src/reports/stdout_report.dart';

late ProviderContainer container;

Future<AnalyzerClient> analyzeTestResources(
  Uri root,
  StdoutReport reporter,
) async {
  // final cliOptions = CliOptions.fromArgs(['--cli'], isPlugin: false);
  container = ProviderContainer(overrides: [
    analyzerClientProvider.overrideWithProvider(cliClientProvider),
    cliDirectoryProvider.overrideWithValue(root),
    stdoutReportProvider.overrideWithValue(reporter),
  ]);
  final client = await runZoned<Future<AnalyzerClient>>(
    () async {
      final exitcode = await runPubGet(root);
      if (exitcode != 0) throw StateError('pub get failed');
      final client = container.read(cliClientProvider);
      await client.openWorkspace();
      client.closeWorkspace();
      return client;
    },
    // (e, stack) {
    //   container.read(stdoutReportProvider).handleError(e, stack);
    //   print('does this happen either?');
    //   return null;
    // },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => stdout.writeln(line),
      // handleUncaughtError: (self, parent, zone, error, stackTrace) {
      //   print('handleUncaughtError does this happen');
      //   throw error;
      // },
      // errorCallback: (self, parent, zone, error, stackTrace) {
      //   return null;
      // },
    ),
  );
  print('this doesnt happen');
  return client;
}

Future<int> runPubGet(Uri root) async {
  final process = await Process.start(
    'dart',
    ['pub', 'get'],
    workingDirectory: root.path,
  );
  // process.stdout.listen((event) => stdout.add(event));
  return process.exitCode;
}
