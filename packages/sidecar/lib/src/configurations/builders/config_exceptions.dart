import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../../protocol/models/models.dart';
import '../../rules/rules.dart';
import '../../utils/json_utils/source_span_utils.dart';

part 'config_exceptions.freezed.dart';
part 'config_exceptions.g.dart';

@freezed
class SidecarNewException with _$SidecarNewException {
  const factory SidecarNewException({
    required RuleCode code,
    required String message,
    String? correction,
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
      code: invalidFieldCode,
      message: message,
      correction: correction,
      sourceSpan: sourceSpan,
    );
  }

  factory SidecarNewException.rule({
    required String message,
    String? correction,
    @JsonKey(fromJson: sourceSpanFromJson, toJson: sourceSpanToJson)
        required SourceSpan sourceSpan,
  }) {
    return SidecarNewException(
        code: invalidRuleCode,
        message: message,
        correction: correction,
        sourceSpan: sourceSpan);
  }

  const SidecarNewException._();

  factory SidecarNewException.fromJson(Map<String, dynamic> json) =>
      _$SidecarNewExceptionFromJson(json);

  LintResult toLintResult() {
    return LintResult(
      span: sourceSpan,
      rule: code,
      message: message,
      correction: correction,
      severity: LintSeverity.warning,
    );
  }
}

const invalidFieldCode = LintCode(
  'sidecar_invalid_field',
  package: 'sidecar',
  // url:
);

const invalidRuleCode = AssistCode(
  'sidecar_invalid_rule',
  package: 'sidecar',
  // url:
);
