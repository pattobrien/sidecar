// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_update_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddEvent _$$AddEventFromJson(Map json) => _$AddEvent(
      AnalyzedFile.fromJson(Map<String, dynamic>.from(json['file'] as Map)),
      json['contents'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AddEventToJson(_$AddEvent instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'contents': instance.contents,
      'runtimeType': instance.$type,
    };

_$ModifyEvent _$$ModifyEventFromJson(Map json) => _$ModifyEvent(
      AnalyzedFile.fromJson(Map<String, dynamic>.from(json['file'] as Map)),
      SourceFileEdit.fromJson(
          Map<String, dynamic>.from(json['fileEdit'] as Map)),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ModifyEventToJson(_$ModifyEvent instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'fileEdit': instance.fileEdit.toJson(),
      'runtimeType': instance.$type,
    };

_$DeleteEvent _$$DeleteEventFromJson(Map json) => _$DeleteEvent(
      AnalyzedFile.fromJson(Map<String, dynamic>.from(json['file'] as Map)),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DeleteEventToJson(_$DeleteEvent instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'runtimeType': instance.$type,
    };
