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
          allowedKeys: const ['rules', 'includes'],
        );
        final val = PluginConfiguration(
          rules: $checkedConvert(
              'rules',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => LintConfiguration.fromJson(e as Map))
                  .toList()),
          includes: $checkedConvert('includes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PluginConfigurationToJson(
        PluginConfiguration instance) =>
    <String, dynamic>{
      'rules': instance.rules?.map((e) => e.toJson()).toList(),
      'includes': instance.includes,
    };
