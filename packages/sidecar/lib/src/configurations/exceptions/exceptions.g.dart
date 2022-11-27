// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SidecarException _$$_SidecarExceptionFromJson(Map json) =>
    _$_SidecarException(
      code: RuleCode.fromJson(Map<String, dynamic>.from(json['code'] as Map)),
      message: json['message'] as String,
      correction: json['correction'] as String?,
      sourceSpan:
          sourceSpanFromJson(json['sourceSpan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SidecarExceptionToJson(_$_SidecarException instance) {
  final val = <String, dynamic>{
    'code': instance.code.toJson(),
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('correction', instance.correction);
  val['sourceSpan'] = sourceSpanToJson(instance.sourceSpan);
  return val;
}
