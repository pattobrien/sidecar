// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_update_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddEvent _$$AddEventFromJson(Map<String, dynamic> json) => _$AddEvent(
      Uri.parse(json['fileUri'] as String),
      json['contents'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AddEventToJson(_$AddEvent instance) =>
    <String, dynamic>{
      'fileUri': instance.fileUri.toString(),
      'contents': instance.contents,
      'runtimeType': instance.$type,
    };

_$ModifyEvent _$$ModifyEventFromJson(Map<String, dynamic> json) =>
    _$ModifyEvent(
      SourceFileEdit.fromJson(json['fileEdit'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ModifyEventToJson(_$ModifyEvent instance) =>
    <String, dynamic>{
      'fileEdit': instance.fileEdit.toJson(),
      'runtimeType': instance.$type,
    };

_$DeleteEvent _$$DeleteEventFromJson(Map<String, dynamic> json) =>
    _$DeleteEvent(
      Uri.parse(json['fileUri'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DeleteEventToJson(_$DeleteEvent instance) =>
    <String, dynamic>{
      'fileUri': instance.fileUri.toString(),
      'runtimeType': instance.$type,
    };
