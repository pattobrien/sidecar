// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InitCompleteNotification _$$InitCompleteNotificationFromJson(Map json) =>
    _$InitCompleteNotification(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InitCompleteNotificationToJson(
        _$InitCompleteNotification instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$LintNotification _$$LintNotificationFromJson(Map json) => _$LintNotification(
      AnalyzedFile.fromJson(Map<String, dynamic>.from(json['file'] as Map)),
      (json['lints'] as List<dynamic>)
          .map((e) => LintResult.fromJson(Map<String, dynamic>.from(e as Map)))
          .toSet(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintNotificationToJson(_$LintNotification instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'lints': instance.lints.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };
