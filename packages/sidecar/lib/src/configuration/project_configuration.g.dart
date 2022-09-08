// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectConfiguration _$ProjectConfigurationFromJson(Map json) =>
    ProjectConfiguration(
      lints: lintConfigFromJson(json['lints'] as Map?),
      edits: editConfigFromJson(json['edits'] as Map?),
      includes: (json['includes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['lib/**', 'test/**', 'bin/**'],
    );

Map<String, dynamic> _$ProjectConfigurationToJson(
        ProjectConfiguration instance) =>
    <String, dynamic>{
      'lints': instance.lints,
      'edits': instance.edits,
      'includes': instance.includes,
    };
