// ignore_for_file: implementation_imports

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

  String get ansi {
    // final ansi = AnsiPen();
    final ansi = Ansi(true);
    switch (this) {
      case LintRuleType.info:
        // ansi.white(bold: true);
        // return ansi(name);
        return '${ansi.blue}$name';
      case LintRuleType.warning:
        // ansi.yellow();
        // return ansi(name);
        return '${ansi.yellow}$name';
      case LintRuleType.error:
        // ansi.red();
        // return ansi(name);
        return '${ansi.red}$name';
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
