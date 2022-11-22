// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SourceEdit _$$_SourceEditFromJson(Map<String, dynamic> json) =>
    _$_SourceEdit(
      originalSourceSpan: sourceSpanFromJson(
          json['originalSourceSpan'] as Map<String, dynamic>),
      replacement: json['replacement'] as String,
    );

Map<String, dynamic> _$$_SourceEditToJson(_$_SourceEdit instance) =>
    <String, dynamic>{
      'originalSourceSpan': sourceSpanToJson(instance.originalSourceSpan),
      'replacement': instance.replacement,
    };
