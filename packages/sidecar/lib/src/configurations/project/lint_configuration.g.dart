// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lint_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LintConfiguration _$LintConfigurationFromJson(Map json) => LintConfiguration(
      packageName: json['packageName'] as String,
      lintId: json['lintId'] as String,
      configuration: json['configuration'] as Map,
      enabled: json['enabled'] as bool?,
      includes: globsFromJson(json['includes'] as List<String>?),
      severity: ruleTypeFromJson(json['severity'] as String?),
    );

Map<String, dynamic> _$LintConfigurationToJson(LintConfiguration instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'lintId': instance.lintId,
      'enabled': instance.enabled,
      'configuration': instance.configuration,
      'includes': globsToJson(instance.includes),
      'severity': ruleTypeToJson(instance.severity),
    };
