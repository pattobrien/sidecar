// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestMessage _$$RequestMessageFromJson(Map<String, dynamic> json) =>
    _$RequestMessage(
      request: SidecarRequest.fromJson(json['request'] as Map<String, dynamic>),
      id: json['id'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RequestMessageToJson(_$RequestMessage instance) =>
    <String, dynamic>{
      'request': instance.request.toJson(),
      'id': instance.id,
      'runtimeType': instance.$type,
    };

_$ResponseMessage _$$ResponseMessageFromJson(Map<String, dynamic> json) =>
    _$ResponseMessage(
      SidecarResponse.fromJson(json['response'] as Map<String, dynamic>),
      id: json['id'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResponseMessageToJson(_$ResponseMessage instance) =>
    <String, dynamic>{
      'response': instance.response.toJson(),
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
      'notification': instance.notification.toJson(),
      'runtimeType': instance.$type,
    };

_$LogMessage _$$LogMessageFromJson(Map<String, dynamic> json) => _$LogMessage(
      LogRecord.fromJson(json['record'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LogMessageToJson(_$LogMessage instance) =>
    <String, dynamic>{
      'record': instance.record.toJson(),
      'runtimeType': instance.$type,
    };
