// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LintResult _$$LintResultFromJson(Map json) => _$LintResult(
      rule: RuleCode.fromJson(Map<String, dynamic>.from(json['rule'] as Map)),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      message: json['message'] as String,
      severity: $enumDecode(_$LintSeverityEnumMap, json['severity']),
      correction: json['correction'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintResultToJson(_$LintResult instance) {
  final val = <String, dynamic>{
    'rule': instance.rule.toJson(),
    'span': sourceSpanToJson(instance.span),
    'message': instance.message,
    'severity': _$LintSeverityEnumMap[instance.severity]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('correction', instance.correction);
  val['runtimeType'] = instance.$type;
  return val;
}

const _$LintSeverityEnumMap = {
  LintSeverity.info: 'info',
  LintSeverity.warning: 'warning',
  LintSeverity.error: 'error',
};

_$LintResultWithEdits _$$LintResultWithEditsFromJson(Map json) =>
    _$LintResultWithEdits(
      rule: RuleCode.fromJson(Map<String, dynamic>.from(json['rule'] as Map)),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      message: json['message'] as String,
      severity: $enumDecode(_$LintSeverityEnumMap, json['severity']),
      correction: json['correction'] as String?,
      edits: (json['edits'] as List<dynamic>)
          .map((e) => EditResult.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintResultWithEditsToJson(
    _$LintResultWithEdits instance) {
  final val = <String, dynamic>{
    'rule': instance.rule.toJson(),
    'span': sourceSpanToJson(instance.span),
    'message': instance.message,
    'severity': _$LintSeverityEnumMap[instance.severity]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('correction', instance.correction);
  val['edits'] = instance.edits.map((e) => e.toJson()).toList();
  val['runtimeType'] = instance.$type;
  return val;
}
