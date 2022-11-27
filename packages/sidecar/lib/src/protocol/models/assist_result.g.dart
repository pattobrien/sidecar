// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assist_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssistFilterResult _$$AssistFilterResultFromJson(Map json) =>
    _$AssistFilterResult(
      rule: RuleCode.fromJson(Map<String, dynamic>.from(json['rule'] as Map)),
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

_$AssistResultWithEdits _$$AssistResultWithEditsFromJson(Map json) =>
    _$AssistResultWithEdits(
      code: RuleCode.fromJson(Map<String, dynamic>.from(json['code'] as Map)),
      span: sourceSpanFromJson(json['span'] as Map<String, dynamic>),
      edits: (json['edits'] as List<dynamic>?)
              ?.map((e) =>
                  EditResult.fromJson(Map<String, dynamic>.from(e as Map)))
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
