// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidecar_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetContextCollectionRequest _$$SetContextCollectionRequestFromJson(
        Map<String, dynamic> json) =>
    _$SetContextCollectionRequest(
      mainRoot: json['mainRoot'] as String,
      roots: (json['roots'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetContextCollectionRequestToJson(
        _$SetContextCollectionRequest instance) =>
    <String, dynamic>{
      'mainRoot': instance.mainRoot,
      'roots': instance.roots,
      'runtimeType': instance.$type,
    };

_$AnalyzeFileRequest _$$AnalyzeFileRequestFromJson(Map<String, dynamic> json) =>
    _$AnalyzeFileRequest(
      json['filePath'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AnalyzeFileRequestToJson(
        _$AnalyzeFileRequest instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'runtimeType': instance.$type,
    };

_$AssistRequest _$$AssistRequestFromJson(Map<String, dynamic> json) =>
    _$AssistRequest(
      filePath: json['filePath'] as String,
      offset: json['offset'] as int,
      length: json['length'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistRequestToJson(_$AssistRequest instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'offset': instance.offset,
      'length': instance.length,
      'runtimeType': instance.$type,
    };

_$QuickFixRequest _$$QuickFixRequestFromJson(Map<String, dynamic> json) =>
    _$QuickFixRequest(
      filePath: json['filePath'] as String,
      offset: json['offset'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuickFixRequestToJson(_$QuickFixRequest instance) =>
    <String, dynamic>{
      'filePath': instance.filePath,
      'offset': instance.offset,
      'runtimeType': instance.$type,
    };

_$FileUpdateRequest _$$FileUpdateRequestFromJson(Map<String, dynamic> json) =>
    _$FileUpdateRequest(
      FileUpdateEvent.fromJson(json['event'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FileUpdateRequestToJson(_$FileUpdateRequest instance) =>
    <String, dynamic>{
      'event': instance.event,
      'runtimeType': instance.$type,
    };
