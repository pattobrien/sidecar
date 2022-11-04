// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InitCompleteNotification _$$InitCompleteNotificationFromJson(
        Map<String, dynamic> json) =>
    _$InitCompleteNotification(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InitCompleteNotificationToJson(
        _$InitCompleteNotification instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LintNotification _$$LintNotificationFromJson(Map<String, dynamic> json) =>
    _$LintNotification(
      json['path'] as String,
      (json['lints'] as List<dynamic>)
          .map((e) => LintResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintNotificationToJson(_$LintNotification instance) =>
    <String, dynamic>{
      'path': instance.path,
      'lints': instance.lints.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };
