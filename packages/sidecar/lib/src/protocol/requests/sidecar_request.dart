import 'package:freezed_annotation/freezed_annotation.dart';

import 'file_update_event.dart';

part 'sidecar_request.freezed.dart';
part 'sidecar_request.g.dart';

//TODO: make all of the requests more type-safe, where applicable
// e.g. AnalyzedFile might be better to use instead of filePath
// but how can we serialize an ActiveContext instance?

@freezed
class SidecarRequest with _$SidecarRequest {
  const SidecarRequest._();

  const factory SidecarRequest.setContextCollection({
    required String mainRoot,
    required List<String> roots,
  }) = SetContextCollectionRequest;

  const factory SidecarRequest.analyzeFile(String filePath) =
      AnalyzeFileRequest;

  const factory SidecarRequest.assist({
    // required AnalyzedFile file,
    required String filePath,
    required int offset,
    required int length,
  }) = AssistRequest;

  const factory SidecarRequest.quickFix({
    required String filePath,
    required int offset,
    // TODO: confirm that length is not sent with quick fix requests
    // required int length,
  }) = QuickFixRequest;

  const factory SidecarRequest.fileUpdate(FileUpdateEvent event) =
      FileUpdateRequest;

  factory SidecarRequest.fromJson(Map<String, dynamic> json) =>
      _$SidecarRequestFromJson(json);
}
