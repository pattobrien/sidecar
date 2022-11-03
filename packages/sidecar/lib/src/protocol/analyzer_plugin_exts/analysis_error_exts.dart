// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:analyzer_plugin/protocol/protocol_generated.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../rules/lint_severity.dart';
// import '../../utils/utils.dart';
// import '../models/analysis_result.dart';
// import '../models/edit_result.dart';

// extension LintResultX on AnalysisResult {
//   AnalysisError toAnalysisError() {
//     final concatenatedLintCode = '${rule.packageName}.${rule.code}';
//     return AnalysisError(
//       severity.analysisError,
//       AnalysisErrorType.HINT,
//       span.location,
//       message,
//       concatenatedLintCode,
//       url: rule.url,
//       correction: correction,
//       //TODO: hasFix does not seem to work properly (plugin bug?)
//       hasFix: hasCalculatedEdits,
//     );
//   }
// }

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
