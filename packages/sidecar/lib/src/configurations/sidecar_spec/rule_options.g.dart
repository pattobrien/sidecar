// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RuleOptions _$$_RuleOptionsFromJson(Map<String, dynamic> json) =>
    _$_RuleOptions(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$$_RuleOptionsToJson(_$_RuleOptions instance) =>
    <String, dynamic>{
      'includes': globsToStrings(instance.includes),
      'excludes': globsToStrings(instance.excludes),
      'enabled': instance.enabled,
    };
