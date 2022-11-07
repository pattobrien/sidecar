// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analyzed_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnalyzedFile _$$_AnalyzedFileFromJson(Map<String, dynamic> json) =>
    _$_AnalyzedFile(
      Context.fromJson(json['context'] as Map<String, dynamic>),
      Uri.parse(json['fileUri'] as String),
    );

Map<String, dynamic> _$$_AnalyzedFileToJson(_$_AnalyzedFile instance) =>
    <String, dynamic>{
      'context': instance.context.toJson(),
      'fileUri': instance.fileUri.toString(),
    };
