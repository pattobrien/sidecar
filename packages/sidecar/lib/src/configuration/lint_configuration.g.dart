// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lint_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LintConfiguration _$$_LintConfigurationFromJson(Map<String, dynamic> json) =>
    _$_LintConfiguration(
      id: json['id'] as String,
      enabled: json['enabled'] as bool,
      configuration: json['configuration'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_LintConfigurationToJson(
        _$_LintConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enabled': instance.enabled,
      'configuration': instance.configuration,
    };
