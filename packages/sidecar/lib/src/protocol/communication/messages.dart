import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../logging/log_record.dart';
import 'requests.dart';
import 'notifications.dart';
import 'responses.dart';

part 'messages.freezed.dart';
part 'messages.g.dart';

@freezed
class SidecarMessage with _$SidecarMessage {
  const SidecarMessage._();

  const factory SidecarMessage.request({
    required SidecarRequest request,
    required String id,
  }) = RequestMessage;

  const factory SidecarMessage.response(
    SidecarResponse response, {
    required String id,
  }) = ResponseMessage;

  const factory SidecarMessage.notification({
    required SidecarNotification notification,
  }) = NotificationMessage;

  const factory SidecarMessage.log(
    LogRecord record,
  ) = LogMessage;

  factory SidecarMessage.fromJson(Map<String, dynamic> json) =>
      _$SidecarMessageFromJson(json);

  factory SidecarMessage.fromEncodedJson(String json) =>
      SidecarMessage.fromJson(jsonDecode(json) as Map<String, dynamic>);

  String toEncodedJson() => jsonEncode(toJson());
}
