// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SetWorkspaceResponse _$$SetWorkspaceResponseFromJson(Map json) =>
    _$SetWorkspaceResponse(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetWorkspaceResponseToJson(
        _$SetWorkspaceResponse instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$AssistResponse _$$AssistResponseFromJson(Map json) => _$AssistResponse(
      (json['results'] as List<dynamic>)
          .map((e) => AssistWithEditsResult.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toSet(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistResponseToJson(_$AssistResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$QuickFixResponse _$$QuickFixResponseFromJson(Map json) => _$QuickFixResponse(
      (json['results'] as List<dynamic>)
          .map((e) =>
              LintWithEditsResult.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuickFixResponseToJson(_$QuickFixResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$LintResponse _$$LintResponseFromJson(Map json) => _$LintResponse(
      (json['lints'] as List<dynamic>)
          .map((e) => LintResult.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintResponseToJson(_$LintResponse instance) =>
    <String, dynamic>{
      'lints': instance.lints.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$UpdateFilesResponse _$$UpdateFilesResponseFromJson(Map json) =>
    _$UpdateFilesResponse(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UpdateFilesResponseToJson(
        _$UpdateFilesResponse instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SetPriorityFilesResponse _$$SetPriorityFilesResponseFromJson(Map json) =>
    _$SetPriorityFilesResponse(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetPriorityFilesResponseToJson(
        _$SetPriorityFilesResponse instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
