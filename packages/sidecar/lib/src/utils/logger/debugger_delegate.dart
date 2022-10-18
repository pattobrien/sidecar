import 'dart:io';

import 'package:characters/characters.dart';
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
      final location =
          '$relativePath:${result.sourceSpan.start.line}:${result.sourceSpan.start.column}';
      final lintErrorType = (result.rule as LintRule).defaultType.ansi;
      final packageId =
          result.rule.packageName.padRight(20).characters.take(20);
      final lintCode = result.rule.code.padRight(20).characters.take(20);
      final message = result.message.padRight(40).characters.take(40);
      final time = DateTime.now().toIso8601String();
      stringBuffer.writeln(
          '  • $location • $lintErrorType • $message • $packageId • $lintCode');
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
