// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectConfiguration _$ProjectConfigurationFromJson(Map json) => $checkedCreate(
      'ProjectConfiguration',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const ['rules', 'edits', 'includes'],
        );
        final val = ProjectConfiguration(
          rules: $checkedConvert(
              'rules',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => LintConfiguration.fromJson(e as Map))
                  .toList()),
          edits: $checkedConvert(
              'edits',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => EditConfiguration.fromJson(e as Map))
                  .toList()),
          includes: $checkedConvert('includes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProjectConfigurationToJson(
        ProjectConfiguration instance) =>
    <String, dynamic>{
      'rules': instance.rules?.map((e) => e.toJson()).toList(),
      'edits': instance.edits?.map((e) => e.toJson()).toList(),
      'includes': instance.includes,
    };
