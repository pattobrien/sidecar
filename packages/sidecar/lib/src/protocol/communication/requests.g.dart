// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetContextCollectionRequest _$$SetContextCollectionRequestFromJson(
        Map json) =>
    _$SetContextCollectionRequest(
      (json['roots'] as List<dynamic>?)
          ?.map((e) => Uri.parse(e as String))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetContextCollectionRequestToJson(
    _$SetContextCollectionRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('roots', instance.roots?.map((e) => e.toString()).toList());
  val['runtimeType'] = instance.$type;
  return val;
}

_$LintRequest _$$LintRequestFromJson(Map json) => _$LintRequest(
      (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintRequestToJson(_$LintRequest instance) =>
    <String, dynamic>{
      'files': instance.files,
      'runtimeType': instance.$type,
    };

_$AssistRequest _$$AssistRequestFromJson(Map json) => _$AssistRequest(
      file:
          AnalyzedFile.fromJson(Map<String, dynamic>.from(json['file'] as Map)),
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

_$QuickFixRequest _$$QuickFixRequestFromJson(Map json) => _$QuickFixRequest(
      file:
          AnalyzedFile.fromJson(Map<String, dynamic>.from(json['file'] as Map)),
      offset: json['offset'] as int,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuickFixRequestToJson(_$QuickFixRequest instance) =>
    <String, dynamic>{
      'file': instance.file.toJson(),
      'offset': instance.offset,
      'runtimeType': instance.$type,
    };

_$FileUpdateRequest _$$FileUpdateRequestFromJson(Map json) =>
    _$FileUpdateRequest(
      (json['updates'] as List<dynamic>)
          .map((e) =>
              FileUpdateEvent.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FileUpdateRequestToJson(_$FileUpdateRequest instance) =>
    <String, dynamic>{
      'updates': instance.updates.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$SetPriorityFilesRequest _$$SetPriorityFilesRequestFromJson(Map json) =>
    _$SetPriorityFilesRequest(
      (json['files'] as List<dynamic>)
          .map(
              (e) => AnalyzedFile.fromJson(Map<String, dynamic>.from(e as Map)))
          .toSet(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetPriorityFilesRequestToJson(
        _$SetPriorityFilesRequest instance) =>
    <String, dynamic>{
      'files': instance.files.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };
