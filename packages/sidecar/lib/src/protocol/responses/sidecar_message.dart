import 'package:freezed_annotation/freezed_annotation.dart';

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

  const factory SidecarMessage.response({
    required SidecarResponse response,
    required String id,
  }) = ResponseMessage;

  const factory SidecarMessage.notification({
    required SidecarNotification notification,
  }) = NotificationMessage;

  const factory SidecarMessage.error() = ErrorMessage;

  factory SidecarMessage.fromJson(Map<String, dynamic> json) =>
      _$SidecarMessageFromJson(json);
}
