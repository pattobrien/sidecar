import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_constants.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/src/protocol/protocol_internal.dart' as plugin;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../sidecar.dart';
import '../../rules/lint_severity.dart';
import '../../utils/utils.dart';
import '../models/analysis_result.dart';
import '../models/edit_result.dart';

extension LintResultX on AnalysisResult {
  plugin.AnalysisError toAnalysisError() {
    final concatenatedLintCode = '${rule.packageName}.${rule.code}';
    return plugin.AnalysisError(
      severity.analysisError,
      plugin.AnalysisErrorType.HINT,
      span.location,
      message,
      concatenatedLintCode,
      url: rule.url,
      correction: correction,
      //TODO: hasFix does not seem to work properly (plugin bug?)
      hasFix: hasCalculatedEdits,
    );
  }
}

extension LintNotificationX on LintNotification {
  plugin.Notification toPluginNotification() {
    final analysisErrors = lints.map((e) => e.toAnalysisError()).toList();
    return plugin.AnalysisErrorsParams(path, analysisErrors).toNotification();
  }
}

// extension LintResultWithEditsX on LintResultWithEdits {
//   AnalysisErrorFixes toAnalysisErrorFixes() {
//     final fixes = edits.map((e) => e.toPrioritizedSourceChange()).toList();
//     return AnalysisErrorFixes(toAnalysisError(), fixes: fixes);
//   }
// }

// extension AssistResultX on AssistResult {
//   List<PrioritizedSourceChange> toPrioritizedSourceChanges() {
//     return edits.map((e) => e.toPrioritizedSourceChange()).toList();
//   }
// }

// extension EditResultX on EditResult {
//   PrioritizedSourceChange toPrioritizedSourceChange() {
//     return PrioritizedSourceChange(
//       0,
//       SourceChange(message, edits: sourceChanges),
//     );
//   }
// }
