// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SidecarException _$$_SidecarExceptionFromJson(Map<String, dynamic> json) =>
    _$_SidecarException(
      code: RuleCode.fromJson(json['code'] as Map<String, dynamic>),
      message: json['message'] as String,
      correction: json['correction'] as String?,
      sourceSpan:
          sourceSpanFromJson(json['sourceSpan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SidecarExceptionToJson(_$_SidecarException instance) =>
    <String, dynamic>{
      'code': instance.code.toJson(),
      'message': instance.message,
      'correction': instance.correction,
      'sourceSpan': sourceSpanToJson(instance.sourceSpan),
    };
