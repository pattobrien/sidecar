// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assist_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AssistResult _$$_AssistResultFromJson(Map<String, dynamic> json) =>
    _$_AssistResult(
      rule: RuleCode.fromJson(json['rule'] as Map<String, dynamic>),
      edits: (json['edits'] as List<dynamic>?)
              ?.map((e) => EditResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EditResult>[],
    );

Map<String, dynamic> _$$_AssistResultToJson(_$_AssistResult instance) =>
    <String, dynamic>{
      'rule': instance.rule,
      'edits': instance.edits,
    };
