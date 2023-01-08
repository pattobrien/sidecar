// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LintResult _$$LintResultFromJson(Map json) => _$LintResult(
      code: RuleCode.fromJson(Map<String, dynamic>.from(json['code'] as Map)),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      message: json['message'] as String,
      severity: $enumDecode(_$LintSeverityEnumMap, json['severity']),
      correction: json['correction'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintResultToJson(_$LintResult instance) {
  final val = <String, dynamic>{
    'code': instance.code.toJson(),
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

_$LintWithEditsResult _$$LintWithEditsResultFromJson(Map json) =>
    _$LintWithEditsResult(
      code: RuleCode.fromJson(Map<String, dynamic>.from(json['code'] as Map)),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      message: json['message'] as String,
      severity: $enumDecode(_$LintSeverityEnumMap, json['severity']),
      correction: json['correction'] as String?,
      edits: (json['edits'] as List<dynamic>)
          .map((e) => EditResult.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintWithEditsResultToJson(
    _$LintWithEditsResult instance) {
  final val = <String, dynamic>{
    'code': instance.code.toJson(),
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

_$TotalDataResult _$$TotalDataResultFromJson(Map json) => _$TotalDataResult(
      code: RuleCode.fromJson(Map<String, dynamic>.from(json['code'] as Map)),
      data: json['data'] as List<dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TotalDataResultToJson(_$TotalDataResult instance) =>
    <String, dynamic>{
      'code': instance.code.toJson(),
      'data': instance.data,
      'runtimeType': instance.$type,
    };

_$SingleDataResult _$$SingleDataResultFromJson(Map json) => _$SingleDataResult(
      code: RuleCode.fromJson(Map<String, dynamic>.from(json['code'] as Map)),
      data: json['data'],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SingleDataResultToJson(_$SingleDataResult instance) {
  final val = <String, dynamic>{
    'code': instance.code.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  val['runtimeType'] = instance.$type;
  return val;
}

_$AssistResult _$$AssistResultFromJson(Map json) => _$AssistResult(
      code: RuleCode.fromJson(Map<String, dynamic>.from(json['code'] as Map)),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistResultToJson(_$AssistResult instance) =>
    <String, dynamic>{
      'code': instance.code.toJson(),
      'span': sourceSpanToJson(instance.span),
      'runtimeType': instance.$type,
    };

_$AssistWithEditsResult _$$AssistWithEditsResultFromJson(Map json) =>
    _$AssistWithEditsResult(
      code: RuleCode.fromJson(Map<String, dynamic>.from(json['code'] as Map)),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      edits: (json['edits'] as List<dynamic>?)
              ?.map((e) =>
                  EditResult.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const <EditResult>[],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistWithEditsResultToJson(
        _$AssistWithEditsResult instance) =>
    <String, dynamic>{
      'code': instance.code.toJson(),
      'span': sourceSpanToJson(instance.span),
      'edits': instance.edits.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };
