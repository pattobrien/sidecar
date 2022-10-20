// ignore_for_file: implementation_imports

import 'package:analyzer/error/error.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:cli_util/cli_logging.dart';

import '../configurations/configurations.dart';

enum LintRuleType { info, warning, error }

extension LintRuleTypeX on LintRuleType {
  static LintRuleType fromString(String string) {
    if (string == LintRuleType.error.name) {
      return LintRuleType.error;
    }
    if (string == LintRuleType.warning.name) {
      return LintRuleType.warning;
    }
    if (string == LintRuleType.info.name) {
      return LintRuleType.info;
    }
    throw InvalidSeverityException(string);
  }

  // used to colorize CLI output
  String get ansi {
    // final ansi = AnsiPen();
    final ansi = Ansi(true);
    switch (this) {
      case LintRuleType.info:
        // ansi.white(bold: true);
        // return ansi(name);
        return name;
      // return '${ansi.blue}$name${ansi.none}';
      case LintRuleType.warning:
        // ansi.yellow();
        // return ansi(name);
        return '${ansi.yellow}$name${ansi.none}';
      case LintRuleType.error:
        // ansi.red();
        // return ansi(name);
        return '${ansi.red}$name${ansi.none}';
    }
  }
}

extension LintErrorTypeX on LintRuleType {
  plugin.AnalysisErrorSeverity get analysisError {
    switch (this) {
      case LintRuleType.info:
        return plugin.AnalysisErrorSeverity.INFO;
      case LintRuleType.warning:
        return plugin.AnalysisErrorSeverity.WARNING;
      case LintRuleType.error:
        return plugin.AnalysisErrorSeverity.ERROR;
    }
  }
}

extension AnalysisErrorSeverityX on ErrorSeverity {
  LintRuleType toSidecarSeverity() {
    switch (name) {
      case 'INFO':
        return LintRuleType.info;
      case 'WARNING':
        return LintRuleType.warning;
      case 'ERROR':
        return LintRuleType.error;
      default:
        throw UnimplementedError(
            'invalid analysis error conversion from sidecar.');
    }
  }
}
