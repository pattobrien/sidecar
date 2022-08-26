// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PluginConfiguration _$PluginConfigurationFromJson(Map json) => $checkedCreate(
      'PluginConfiguration',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['rules'],
        );
        final val = PluginConfiguration(
          rules: $checkedConvert(
              'rules',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => LintConfiguration.fromJson(e as Map))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PluginConfigurationToJson(
        PluginConfiguration instance) =>
    <String, dynamic>{
      'rules': instance.rules?.map((e) => e.toJson()).toList(),
    };
