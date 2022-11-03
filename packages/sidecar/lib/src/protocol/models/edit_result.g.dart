// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EditResult _$$_EditResultFromJson(Map<String, dynamic> json) =>
    _$_EditResult(
      message: json['message'] as String,
      sourceChanges: (json['sourceChanges'] as List<dynamic>)
          .map((e) => SourceFileEdit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_EditResultToJson(_$_EditResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'sourceChanges': instance.sourceChanges,
    };
