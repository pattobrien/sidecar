// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidecar_spec_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$$_SidecarSpecToJson(_$_SidecarSpec instance) {
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
