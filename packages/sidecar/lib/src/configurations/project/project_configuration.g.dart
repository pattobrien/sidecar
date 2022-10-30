// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectConfiguration _$ProjectConfigurationFromJson(
        Map<String, dynamic> json) =>
    ProjectConfiguration(
      lintPackages: (json['lints'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, LintPackageConfiguration.fromJson(e as Object)),
      ),
      assistPackages: (json['assists'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, AssistPackageConfiguration.fromJson(e as Object)),
      ),
    );

Map<String, dynamic> _$ProjectConfigurationToJson(
        ProjectConfiguration instance) =>
    <String, dynamic>{
      'lints': instance.lintPackages?.map((k, e) => MapEntry(k, e.toJson())),
      'assists':
          instance.assistPackages?.map((k, e) => MapEntry(k, e.toJson())),
    };
