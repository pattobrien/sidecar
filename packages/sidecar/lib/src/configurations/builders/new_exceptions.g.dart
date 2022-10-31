// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SidecarException _$$_SidecarExceptionFromJson(Map<String, dynamic> json) =>
    _$_SidecarException(
      code: json['code'] as String,
      message: json['message'] as String,
      correction: json['correction'] as String,
      sourceSpan:
          sourceSpanFromJson(json['sourceSpan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SidecarExceptionToJson(_$_SidecarException instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'correction': instance.correction,
      'sourceSpan': sourceSpanToJson(instance.sourceSpan),
    };
