// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidecar_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestMessage _$$RequestMessageFromJson(Map<String, dynamic> json) =>
    _$RequestMessage(
      request: SidecarRequest.fromJson(json['request'] as Map<String, dynamic>),
      id: json['id'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RequestMessageToJson(_$RequestMessage instance) =>
    <String, dynamic>{
      'request': instance.request,
      'id': instance.id,
      'runtimeType': instance.$type,
    };

_$ResponseMessage _$$ResponseMessageFromJson(Map<String, dynamic> json) =>
    _$ResponseMessage(
      response:
          SidecarResponse.fromJson(json['response'] as Map<String, dynamic>),
      id: json['id'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResponseMessageToJson(_$ResponseMessage instance) =>
    <String, dynamic>{
      'response': instance.response,
      'id': instance.id,
      'runtimeType': instance.$type,
    };

_$NotificationMessage _$$NotificationMessageFromJson(
        Map<String, dynamic> json) =>
    _$NotificationMessage(
      notification: SidecarNotification.fromJson(
          json['notification'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NotificationMessageToJson(
        _$NotificationMessage instance) =>
    <String, dynamic>{
      'notification': instance.notification,
      'runtimeType': instance.$type,
    };

_$ErrorMessage _$$ErrorMessageFromJson(Map<String, dynamic> json) =>
    _$ErrorMessage(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ErrorMessageToJson(_$ErrorMessage instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
