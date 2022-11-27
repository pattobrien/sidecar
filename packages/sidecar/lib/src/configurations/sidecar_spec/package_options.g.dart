// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LintPackageOptions _$$LintPackageOptionsFromJson(Map json) =>
    _$LintPackageOptions(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      rules: (json['rules'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            LintOptions.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintPackageOptionsToJson(
    _$LintPackageOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('rules', instance.rules?.map((k, e) => MapEntry(k, e.toJson())));
  val['runtimeType'] = instance.$type;
  return val;
}

_$AssistPackageOptions _$$AssistPackageOptionsFromJson(Map json) =>
    _$AssistPackageOptions(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      rules: (json['rules'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            AssistOptions.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistPackageOptionsToJson(
    _$AssistPackageOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('rules', instance.rules?.map((k, e) => MapEntry(k, e.toJson())));
  val['runtimeType'] = instance.$type;
  return val;
}
