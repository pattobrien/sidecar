// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PackageOptions _$$_PackageOptionsFromJson(Map<String, dynamic> json) =>
    _$_PackageOptions(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      rules: (json['rules'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, RuleOptions.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_PackageOptionsToJson(_$_PackageOptions instance) =>
    <String, dynamic>{
      'includes': globsToStrings(instance.includes),
      'excludes': globsToStrings(instance.excludes),
      'rules': instance.rules?.map((k, e) => MapEntry(k, e.toJson())),
    };
