// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_file_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SourceFileEdit _$$_SourceFileEditFromJson(Map<String, dynamic> json) =>
    _$_SourceFileEdit(
      file: Uri.parse(json['file'] as String),
      edits: (json['edits'] as List<dynamic>)
          .map((e) => SourceEdit.fromJson(e as Map<String, dynamic>))
          .toList(),
      fileStamp: DateTime.parse(json['fileStamp'] as String),
    );

Map<String, dynamic> _$$_SourceFileEditToJson(_$_SourceFileEdit instance) =>
    <String, dynamic>{
      'file': instance.file.toString(),
      'edits': instance.edits,
      'fileStamp': instance.fileStamp.toIso8601String(),
    };
