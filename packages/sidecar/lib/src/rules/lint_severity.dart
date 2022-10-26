import 'package:analyzer/error/error.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:cli_util/cli_logging.dart';

import '../configurations/configurations.dart';

enum LintSeverity { info, warning, error }

extension LintSeverityX on LintSeverity {
  plugin.AnalysisErrorSeverity get analysisError {
    switch (this) {
      case LintSeverity.info:
        return plugin.AnalysisErrorSeverity.INFO;
      case LintSeverity.warning:
        return plugin.AnalysisErrorSeverity.WARNING;
      case LintSeverity.error:
        return plugin.AnalysisErrorSeverity.ERROR;
    }
  }

  static LintSeverity fromString(String string) {
    if (string == LintSeverity.error.name) {
      return LintSeverity.error;
    }
    if (string == LintSeverity.warning.name) {
      return LintSeverity.warning;
    }
    if (string == LintSeverity.info.name) {
      return LintSeverity.info;
    }
    throw InvalidSeverityException(string);
  }

  // used to colorize CLI output
  String get ansi {
    final ansi = Ansi(true);
    switch (this) {
      case LintSeverity.info:
        return name;
      case LintSeverity.warning:
        return '${ansi.bold}${ansi.yellow}$name${ansi.none}';
      case LintSeverity.error:
        return '${ansi.bold}${ansi.red}$name${ansi.none}';
      default:
        throw UnimplementedError();
    }
  }
}

extension AnalysisErrorSeverityX on ErrorSeverity {
  LintSeverity toSidecarSeverity() {
    switch (name) {
      case 'INFO':
        return LintSeverity.info;
      case 'WARNING':
        return LintSeverity.warning;
      case 'ERROR':
        return LintSeverity.error;
      default:
        throw UnimplementedError(
            'invalid analysis error conversion from sidecar.');
    }
  }
}
