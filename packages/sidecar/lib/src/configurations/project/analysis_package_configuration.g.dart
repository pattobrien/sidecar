// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_package_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LintPackageConfiguration _$LintPackageConfigurationFromJson(Map json) =>
    LintPackageConfiguration(
      lints: (json['lints'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            e == null ? null : LintConfiguration.fromJson(e as Object)),
      ),
      includes: globsFromString(json['includes'] as List<String>?),
    );

Map<String, dynamic> _$LintPackageConfigurationToJson(
        LintPackageConfiguration instance) =>
    <String, dynamic>{
      'lints': instance.lints?.map((k, e) => MapEntry(k, e?.toJson())),
      'includes': globsToString(instance.includes),
    };

AssistPackageConfiguration _$AssistPackageConfigurationFromJson(Map json) =>
    AssistPackageConfiguration(
      assists: (json['assists'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            e == null ? null : AssistConfiguration.fromJson(e as Object)),
      ),
      includes: globsFromString(json['includes'] as List<String>?),
    );

Map<String, dynamic> _$AssistPackageConfigurationToJson(
        AssistPackageConfiguration instance) =>
    <String, dynamic>{
      'assists': instance.assists?.map((k, e) => MapEntry(k, e?.toJson())),
      'includes': globsToString(instance.includes),
    };
