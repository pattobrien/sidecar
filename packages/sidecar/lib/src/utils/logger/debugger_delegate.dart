import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;

import '../../analyzer/results/results.dart';
import '../../cli/options/cli_options.dart';
import '../../cli/reports/file_stats.dart';
import '../../rules/rules.dart';
import 'log_delegate_base.dart';

class DebuggerLogDelegate implements LogDelegateBase {
  const DebuggerLogDelegate({
    required this.cliOptions,
  });

  final CliOptions cliOptions;

  @override
  void analysisResultError(
      AnalysisResult result, Object err, StackTrace stackTrace) {
    stderr.writeln('analysisResultError: $err \n$stackTrace');
  }

  @override
  void pluginInitializationFail(Object err, StackTrace stackTrace) {
    stderr.writeln('pluginInitializationFail: $err\n$stackTrace');
  }

  @override
  void sidecarError(Object error, StackTrace stackTrace) {
    stderr.writeln('sidecarError: $error\n$stackTrace');
  }

  @override
  void sidecarVerboseMessage(String message) {
    if (!cliOptions.isVerboseEnabled) return;
    stdout.writeln(message);
  }

  @override
  void pluginRestart() {
    stdout.writeln('pluginRestart');
  }

  @override
  void sidecarMessage(String message) {
    stdout.writeln(message);
  }

  @override
  void analysisResults(String path, List<AnalysisResult> results) {
    if (results.isEmpty) return;
    final stringBuffer = StringBuffer();

    final relativePath = p.relative(path, from: Directory.current.path);

    for (final result in results.where((result) => result.rule is LintRule)) {
      final ansi = Ansi(true);
      final location =
          '$relativePath:${result.sourceSpan.start.line}:${result.sourceSpan.start.column}';
      final lintErrorType =
          (result.rule as LintRule).defaultType.ansi.padLeft(7);
      final packageId = '${ansi.green}${result.rule.packageName}${ansi.none}';
      final lintCode = '${ansi.green}${result.rule.code}${ansi.none}';
      final message = '${ansi.bold}${result.message}${ansi.none}';
      final correction = result.correction ?? '';
      final time = DateTime.now().toIso8601String();
      stringBuffer.writeln(
          '  $lintErrorType • $location • $message $correction • $packageId.$lintCode');
    }
    stdout.write(stringBuffer.toString());
  }

  @override
  void generateReport(Iterable<FileStats> reports) {
    for (final report in reports) {
      stdout.write('${report.toOutput()}\n');
    }
  }
}
