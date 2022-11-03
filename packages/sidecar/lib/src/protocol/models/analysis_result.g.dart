// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LintResult _$$LintResultFromJson(Map<String, dynamic> json) => _$LintResult(
      rule: RuleCode.fromJson(json['rule'] as Map<String, dynamic>),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      message: json['message'] as String,
      severity: $enumDecode(_$LintSeverityEnumMap, json['severity']),
      correction: json['correction'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintResultToJson(_$LintResult instance) =>
    <String, dynamic>{
      'rule': instance.rule,
      'span': sourceSpanToJson(instance.span),
      'message': instance.message,
      'severity': _$LintSeverityEnumMap[instance.severity]!,
      'correction': instance.correction,
      'runtimeType': instance.$type,
    };

const _$LintSeverityEnumMap = {
  LintSeverity.info: 'info',
  LintSeverity.warning: 'warning',
  LintSeverity.error: 'error',
};

_$LintResultWithEdits _$$LintResultWithEditsFromJson(
        Map<String, dynamic> json) =>
    _$LintResultWithEdits(
      rule: RuleCode.fromJson(json['rule'] as Map<String, dynamic>),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      message: json['message'] as String,
      severity: $enumDecode(_$LintSeverityEnumMap, json['severity']),
      correction: json['correction'] as String?,
      edits: (json['edits'] as List<dynamic>)
          .map((e) => EditResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintResultWithEditsToJson(
        _$LintResultWithEdits instance) =>
    <String, dynamic>{
      'rule': instance.rule,
      'span': sourceSpanToJson(instance.span),
      'message': instance.message,
      'severity': _$LintSeverityEnumMap[instance.severity]!,
      'correction': instance.correction,
      'edits': instance.edits,
      'runtimeType': instance.$type,
    };
