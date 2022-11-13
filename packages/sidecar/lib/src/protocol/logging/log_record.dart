import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../analyzer/context/active_package.dart';
import '../../utils/json_utils/json_utils.dart';
import '../models/models.dart';

part 'log_record.freezed.dart';
part 'log_record.g.dart';

@freezed
class LogRecord with _$LogRecord {
  const factory LogRecord.simple(
    String message,
  ) = _LogRecord;

  const factory LogRecord.fromAnalyzer(
    ActivePackage mainContext,
    DateTime timestamp,
    LogSeverity severity,
    String message,
    // @JsonKey(includeIfNull: false) Object? error,
    @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
        StackTrace? stackTrace,
  ) = AnalyzerLogRecord;

  const factory LogRecord.fromRule(
    RuleCode lintCode,
    String message,
  ) = RuleLogRecord;

  const LogRecord._();

  factory LogRecord.fromJson(Map<String, dynamic> json) =>
      _$LogRecordFromJson(json);
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

extension LogSeverityX on LogSeverity {}
