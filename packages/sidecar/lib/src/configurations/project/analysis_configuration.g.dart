// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LintConfiguration _$LintConfigurationFromJson(Map json) => LintConfiguration(
      severity: $enumDecodeNullable(_$LintSeverityEnumMap, json['severity']),
      includes: globsFromString(json['includes'] as List<String>?),
      configuration: json['configuration'] as Map?,
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$LintConfigurationToJson(LintConfiguration instance) =>
    <String, dynamic>{
      'severity': _$LintSeverityEnumMap[instance.severity],
      'configuration': instance.configuration,
      'enabled': instance.enabled,
      'includes': globsToString(instance.includes),
    };

const _$LintSeverityEnumMap = {
  LintSeverity.info: 'info',
  LintSeverity.warning: 'warning',
  LintSeverity.error: 'error',
};

AssistConfiguration _$AssistConfigurationFromJson(Map json) =>
    AssistConfiguration(
      includes: globsFromString(json['includes'] as List<String>?),
      configuration: json['configuration'] as Map?,
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$AssistConfigurationToJson(
        AssistConfiguration instance) =>
    <String, dynamic>{
      'configuration': instance.configuration,
      'enabled': instance.enabled,
      'includes': globsToString(instance.includes),
    };
