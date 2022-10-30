import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../../analyzer/results/analysis_result.dart';
import '../../rules/analysis_source.dart';
import '../../rules/rules.dart';
import '../../utils/json_utils/source_span_utils.dart';

part 'new_exceptions.freezed.dart';
part 'new_exceptions.g.dart';

@freezed
class SidecarNewException with _$SidecarNewException {
  const factory SidecarNewException({
    required String code,
    required String message,
    required String correction,
    @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
        required SourceSpan sourceSpan,
  }) = _SidecarException;

  factory SidecarNewException.lintField({
    required String message,
    required String correction,
    @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
        required SourceSpan sourceSpan,
  }) {
    return SidecarNewException(
        code: 'sidecar_invalid_field',
        message: message,
        correction: correction,
        sourceSpan: sourceSpan);
  }

  factory SidecarNewException.rule({
    required String message,
    String? correction,
    @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
        required SourceSpan sourceSpan,
  }) {
    return SidecarNewException(
        code: 'sidecar_invalid_rule',
        message: message,
        correction: correction ?? '',
        sourceSpan: sourceSpan);
  }
  // const factory SidecarNewException.package({
  //   // required String code,
  //   // required String message,
  //   // required String correction,
  //   required String packageName,
  //   @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
  //       required SourceSpan sourceSpan,
  // }) = PackageException;

  const SidecarNewException._();

  factory SidecarNewException.fromJson(Map<String, dynamic> json) =>
      _$SidecarNewExceptionFromJson(json);

  AnalysisResult toAnalysisResult() {
    return AnalysisResult.lint(
      span: AnalysisSourceSpan(
        path: sourceSpan.start.sourceUrl!.path,
        source: sourceSpan,
      ),
      rule: SidecarLintRule(field: code),
      message: message,
      correction: correction,
      severity: LintSeverity.warning,
    );
  }
}

class SidecarLintRule extends LintRule {
  SidecarLintRule({
    required this.field,
    // required this.package,
  });
  final String field;
  // final String package;

  @override
  String get code => field;

  @override
  LintPackageId get packageName => 'sidecar';
}
