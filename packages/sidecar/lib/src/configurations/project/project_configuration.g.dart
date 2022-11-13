// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectConfiguration _$ProjectConfigurationFromJson(
        Map<String, dynamic> json) =>
    ProjectConfiguration(
      lintPackages: (json['lints'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, LintPackageConfiguration.fromJson(e as Map<String, dynamic>)),
      ),
      assistPackages: (json['assists'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, AssistPackageConfiguration.fromJson(e as Object)),
      ),
    );

Map<String, dynamic> _$ProjectConfigurationToJson(
    ProjectConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'lints', instance.lintPackages?.map((k, e) => MapEntry(k, e.toJson())));
  writeNotNull('assists',
      instance.assistPackages?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}
