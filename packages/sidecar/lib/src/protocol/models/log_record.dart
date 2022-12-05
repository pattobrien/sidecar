import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../utils/json_utils/json_utils.dart';
import 'models.dart';

part 'log_record.freezed.dart';
part 'log_record.g.dart';

@freezed
class LogRecord with _$LogRecord {
  const factory LogRecord.simple(
    String message,
    DateTime timestamp,
  ) = _LogRecord;

  const factory LogRecord.fromAnalyzer(
    String message,
    DateTime timestamp, {
    required Uri targetRoot,
    required LogSeverity severity,
    @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
        StackTrace? stackTrace,
  }) = AnalyzerLogRecord;

  const factory LogRecord.fromRule(
    RuleCode lintCode,
    DateTime timestamp,
    LogSeverity severity,
    String message,
    @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
        StackTrace? stackTrace,
  ) = RuleLogRecord;

  const LogRecord._();

  factory LogRecord.fromJson(Map<String, dynamic> json) =>
      _$LogRecordFromJson(json);
}

extension LogRecordX on LogRecord {
  String prettified() => when(
        simple: (message, timestamp) {
          return '[SIMPLE-LOG] ${timestamp.toIso8601String()} $message';
        },
        fromAnalyzer: (message, timestamp, root, severity, stackTrace) {
          return '[${root.pathSegments.reversed.toList()[1]}] ${timestamp.toIso8601String()} $message ${stackTrace ?? ''}';
        },
        fromRule: (lintCode, timestamp, severity, message, stackTrace) {
          return '[${lintCode.package}.${lintCode.id}] ${timestamp.toIso8601String()} $message ${stackTrace ?? ''}';
        },
      );
}

enum LogSeverity {
  error([Level.SEVERE, Level.SHOUT]),
  warning([Level.WARNING]),
  info([Level.FINE, Level.FINER, Level.FINEST]),
  verbose([]),
  unknown([]);

  const LogSeverity(this.levels);

  final List<Level> levels;

  static LogSeverity fromLogLevel(Level level) {
    if (level == Level.FINE ||
        level == Level.FINER ||
        level == Level.FINEST ||
        level == Level.INFO) {
      return LogSeverity.info;
    } else if (level == Level.SEVERE || level == Level.SHOUT) {
      return LogSeverity.error;
    } else if (level == Level.WARNING) {
      return LogSeverity.warning;
    } else {
      return LogSeverity.unknown;
    }
  }
}
