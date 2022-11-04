import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_record.freezed.dart';
part 'log_record.g.dart';

@freezed
class LogRecord with _$LogRecord {
  const factory LogRecord(
    String message,
  ) = _LogRecord;
  const LogRecord._();

  factory LogRecord.fromJson(Map<String, dynamic> json) =>
      _$LogRecordFromJson(json);
}
