// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RuleCode _$$_RuleCodeFromJson(Map<String, dynamic> json) => _$_RuleCode(
      type: $enumDecode(_$RuleTypeEnumMap, json['type']),
      code: json['code'] as String,
      packageName: json['packageName'] as String,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$_RuleCodeToJson(_$_RuleCode instance) =>
    <String, dynamic>{
      'type': _$RuleTypeEnumMap[instance.type]!,
      'code': instance.code,
      'packageName': instance.packageName,
      'url': instance.url,
    };

const _$RuleTypeEnumMap = {
  RuleType.lint: 'lint',
  RuleType.assist: 'assist',
};
