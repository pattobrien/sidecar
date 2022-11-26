// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assist_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssistFilterResult _$$AssistFilterResultFromJson(Map<String, dynamic> json) =>
    _$AssistFilterResult(
      rule: RuleCode.fromJson(json['rule'] as Map<String, dynamic>),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistFilterResultToJson(
        _$AssistFilterResult instance) =>
    <String, dynamic>{
      'rule': instance.rule.toJson(),
      'span': sourceSpanToJson(instance.span),
      'runtimeType': instance.$type,
    };

_$AssistResultWithEdits _$$AssistResultWithEditsFromJson(
        Map<String, dynamic> json) =>
    _$AssistResultWithEdits(
      code: RuleCode.fromJson(json['code'] as Map<String, dynamic>),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      edits: (json['edits'] as List<dynamic>?)
              ?.map((e) => EditResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EditResult>[],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistResultWithEditsToJson(
        _$AssistResultWithEdits instance) =>
    <String, dynamic>{
      'code': instance.code.toJson(),
      'span': sourceSpanToJson(instance.span),
      'edits': instance.edits.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };
