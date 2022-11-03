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
      'results': instance.results,
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
      'results': instance.results,
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
      'lints': instance.lints,
      'runtimeType': instance.$type,
    };
