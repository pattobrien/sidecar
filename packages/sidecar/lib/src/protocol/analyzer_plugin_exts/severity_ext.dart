import 'package:analyzer/error/error.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:cli_util/cli_logging.dart';
import 'package:sidecar/src/rules/rules.dart';

import '../../configurations/configurations.dart';

extension LintSeverityPluginX on LintSeverity {
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
