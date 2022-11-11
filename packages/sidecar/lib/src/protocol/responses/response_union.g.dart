// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_union.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContextCollectionResponse _$$ContextCollectionResponseFromJson(
        Map<String, dynamic> json) =>
    _$ContextCollectionResponse(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ContextCollectionResponseToJson(
        _$ContextCollectionResponse instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$AssistResponse _$$AssistResponseFromJson(Map<String, dynamic> json) =>
    _$AssistResponse(
      (json['results'] as List<dynamic>)
          .map((e) => AssistResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AssistResponseToJson(_$AssistResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$QuickFixResponse _$$QuickFixResponseFromJson(Map<String, dynamic> json) =>
    _$QuickFixResponse(
      (json['results'] as List<dynamic>)
          .map((e) => LintResultWithEdits.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$QuickFixResponseToJson(_$QuickFixResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$LintResponse _$$LintResponseFromJson(Map<String, dynamic> json) =>
    _$LintResponse(
      (json['lints'] as List<dynamic>)
          .map((e) => LintResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LintResponseToJson(_$LintResponse instance) =>
    <String, dynamic>{
      'lints': instance.lints.map((e) => e.toJson()).toList(),
      'runtimeType': instance.$type,
    };

_$UpdateFilesResponse _$$UpdateFilesResponseFromJson(
        Map<String, dynamic> json) =>
    _$UpdateFilesResponse(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UpdateFilesResponseToJson(
        _$UpdateFilesResponse instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SetActiveRootResponse _$$SetActiveRootResponseFromJson(
        Map<String, dynamic> json) =>
    _$SetActiveRootResponse(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetActiveRootResponseToJson(
        _$SetActiveRootResponse instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$SetPriorityFilesResponse _$$SetPriorityFilesResponseFromJson(
        Map<String, dynamic> json) =>
    _$SetPriorityFilesResponse(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SetPriorityFilesResponseToJson(
        _$SetPriorityFilesResponse instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
