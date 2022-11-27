// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LintOptions _$$LintOptionsFromJson(Map json) => _$LintOptions(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      enabled: json['enabled'] as bool?,
      configuration: json['configuration'] as Map?,
      severity: $enumDecodeNullable(_$LintSeverityEnumMap, json['severity']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintOptionsToJson(_$LintOptions instance) {
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
  val['runtimeType'] = instance.$type;
  return val;
}

const _$LintSeverityEnumMap = {
  LintSeverity.info: 'info',
  LintSeverity.warning: 'warning',
  LintSeverity.error: 'error',
};

_$AssistOptions _$$AssistOptionsFromJson(Map json) => _$AssistOptions(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      enabled: json['enabled'] as bool?,
      configuration: json['configuration'] as Map?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistOptionsToJson(_$AssistOptions instance) {
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
  val['runtimeType'] = instance.$type;
  return val;
}
