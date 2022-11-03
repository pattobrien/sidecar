import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_union.freezed.dart';
part 'notification_union.g.dart';

@freezed
class SidecarNotification with _$SidecarNotification {
  const SidecarNotification._();
  const factory SidecarNotification.initComplete() = InitCompleteNotification;

  factory SidecarNotification.fromJson(Map<String, dynamic> json) =>
      _$SidecarNotificationFromJson(json);
}
