// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_update_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddEvent _$$AddEventFromJson(Map<String, dynamic> json) => _$AddEvent(
      AnalyzedFile.fromJson(json['file'] as Map<String, dynamic>),
      json['contents'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AddEventToJson(_$AddEvent instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'contents': instance.contents,
      'runtimeType': instance.$type,
    };

_$ModifyEvent _$$ModifyEventFromJson(Map<String, dynamic> json) =>
    _$ModifyEvent(
      AnalyzedFile.fromJson(json['file'] as Map<String, dynamic>),
      SourceFileEdit.fromJson(json['fileEdit'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ModifyEventToJson(_$ModifyEvent instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'fileEdit': instance.fileEdit.toJson(),
      'runtimeType': instance.$type,
    };

_$DeleteEvent _$$DeleteEventFromJson(Map<String, dynamic> json) =>
    _$DeleteEvent(
      AnalyzedFile.fromJson(json['file'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DeleteEventToJson(_$DeleteEvent instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'runtimeType': instance.$type,
    };
