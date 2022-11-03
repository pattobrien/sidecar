// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assist_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AssistResult _$$_AssistResultFromJson(Map<String, dynamic> json) =>
    _$_AssistResult(
      code: RuleCode.fromJson(json['code'] as Map<String, dynamic>),
      edits: (json['edits'] as List<dynamic>?)
              ?.map((e) => EditResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EditResult>[],
    );

Map<String, dynamic> _$$_AssistResultToJson(_$_AssistResult instance) =>
    <String, dynamic>{
      'code': instance.code.toJson(),
      'edits': instance.edits.map((e) => e.toJson()).toList(),
    };
