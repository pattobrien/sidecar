import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_record.freezed.dart';

@freezed
class LogRecord with _$LogRecord {
  const factory LogRecord({
    required String message,
  }) = _LogRecord;
  const LogRecord._();
}
