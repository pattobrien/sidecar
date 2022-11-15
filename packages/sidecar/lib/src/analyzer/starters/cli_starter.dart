import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:cli_util/cli_logging.dart';
import 'package:riverpod/riverpod.dart';

import '../../cli/options/cli_options.dart';
import '../../protocol/analyzed_file.dart';
import '../../protocol/models/models.dart';
import '../../utils/duration_ext.dart';
import '../../utils/logger/logger.dart';
import '../../utils/printer/lint_printer.dart';
import '../client/cli_client.dart';
import '../client/client.dart';
import '../client/hot_reloader.dart';
import '../server/server.dart';

Future<void> startSidecarCli(
  SendPort sendPort,
  List<String> args,
) async {
  final progress = Logger.standard().progress('analyzing...');
  final cliOptions = CliOptions.fromArgs(args, isPlugin: false);
  final logDelegate = DebuggerLogDelegate(cliOptions);
  await runZonedGuarded<Future<void>>(
    () async {
      final container = ProviderContainer(overrides: [
        analyzerClientProvider.overrideWithProvider(cliClientProvider),
      ]);

      final client = container.read(analyzerClientProvider);

      await client.openWorkspace();
      printReport(client.lintResults, progress);
      logDelegate.dumpResults();
      if (cliOptions.mode.isCli) exit(0);
      if (cliOptions.mode.isDebug) {
        await container.read(hotReloaderProvider.future);
      }
    },
    logDelegate.sidecarError,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) => stdout.writeln(line),
    ),
  );
}

void printReport(
  Map<AnalyzedFile, Set<LintResult>> results,
  Progress timer,
) {
  final stringBuffer = StringBuffer();

  // stringBuffer.writeln();
  // stringBuffer.writeln('project:\u001b[35m ${root.toFilePath()} \u001b[0m');
  // stringBuffer.writeln('plugin:  ${pluginPackage.root.toFilePath()}');
  // stringBuffer.writeln();

  for (final resultEntry in results.entries) {
    final lintResults = resultEntry.value;
    final relativePath = resultEntry.key.relativePath;

    if (lintResults.isNotEmpty) {
      stringBuffer.writeln('$relativePath: ${lintResults.length} results\n');
      stringBuffer.writeln(lintResults.toList().prettyPrint());
    }
  }
  timer.finish();
  stringBuffer.writeln('analysis completed in:  ${timer.elapsed.prettified()}');
  stdout.writeln();
  stdout.write(stringBuffer.toString());
}
