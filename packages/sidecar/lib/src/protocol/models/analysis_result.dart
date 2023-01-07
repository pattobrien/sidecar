import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../../rules/rules.dart';
import '../../utils/json_utils/json_utils.dart';
import 'edit_result.dart';
import 'rule_code.dart';

part 'analysis_result.freezed.dart';
part 'analysis_result.g.dart';

@immutable
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
    @JsonKey(ignore: true) EditsComputer? editsComputer,
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

  @override
  bool operator ==(dynamic other) {
    // TODO: missing List<EditResult> edits from equality
    return identical(this, other) ||
        (other is AnalysisResult &&
            const DeepCollectionEquality().equals(other.rule, rule) &&
            const DeepCollectionEquality().equals(other.span, span) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.severity, severity) &&
            const DeepCollectionEquality()
                .equals(other.correction, correction));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(rule),
        const DeepCollectionEquality().hash(span),
        const DeepCollectionEquality().hash(message),
        const DeepCollectionEquality().hash(severity),
        const DeepCollectionEquality().hash(correction),
      );

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

typedef EditsComputer = Future<List<EditResult>> Function();
