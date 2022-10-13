import 'package:freezed_annotation/freezed_annotation.dart';

import '../plugin/analyzer/analyzed_file.dart';

part 'edit_request.freezed.dart';

@freezed
class EditRequest with _$EditRequest {
  const factory EditRequest({
    required int offset,
    required AnalyzedFile file,
  }) = _EditRequest;
  const EditRequest._();
}
