// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidecar_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SidecarSpec _$$_SidecarSpecFromJson(Map<String, dynamic> json) =>
    _$_SidecarSpec(
      includes: globsFromStrings(json['includes'] as List<String>?),
      excludes: globsFromStrings(json['excludes'] as List<String>?),
      lints: (json['lints'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, PackageOptions.fromJson(e as Map<String, dynamic>)),
      ),
      assists: (json['assists'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, PackageOptions.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_SidecarSpecToJson(_$_SidecarSpec instance) =>
    <String, dynamic>{
      'includes': globsToStrings(instance.includes),
      'excludes': globsToStrings(instance.excludes),
      'lints': instance.lints?.map((k, e) => MapEntry(k, e.toJson())),
      'assists': instance.assists?.map((k, e) => MapEntry(k, e.toJson())),
    };
