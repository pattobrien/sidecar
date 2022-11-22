// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:source_span/source_span.dart';

// import '../../rules/rules.dart';
// import '../../utils/json_utils/json_utils.dart';
// import 'edit_result.dart';
// import 'rule_code.dart';

// part 'internal_analysis_result.freezed.dart';

// @freezed
// class InternalAnalysisResult with _$InternalAnalysisResult {
//   @Implements<Comparable<InternalAnalysisResult>>()
//   const factory InternalAnalysisResult({
//     required RuleCode rule,
//     @Assert('span.sourceUrl != null')
//     @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
//         required SourceSpan span,
//     required String message,
//     required LintSeverity severity,
//     String? correction,
//     EditsComputer? editsComputer,
//   }) = InternalLintResult;

//   @Implements<Comparable<InternalAnalysisResult>>()
//   const factory InternalAnalysisResult.withEdits({
//     required RuleCode rule,
//     @Assert('span.sourceUrl != null')
//     @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
//         required SourceSpan span,
//     required String message,
//     required LintSeverity severity,
//     String? correction,
//     required List<EditResult> edits,
//   }) = InternalLintWithEditsResult;

//   const InternalAnalysisResult._();

//   /// Whether or not this lint has calculated edits yet.
//   bool get hasCalculatedEdits => this is InternalLintWithEditsResult;

//   Uri get sourceUrl => span.sourceUrl!;

//   bool isWithinOffset(String filePath, int offset) =>
//       sourceUrl.path == filePath &&
//       span.start.offset <= offset &&
//       offset <= span.start.offset + span.length;

//   int compareTo(InternalAnalysisResult other) =>
//       span.start.offset.compareTo(other.span.start.offset);

//   InternalLintWithEditsResult copyWithNoEdits() => copyWithEdits(edits: []);

//   InternalLintWithEditsResult copyWithEdits({
//     required List<EditResult> edits,
//   }) {
//     return InternalLintWithEditsResult(
//       rule: rule,
//       span: span,
//       message: message,
//       severity: severity,
//       edits: edits,
//     );
//   }
// }

// typedef EditsComputer = Future<List<EditResult>> Function();
