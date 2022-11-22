// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleOptions _$RuleOptionsFromJson(Map json) => RuleOptions(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      enabled: json['enabled'] as bool?,
      configuration: json['configuration'] as Map?,
    );

Map<String, dynamic> _$RuleOptionsToJson(RuleOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('enabled', instance.enabled);
  writeNotNull('configuration', instance.configuration);
  return val;
}

LintOptions _$LintOptionsFromJson(Map json) => LintOptions(
      severity: $enumDecodeNullable(_$LintSeverityEnumMap, json['severity']),
      configuration: json['configuration'] as Map?,
      enabled: json['enabled'] as bool?,
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      includes: globsFromStrings(json['includes'] as List<String>?),
    );

Map<String, dynamic> _$LintOptionsToJson(LintOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('enabled', instance.enabled);
  writeNotNull('configuration', instance.configuration);
  writeNotNull('severity', _$LintSeverityEnumMap[instance.severity]);
  return val;
}

const _$LintSeverityEnumMap = {
  LintSeverity.info: 'info',
  LintSeverity.warning: 'warning',
  LintSeverity.error: 'error',
};

AssistOptions _$AssistOptionsFromJson(Map<String, dynamic> json) =>
    AssistOptions(
      configuration: json['configuration'] as Map<String, dynamic>?,
      enabled: json['enabled'] as bool?,
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      includes: globsFromStrings(json['includes'] as List<String>?),
    );

Map<String, dynamic> _$AssistOptionsToJson(AssistOptions instance) =>
    <String, dynamic>{
      'includes': globsToStrings(instance.includes),
      'excludes': globsToStrings(instance.excludes),
      'enabled': instance.enabled,
      'configuration': instance.configuration,
    };
