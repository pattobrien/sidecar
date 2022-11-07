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
      Context.fromJson(json['mainContext'] as Map<String, dynamic>),
      DateTime.parse(json['timestamp'] as String),
      $enumDecode(_$LogSeverityEnumMap, json['severity']),
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AnalyzerLogRecordToJson(_$AnalyzerLogRecord instance) =>
    <String, dynamic>{
      'mainContext': instance.mainContext.toJson(),
      'timestamp': instance.timestamp.toIso8601String(),
      'severity': _$LogSeverityEnumMap[instance.severity]!,
      'message': instance.message,
      'runtimeType': instance.$type,
    };

const _$LogSeverityEnumMap = {
  LogSeverity.error: 'error',
  LogSeverity.warning: 'warning',
  LogSeverity.info: 'info',
  LogSeverity.verbose: 'verbose',
  LogSeverity.unknown: 'unknown',
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
