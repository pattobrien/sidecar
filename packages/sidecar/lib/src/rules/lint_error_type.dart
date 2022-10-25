import 'package:analyzer/error/error.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;

import 'rules.dart';

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
