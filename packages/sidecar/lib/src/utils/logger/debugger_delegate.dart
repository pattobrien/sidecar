import 'dart:io';

import 'package:cli_util/cli_logging.dart';
import 'package:path/path.dart' as p;

import '../../analyzer/results/results.dart';
import '../../analyzer/server/analyzer_mode.dart';
import '../../cli/options/cli_options.dart';
import '../../protocol/models/models.dart';
import '../../rules/rules.dart';
import 'logger.dart';

class DebuggerLogDelegate implements LogDelegateBase {
  DebuggerLogDelegate(this.cliOptions)
      : watch = Stopwatch()..start(),
        buffer = StringBuffer();

  final CliOptions cliOptions;
  final Stopwatch watch;
  final StringBuffer buffer;

  @override
  void analysisResultError(LintResult result, Object err, StackTrace stack) {
    stderr.writeln('analysisResultError: $err \n$stack');
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
    // if (!cliOptions.isVerboseEnabled) return;
    stdout.writeln('${watch.elapsed} $message');
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
  void analysisResults(String path, List<LintResult> results) {
    if (results.isEmpty) return;
    final stringBuffer = StringBuffer();

    final relativePath = p.relative(path, from: Directory.current.path);

    for (final result in results) {
      final ansi = Ansi(true);
      final location =
          '$relativePath:${result.span.start.line}:${result.span.start.column}';

      // pad error type string so that it aligns in the terminal nicely
      // we need to do this manually (as opposed to using String.padLeft()),
      // because of the extra characters introduced by ansi
      var lintErrorType = '';
      switch (result.severity) {
        case LintSeverity.info:
          lintErrorType = '   ${result.severity.ansi}';
          break;
        case LintSeverity.warning:
          lintErrorType = result.severity.ansi;
          break;
        case LintSeverity.error:
          lintErrorType = '  ${result.severity.ansi}';
          break;
      }
      final packageId = '${ansi.green}${result.rule.packageName}${ansi.none}';
      final lintCode = '${ansi.green}${result.rule.code}${ansi.none}';
      final message = '${ansi.bold}${result.message}${ansi.none}';
      final correction = result.correction;
      stringBuffer.writeln(
          '  $lintErrorType • $location • $message $correction • $packageId.$lintCode');
    }

    if (cliOptions.mode.isDebug) {
      stdout.write(stringBuffer.toString());
    } else {
      buffer.write(stringBuffer.toString());
      buffer.writeln();
    }
  }

  void dumpResults() {
    logger.info('\n\n${buffer.toString()}');
  }
}
