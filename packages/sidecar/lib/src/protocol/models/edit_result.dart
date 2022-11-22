import 'package:freezed_annotation/freezed_annotation.dart';

import '../source/source_file_edit.dart';

part 'edit_result.freezed.dart';
part 'edit_result.g.dart';

@freezed
class EditResult with _$EditResult {
  const factory EditResult({
    /// User facing message about the edit
    required String message,
    required List<SourceFileEdit> sourceChanges,
  }) = _EditResult;
  const EditResult._();

  factory EditResult.fromJson(Map<String, dynamic> json) =>
      _$EditResultFromJson(json);
}
