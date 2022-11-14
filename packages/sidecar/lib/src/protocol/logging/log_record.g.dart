// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LogRecord _$$_LogRecordFromJson(Map<String, dynamic> json) => _$_LogRecord(
      json['message'] as String,
      DateTime.parse(json['timestamp'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LogRecordToJson(_$_LogRecord instance) =>
    <String, dynamic>{
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$AnalyzerLogRecord _$$AnalyzerLogRecordFromJson(Map<String, dynamic> json) =>
    _$AnalyzerLogRecord(
      json['message'] as String,
      DateTime.parse(json['timestamp'] as String),
      context: json['context'] == null
          ? null
          : ActivePackage.fromJson(json['context'] as Map<String, dynamic>),
      severity: $enumDecode(_$LogSeverityEnumMap, json['severity']),
      stackTrace: stringToStackNullable(json['stackTrace'] as String?),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AnalyzerLogRecordToJson(_$AnalyzerLogRecord instance) {
  final val = <String, dynamic>{
    'message': instance.message,
    'timestamp': instance.timestamp.toIso8601String(),
    'context': instance.context?.toJson(),
    'severity': _$LogSeverityEnumMap[instance.severity]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stackTrace', stackToStringNullable(instance.stackTrace));
  val['runtimeType'] = instance.$type;
  return val;
}

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
      DateTime.parse(json['timestamp'] as String),
      $enumDecode(_$LogSeverityEnumMap, json['severity']),
      json['message'] as String,
      stringToStackNullable(json['stackTrace'] as String?),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RuleLogRecordToJson(_$RuleLogRecord instance) {
  final val = <String, dynamic>{
    'lintCode': instance.lintCode.toJson(),
    'timestamp': instance.timestamp.toIso8601String(),
    'severity': _$LogSeverityEnumMap[instance.severity]!,
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('stackTrace', stackToStringNullable(instance.stackTrace));
  val['runtimeType'] = instance.$type;
  return val;
}
