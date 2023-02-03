import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart' as logging;

import '../../../sidecar.dart';
import '../../analyzer/ast/registered_rule_visitor.dart';
import '../../analyzer/sidecar_analyzer.dart';
import '../../utils/json_utils/json_utils.dart';
import 'models.dart';

part 'log_record.freezed.dart';
part 'log_record.g.dart';

@freezed
class LogRecord with _$LogRecord {
  const factory LogRecord.simple(
    String message,
    DateTime timestamp, {
    required LogSeverity severity,
    @JsonKey(toJson: stackToStringNullable, fromJson: stringToStackNullable, includeIfNull: false)
        StackTrace? stackTrace,
  }) = _LogRecord;

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
        simple: (message, timestamp, severity, stackTrace) {
          return '[SIMPLE-LOG] ${timestamp.toIso8601String()} $message';
        },
        fromAnalyzer: (message, timestamp, root, severity, stackTrace) {
          return '[${root.pathSegments.reversed.toList()[1]}] ${timestamp.toIso8601String()} $message ${stackTrace ?? ''}';
        },
        fromRule: (lintCode, timestamp, severity, message, stackTrace) {
          return '[${severity.prettified}] ${timestamp.toIso8601String()} ${lintCode.prettyPrint()} $message ${stackTrace ?? ''}';
        },
      );
}

enum LogSeverity {
  error([logging.Level.SEVERE, logging.Level.SHOUT]),
  warning([logging.Level.WARNING]),
  info([logging.Level.FINE, logging.Level.FINER, logging.Level.FINEST]),
  verbose([]),
  unknown([]);

  const LogSeverity(this.levels);

  final List<logging.Level> levels;

  static LogSeverity fromLogLevel(logging.Level level) {
    if (level == logging.Level.FINE ||
        level == logging.Level.FINER ||
        level == logging.Level.FINEST ||
        level == logging.Level.INFO) {
      return LogSeverity.info;
    } else if (level == logging.Level.SEVERE || level == logging.Level.SHOUT) {
      return LogSeverity.error;
    } else if (level == logging.Level.WARNING) {
      return LogSeverity.warning;
    } else {
      return LogSeverity.unknown;
    }
  }

  String get prettified => name.toUpperCase().padLeft(7);
}

extension LoggingLogRecordX on logging.LogRecord {
  LogRecord toAnalyzerLog(Uri root) {
    final obj = object;
    if (obj is ShortRuleLog) {
      return RuleLogRecord(obj.code, time, LogSeverity.fromLogLevel(level),
          obj.message, stackTrace);
    } else {
      return AnalyzerLogRecord(message, time,
          targetRoot: root,
          severity: LogSeverity.fromLogLevel(level),
          stackTrace: stackTrace);
    }
  }

  SidecarMessage toSidecarMessage(Uri root) {
    return SidecarMessage.log(toAnalyzerLog(root));
  }
}
