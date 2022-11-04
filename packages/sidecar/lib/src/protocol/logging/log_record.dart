import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/context_details.dart';
import '../models/models.dart';

part 'log_record.freezed.dart';
part 'log_record.g.dart';

@freezed
class LogRecord with _$LogRecord {
  const factory LogRecord.simple(
    String message,
  ) = _LogRecord;

  const factory LogRecord.fromAnalyzer(
    ContextDetails mainContext,
    String message,
  ) = AnalyzerLogRecord;

  const factory LogRecord.fromRule(
    RuleCode lintCode,
    String message,
  ) = RuleLogRecord;

  const LogRecord._();

  factory LogRecord.fromJson(Map<String, dynamic> json) =>
      _$LogRecordFromJson(json);
}
