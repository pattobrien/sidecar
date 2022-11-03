import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../../rules/rules.dart';
import '../../utils/json_utils/json_utils.dart';
import 'edit_result.dart';
import 'rule_code.dart';

part 'analysis_result.freezed.dart';
part 'analysis_result.g.dart';

@freezed
class AnalysisResult with _$AnalysisResult {
  @Implements<Comparable<AnalysisResult>>()
  const factory AnalysisResult({
    required RuleCode rule,
    @Assert('span.sourceUrl != null')
    @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
        required SourceSpan span,
    required String message,
    required LintSeverity severity,
    String? correction,
  }) = LintResult;

  @Implements<Comparable<AnalysisResult>>()
  const factory AnalysisResult.withEdits({
    required RuleCode rule,
    @Assert('span.sourceUrl != null')
    @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
        required SourceSpan span,
    required String message,
    required LintSeverity severity,
    String? correction,
    required List<EditResult> edits,
  }) = LintResultWithEdits;

  const AnalysisResult._();

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);

  /// Whether or not this lint has calculated edits yet.
  bool get hasCalculatedEdits => this is LintResultWithEdits;

  Uri get sourceUrl => span.sourceUrl!;

  bool isWithinOffset(String filePath, int offset) =>
      sourceUrl.path == filePath &&
      span.start.offset <= offset &&
      offset <= span.start.offset + span.length;

  int compareTo(AnalysisResult other) =>
      span.start.offset.compareTo(other.span.start.offset);

  LintResultWithEdits copyWithNoEdits() => copyWithEdits(edits: []);

  LintResultWithEdits copyWithEdits({
    required List<EditResult> edits,
  }) {
    return LintResultWithEdits(
      rule: rule,
      span: span,
      message: message,
      severity: severity,
      edits: edits,
    );
  }
}
