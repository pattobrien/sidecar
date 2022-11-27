// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EditResult _$$_EditResultFromJson(Map json) => _$_EditResult(
      message: json['message'] as String,
      sourceChanges: (json['sourceChanges'] as List<dynamic>)
          .map((e) =>
              SourceFileEdit.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_EditResultToJson(_$_EditResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'sourceChanges': instance.sourceChanges.map((e) => e.toJson()).toList(),
    };
