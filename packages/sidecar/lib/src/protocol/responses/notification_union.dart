import 'package:freezed_annotation/freezed_annotation.dart';

import '../protocol.dart';

part 'notification_union.freezed.dart';
part 'notification_union.g.dart';

@freezed
class SidecarNotification with _$SidecarNotification {
  const SidecarNotification._();
  const factory SidecarNotification.initComplete() = InitCompleteNotification;

  const factory SidecarNotification.lint(
    AnalyzedFile file,
    Set<LintResult> lints,
  ) = LintNotification;

  factory SidecarNotification.fromJson(Map<String, dynamic> json) =>
      _$SidecarNotificationFromJson(json);
}
