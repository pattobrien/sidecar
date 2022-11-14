import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_utils/json_utils.dart';
import '../logging/log_record.dart';
import '../protocol.dart';

part 'sidecar_message.freezed.dart';
part 'sidecar_message.g.dart';

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

  // const factory SidecarMessage.error(
  //   Object error,
  //   @JsonKey(toJson: stackToString, fromJson: stringToStack) StackTrace stack,
  // ) = ErrorMessage;

  const factory SidecarMessage.log(
    LogRecord record,
  ) = LogMessage;

  factory SidecarMessage.fromJson(Map<String, dynamic> json) =>
      _$SidecarMessageFromJson(json);

  factory SidecarMessage.fromEncodedJson(String json) =>
      SidecarMessage.fromJson(jsonDecode(json) as Map<String, dynamic>);

  String toEncodedJson() => jsonEncode(toJson());
}
