// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LintConfiguration _$$LintConfigurationFromJson(Map json) =>
    _$LintConfiguration(
      severity: $enumDecodeNullable(_$LintSeverityEnumMap, json['severity']),
      includes: globsFromString(json['includes'] as List<String>?),
      configuration: json['configuration'] as Map?,
      enabled: json['enabled'] as bool?,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => SidecarNewException.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const <SidecarNewException>[],
    );

Map<String, dynamic> _$$LintConfigurationToJson(_$LintConfiguration instance) =>
    <String, dynamic>{
      'severity': _$LintSeverityEnumMap[instance.severity],
      'includes': globsToString(instance.includes),
      'configuration': instance.configuration,
      'enabled': instance.enabled,
      'errors': instance.errors,
    };

const _$LintSeverityEnumMap = {
  LintSeverity.info: 'info',
  LintSeverity.warning: 'warning',
  LintSeverity.error: 'error',
};

_$AssistConfiguration _$$AssistConfigurationFromJson(Map json) =>
    _$AssistConfiguration(
      includes: globsFromString(json['includes'] as List<String>?),
      configuration: json['configuration'] as Map?,
      enabled: json['enabled'] as bool?,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => SidecarNewException.fromJson(
                  Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const <SidecarNewException>[],
    );

Map<String, dynamic> _$$AssistConfigurationToJson(
        _$AssistConfiguration instance) =>
    <String, dynamic>{
      'includes': globsToString(instance.includes),
      'configuration': instance.configuration,
      'enabled': instance.enabled,
      'errors': instance.errors,
    };
