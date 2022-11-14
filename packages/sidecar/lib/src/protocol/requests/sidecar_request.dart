import 'package:freezed_annotation/freezed_annotation.dart';

import '../active_package.dart';
import '../analyzed_file.dart';
import '../models/file_update_event.dart';

part 'sidecar_request.freezed.dart';
part 'sidecar_request.g.dart';

@freezed
class SidecarRequest with _$SidecarRequest {
  const SidecarRequest._();

  const factory SidecarRequest.setActivePackage(ActivePackage package) =
      SetActivePackageRequest;

  // const factory SidecarRequest.setContextCollection({
  //   required List<Uri> roots,
  // }) = SetContextCollectionRequest;

  const factory SidecarRequest.lint(List<String> files) = LintRequest;

  const factory SidecarRequest.assist({
    required AnalyzedFile file,
    required int offset,
    required int length,
  }) = AssistRequest;

  const factory SidecarRequest.quickFix({
    required AnalyzedFile file,
    required int offset,
    // TODO: confirm that length is not sent with quick fix requests
    // required int length,
  }) = QuickFixRequest;

  const factory SidecarRequest.updateFiles(
    List<FileUpdateEvent> updates,
  ) = FileUpdateRequest;

  const factory SidecarRequest.setPriorityFiles(
    Set<AnalyzedFile> files,
  ) = SetPriorityFilesRequest;

  factory SidecarRequest.fromJson(Map<String, dynamic> json) =>
      _$SidecarRequestFromJson(json);
}
