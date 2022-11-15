// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidecar_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetContextCollectionRequest _$$SetContextCollectionRequestFromJson(
        Map<String, dynamic> json) =>
    _$SetContextCollectionRequest(
      (json['roots'] as List<dynamic>?)
          ?.map((e) => Uri.parse(e as String))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetContextCollectionRequestToJson(
        _$SetContextCollectionRequest instance) =>
    <String, dynamic>{
      'roots': instance.roots?.map((e) => e.toString()).toList(),
      'runtimeType': instance.$type,
    };

_$LintRequest _$$LintRequestFromJson(Map<String, dynamic> json) =>
    _$LintRequest(
      (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintRequestToJson(_$LintRequest instance) =>
    <String, dynamic>{
      'files': instance.files,
      'runtimeType': instance.$type,
    };

_$AssistRequest _$$AssistRequestFromJson(Map<String, dynamic> json) =>
    _$AssistRequest(
      file: AnalyzedFile.fromJson(json['file'] as Map<String, dynamic>),
      offset: json['offset'] as int,
      length: json['length'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistRequestToJson(_$AssistRequest instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'offset': instance.offset,
      'length': instance.length,
      'runtimeType': instance.$type,
    };

_$QuickFixRequest _$$QuickFixRequestFromJson(Map<String, dynamic> json) =>
    _$QuickFixRequest(
      file: AnalyzedFile.fromJson(json['file'] as Map<String, dynamic>),
      offset: json['offset'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuickFixRequestToJson(_$QuickFixRequest instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'offset': instance.offset,
      'runtimeType': instance.$type,
    };

_$FileUpdateRequest _$$FileUpdateRequestFromJson(Map<String, dynamic> json) =>
    _$FileUpdateRequest(
      (json['updates'] as List<dynamic>)
          .map((e) => FileUpdateEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FileUpdateRequestToJson(_$FileUpdateRequest instance) =>
    <String, dynamic>{
      'updates': instance.updates.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$SetPriorityFilesRequest _$$SetPriorityFilesRequestFromJson(
        Map<String, dynamic> json) =>
    _$SetPriorityFilesRequest(
      (json['files'] as List<dynamic>)
          .map((e) => AnalyzedFile.fromJson(e as Map<String, dynamic>))
          .toSet(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetPriorityFilesRequestToJson(
        _$SetPriorityFilesRequest instance) =>
    <String, dynamic>{
      'files': instance.files.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };
