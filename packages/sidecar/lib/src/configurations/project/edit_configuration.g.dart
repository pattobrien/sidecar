// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditConfiguration _$EditConfigurationFromJson(Map json) => EditConfiguration(
      packageName: json['packageName'] as String,
      editId: json['editId'] as String,
      enabled: json['enabled'] as bool? ?? true,
      configuration: json['configuration'] as Map,
    );

Map<String, dynamic> _$EditConfigurationToJson(EditConfiguration instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'editId': instance.editId,
      'enabled': instance.enabled,
      'configuration': instance.configuration,
    };
