// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LintCode _$$LintCodeFromJson(Map json) => _$LintCode(
      json['id'] as String,
      package: json['package'] as String,
      url: json['url'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintCodeToJson(_$LintCode instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'package': instance.package,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  val['runtimeType'] = instance.$type;
  return val;
}

_$AssistCode _$$AssistCodeFromJson(Map json) => _$AssistCode(
      json['id'] as String,
      package: json['package'] as String,
      url: json['url'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistCodeToJson(_$AssistCode instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'package': instance.package,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('url', instance.url);
  val['runtimeType'] = instance.$type;
  return val;
}
