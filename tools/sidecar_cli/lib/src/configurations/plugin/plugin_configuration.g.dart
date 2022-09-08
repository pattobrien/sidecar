// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plugin_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PluginConfiguration _$PluginConfigurationFromJson(Map json) =>
    PluginConfiguration(
      lints: lintConfigFromJson(json['lints'] as Map?),
    );

Map<String, dynamic> _$PluginConfigurationToJson(
        PluginConfiguration instance) =>
    <String, dynamic>{
      'lints': instance.lints,
    };
