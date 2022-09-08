// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageConfiguration _$PackageConfigurationFromJson(Map json) =>
    PackageConfiguration(
      lints: (json['lints'] as Map?)?.map(
        (k, e) => MapEntry(
            k, LintDeclaration.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      packageName: json['packageName'] as String,
    );

Map<String, dynamic> _$PackageConfigurationToJson(
        PackageConfiguration instance) =>
    <String, dynamic>{
      'lints': instance.lints,
      'packageName': instance.packageName,
    };
