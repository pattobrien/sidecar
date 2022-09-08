// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lint_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LintConfiguration _$LintConfigurationFromJson(Map json) => LintConfiguration(
      packageName: json['packageName'] as String,
      lintId: json['lintId'] as String,
      enabled: json['enabled'] as bool? ?? true,
      configuration: json['configuration'] as Map,
    );

Map<String, dynamic> _$LintConfigurationToJson(LintConfiguration instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'lintId': instance.lintId,
      'enabled': instance.enabled,
      'configuration': instance.configuration,
    };
