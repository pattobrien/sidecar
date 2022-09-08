// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EditConfiguration _$$_EditConfigurationFromJson(Map<String, dynamic> json) =>
    _$_EditConfiguration(
      id: json['id'] as String,
      enabled: json['enabled'] as bool,
      configuration: json['configuration'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_EditConfigurationToJson(
        _$_EditConfiguration instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enabled': instance.enabled,
      'configuration': instance.configuration,
    };
