// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidecar_spec_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SidecarSpec _$SidecarSpecFromJson(Map json) => SidecarSpec(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      lints: (json['lints'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            LintPackageOptions.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
      assists: (json['assists'] as Map?)?.map(
        (k, e) => MapEntry(k as String,
            AssistPackageOptions.fromJson(Map<String, dynamic>.from(e as Map))),
      ),
    );

Map<String, dynamic> _$SidecarSpecToJson(SidecarSpec instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('includes', globsToStrings(instance.includes));
  writeNotNull('excludes', globsToStrings(instance.excludes));
  writeNotNull('lints', instance.lints?.map((k, e) => MapEntry(k, e.toJson())));
  writeNotNull(
      'assists', instance.assists?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}
