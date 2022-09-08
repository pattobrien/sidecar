// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageConfiguration _$PackageConfigurationFromJson(Map json) =>
    PackageConfiguration(
      packageName: json['packageName'] as String,
      lints: (json['lints'] as List<dynamic>)
          .map((e) => LintConfiguration.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$PackageConfigurationToJson(
        PackageConfiguration instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'lints': instance.lints,
    };
