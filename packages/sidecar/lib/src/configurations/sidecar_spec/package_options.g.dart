// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageOptions _$PackageOptionsFromJson(Map json) => PackageOptions(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      rules: (json['rules'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            RuleOptions.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
    );

Map<String, dynamic> _$PackageOptionsToJson(PackageOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('rules', instance.rules?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}

AssistPackageOptions _$AssistPackageOptionsFromJson(Map json) =>
    AssistPackageOptions(
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      includes: globsFromStrings(json['includes'] as List<String>?),
      rules: (json['rules'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            AssistOptions.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
    );

Map<String, dynamic> _$AssistPackageOptionsToJson(
    AssistPackageOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('rules', instance.rules?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}

LintPackageOptions _$LintPackageOptionsFromJson(Map json) => LintPackageOptions(
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      includes: globsFromStrings(json['includes'] as List<String>?),
      rules: (json['rules'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            LintOptions.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
    );

Map<String, dynamic> _$LintPackageOptionsToJson(LintPackageOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('rules', instance.rules?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}
