// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LogRecord _$$_LogRecordFromJson(Map<String, dynamic> json) => _$_LogRecord(
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LogRecordToJson(_$_LogRecord instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$AnalyzerLogRecord _$$AnalyzerLogRecordFromJson(Map<String, dynamic> json) =>
    _$AnalyzerLogRecord(
      ContextDetails.fromJson(json['mainContext'] as Map<String, dynamic>),
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AnalyzerLogRecordToJson(_$AnalyzerLogRecord instance) =>
    <String, dynamic>{
      'mainContext': instance.mainContext.toJson(),
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$RuleLogRecord _$$RuleLogRecordFromJson(Map<String, dynamic> json) =>
    _$RuleLogRecord(
      RuleCode.fromJson(json['lintCode'] as Map<String, dynamic>),
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RuleLogRecordToJson(_$RuleLogRecord instance) =>
    <String, dynamic>{
      'lintCode': instance.lintCode.toJson(),
      'message': instance.message,
      'runtimeType': instance.$type,
    };
