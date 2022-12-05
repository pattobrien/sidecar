import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import '../../utils/utils.dart';
import '../communication/communication.dart';
import '../models/models.dart';
import 'severity_ext.dart';
import 'source_exts.dart';

extension LintResultX on AnalysisResult {
  plugin.AnalysisError toAnalysisError() {
    final concatenatedLintCode = '${rule.package}.${rule.id}';
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
    return plugin.AnalysisErrorsParams(file.path, analysisErrors)
        .toNotification();
  }
}

extension LintResultWithEditsX on LintResultWithEdits {
  plugin.AnalysisErrorFixes toAnalysisErrorFixes() {
    final fixes = edits.map((e) => e.toPrioritizedSourceChange()).toList();
    return plugin.AnalysisErrorFixes(toAnalysisError(), fixes: fixes);
  }
}

extension AssistResultX on AssistResultWithEdits {
  List<plugin.PrioritizedSourceChange> toPrioritizedSourceChanges() {
    return edits.map((e) => e.toPrioritizedSourceChange()).toList();
  }
}

extension EditResultX on EditResult {
  plugin.PrioritizedSourceChange toPrioritizedSourceChange() {
    return plugin.PrioritizedSourceChange(
      0,
      plugin.SourceChange(message, edits: sourceChanges.toPluginFileEdits()),
    );
  }
}

extension QuickFixX on QuickFixResponse {
  plugin.EditGetFixesResult toPluginResponse() {
    final edits = results.map((e) => e.toAnalysisErrorFixes()).toList();
    return plugin.EditGetFixesResult(edits);
  }
}
