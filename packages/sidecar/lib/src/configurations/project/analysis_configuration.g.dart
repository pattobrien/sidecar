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

Map<String, dynamic> _$LintConfigurationToJson(LintConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('severity', _$LintSeverityEnumMap[instance.severity]);
  writeNotNull('configuration', instance.configuration);
  writeNotNull('enabled', instance.enabled);
  writeNotNull('includes', globsToString(instance.includes));
  return val;
}

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

Map<String, dynamic> _$AssistConfigurationToJson(AssistConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('configuration', instance.configuration);
  writeNotNull('enabled', instance.enabled);
  writeNotNull('includes', globsToString(instance.includes));
  return val;
}
