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
  const factory AnalysisResult.lint({
    required RuleCode code,
    @Assert('span.sourceUrl != null')
    @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
        required SourceSpan span,
    required String message,
    required LintSeverity severity,
    String? correction,
    @JsonKey(ignore: true) EditsComputer? editsComputer,
  }) = LintResult;

  @Implements<Comparable<AnalysisResult>>()
  const factory AnalysisResult.lintWithEdits({
    required RuleCode code,
    @Assert('span.sourceUrl != null')
    @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
        required SourceSpan span,
    required String message,
    required LintSeverity severity,
    String? correction,
    required List<EditResult> edits,
  }) = LintWithEditsResult;

  const factory AnalysisResult.totalData({
    required RuleCode code,
    required List<Object> data,
  }) = TotalDataResult;

  const factory AnalysisResult.singleData({
    required RuleCode code,
    required Object data,
  }) = SingleDataResult;

  const factory AnalysisResult.assist({
    required RuleCode code,
    @Assert('span.sourceUrl != null')
    @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
        required SourceSpan span,
    @JsonKey(ignore: true) EditsComputer? editsComputer,
  }) = AssistResult;

  const factory AnalysisResult.assistWithEdits({
    required RuleCode code,
    @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
        required SourceSpan span,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = AssistWithEditsResult;

  const AnalysisResult._();

  factory AnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$AnalysisResultFromJson(json);

  @override
  bool operator ==(dynamic other) {
    return map(
      lint: (value) {
        return identical(this, other) ||
            (other is LintResult &&
                const DeepCollectionEquality().equals(other.code, value.code) &&
                const DeepCollectionEquality().equals(other.span, value.span) &&
                const DeepCollectionEquality()
                    .equals(other.message, value.message) &&
                const DeepCollectionEquality()
                    .equals(other.severity, value.severity) &&
                const DeepCollectionEquality()
                    .equals(other.correction, value.correction));
      },
      lintWithEdits: (value) {
        // TODO: missing List<EditResult> edits from equality
        return identical(this, other) ||
            (other is LintWithEditsResult &&
                const DeepCollectionEquality().equals(other.code, value.code) &&
                const DeepCollectionEquality().equals(other.span, value.span) &&
                const DeepCollectionEquality()
                    .equals(other.message, value.message) &&
                const DeepCollectionEquality()
                    .equals(other.severity, value.severity) &&
                const DeepCollectionEquality()
                    .equals(other.correction, value.correction));
      },
      totalData: (value) {
        return identical(this, other) ||
            (other is TotalDataResult &&
                const DeepCollectionEquality().equals(other.code, value.code) &&
                const DeepCollectionEquality().equals(other.data, value.data));
      },
      singleData: (value) {
        return identical(this, other) ||
            (other is SingleDataResult &&
                const DeepCollectionEquality().equals(other.code, value.code) &&
                const DeepCollectionEquality().equals(other.data, value.data));
      },
      assist: (value) {
        return identical(this, other) ||
            (other is AssistResult &&
                const DeepCollectionEquality().equals(other.code, value.code) &&
                const DeepCollectionEquality().equals(other.span, value.span));
      },
      assistWithEdits: (value) {
        // TODO: missing List<EditResult> edits from equality
        return identical(this, other) ||
            (other is AssistWithEditsResult &&
                const DeepCollectionEquality().equals(other.code, value.code) &&
                const DeepCollectionEquality().equals(other.span, value.span));
      },
    );
  }

  //TODO: reimplement hashCode override
  // @override
  int get hashCode => Object.hash(
        runtimeType,
        map(lint: (value) {
          return Object.hash(
            const DeepCollectionEquality().hash(value.code),
            const DeepCollectionEquality().hash(value.span),
            const DeepCollectionEquality().hash(value.message),
            const DeepCollectionEquality().hash(value.severity),
            const DeepCollectionEquality().hash(value.correction),
          );
        }, lintWithEdits: (value) {
          // TODO: missing List<EditResult> edits from equality
          return Object.hash(
            const DeepCollectionEquality().hash(value.code),
            const DeepCollectionEquality().hash(value.span),
            const DeepCollectionEquality().hash(value.message),
            const DeepCollectionEquality().hash(value.severity),
            const DeepCollectionEquality().hash(value.correction),
          );
        }, totalData: (value) {
          return Object.hash(
            const DeepCollectionEquality().hash(value.code),
            const DeepCollectionEquality().hash(value.data),
          );
        }, singleData: (value) {
          return Object.hash(
            const DeepCollectionEquality().hash(value.code),
            const DeepCollectionEquality().hash(value.data),
          );
        }, assist: (value) {
          return Object.hash(
            const DeepCollectionEquality().hash(value.code),
            const DeepCollectionEquality().hash(value.span),
          );
        }, assistWithEdits: (value) {
          // TODO: missing List<EditResult> edits from equality
          return Object.hash(
            const DeepCollectionEquality().hash(value.code),
            const DeepCollectionEquality().hash(value.span),
          );
        }),
      );

  /// Whether or not this lint has calculated edits yet.
  // bool get hasCalculatedEdits => this is LintWithEditsResult;

  // Uri get sourceUrl => span.sourceUrl!;

  // bool isWithinOffset(String filePath, int offset) =>
  //     sourceUrl.path == filePath &&
  //     span.start.offset <= offset &&
  //     offset <= span.start.offset + span.length;

  int compareTo(AnalysisResult other) => map(lint: (value) {
        assert(other is LintResult, 'can only compare to another LintResult');
        other as LintResult;
        return value.span.start.offset.compareTo(other.span.start.offset);
      }, lintWithEdits: (value) {
        assert(other is LintWithEditsResult,
            'can only compare to another LintWithEditsResult');
        other as LintWithEditsResult;
        return value.span.start.offset.compareTo(other.span.start.offset);
      }, totalData: (value) {
        assert(other is TotalDataResult, 'cant compare TotalDataResult');
        throw UnimplementedError('cant compare TotalDataResult');
      }, singleData: (value) {
        assert(other is SingleDataResult, 'cant compare SingleDataResult');
        throw UnimplementedError('cant compare SingleDataResult');
      }, assist: (value) {
        assert(
            other is AssistResult, 'can only compare to another AssistResult');
        other as AssistResult;
        return value.span.start.offset.compareTo(other.span.start.offset);
      }, assistWithEdits: (value) {
        assert(other is AssistWithEditsResult,
            'can only compare to another AssistWithEditsResult');
        other as AssistWithEditsResult;
        return value.span.start.offset.compareTo(other.span.start.offset);
      });
}

typedef EditsComputer = Future<List<EditResult>> Function();

extension LintResultX on LintResult {
  Uri get sourceUrl => span.sourceUrl!;

  bool isWithinOffset(String filePath, int offset) =>
      sourceUrl.path == filePath &&
      span.start.offset <= offset &&
      offset <= span.start.offset + span.length;

  int compareTo(LintResult other) =>
      span.start.offset.compareTo(other.span.start.offset);

  /// Whether or not this lint has calculated edits yet.
  bool get hasCalculatedEdits => false;

  LintWithEditsResult copyWithEdits({
    required List<EditResult> edits,
  }) {
    return LintWithEditsResult(
      code: code,
      span: span,
      message: message,
      severity: severity,
      edits: edits,
    );
  }
}

extension LintWithEditsResultX on LintWithEditsResult {
  Uri get sourceUrl => span.sourceUrl!;

  bool isWithinOffset(String filePath, int offset) =>
      sourceUrl.path == filePath &&
      span.start.offset <= offset &&
      offset <= span.start.offset + span.length;

  int compareTo(LintWithEditsResult other) =>
      span.start.offset.compareTo(other.span.start.offset);

  /// Whether or not this lint has calculated edits yet.
  bool get hasCalculatedEdits => true;
}

extension AssistFilterResultX on AssistResult {
  Uri get sourceUrl => span.sourceUrl!;

  bool isWithinOffset(String filePath, int offset) =>
      sourceUrl.path == filePath &&
      span.start.offset <= offset &&
      offset <= span.start.offset + span.length;

  int compareTo(AssistResult other) =>
      span.start.offset.compareTo(other.span.start.offset);
}

extension AssistWithEditsResultX on AssistWithEditsResult {
  Uri get sourceUrl => span.sourceUrl!;

  bool isWithinOffset(String filePath, int offset) =>
      sourceUrl.path == filePath &&
      span.start.offset <= offset &&
      offset <= span.start.offset + span.length;

  int compareTo(AssistWithEditsResult other) =>
      span.start.offset.compareTo(other.span.start.offset);
}
