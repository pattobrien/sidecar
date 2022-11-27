// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestMessage _$$RequestMessageFromJson(Map json) => _$RequestMessage(
      request: SidecarRequest.fromJson(
          Map<String, dynamic>.from(json['request'] as Map)),
      id: json['id'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RequestMessageToJson(_$RequestMessage instance) =>
    <String, dynamic>{
      'request': instance.request.toJson(),
      'id': instance.id,
      'runtimeType': instance.$type,
    };

_$ResponseMessage _$$ResponseMessageFromJson(Map json) => _$ResponseMessage(
      SidecarResponse.fromJson(
          Map<String, dynamic>.from(json['response'] as Map)),
      id: json['id'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ResponseMessageToJson(_$ResponseMessage instance) =>
    <String, dynamic>{
      'response': instance.response.toJson(),
      'id': instance.id,
      'runtimeType': instance.$type,
    };

_$NotificationMessage _$$NotificationMessageFromJson(Map json) =>
    _$NotificationMessage(
      notification: SidecarNotification.fromJson(
          Map<String, dynamic>.from(json['notification'] as Map)),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$NotificationMessageToJson(
        _$NotificationMessage instance) =>
    <String, dynamic>{
      'notification': instance.notification.toJson(),
      'runtimeType': instance.$type,
    };

_$LogMessage _$$LogMessageFromJson(Map json) => _$LogMessage(
      LogRecord.fromJson(Map<String, dynamic>.from(json['record'] as Map)),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LogMessageToJson(_$LogMessage instance) =>
    <String, dynamic>{
      'record': instance.record.toJson(),
      'runtimeType': instance.$type,
    };
