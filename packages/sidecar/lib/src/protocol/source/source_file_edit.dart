import 'package:freezed_annotation/freezed_annotation.dart';

import 'source_edit.dart';

part 'source_file_edit.freezed.dart';
part 'source_file_edit.g.dart';

@freezed
class SourceFileEdit with _$SourceFileEdit {
  factory SourceFileEdit({
    required String filePath,
    required List<SourceEdit> edits,
  }) {
    return SourceFileEdit._(
      file: Uri.parse(filePath),
      edits: edits,
      fileStamp: DateTime.now(),
    );
  }

  const factory SourceFileEdit._({
    /// The file containing the code to be modified.
    required Uri file,

    /// A list of the edits used to effect the change.
    required List<SourceEdit> edits,

    /// The modification stamp of the file at the moment when the change was
    /// created. Will be -1 if the file did not exist and should be created.
    /// The client may use this field to make sure that the file was not
    /// changed since then, so it is safe to apply the change.
    required DateTime fileStamp,
  }) = _SourceFileEdit;

  factory SourceFileEdit.fromJson(Map<String, dynamic> json) =>
      _$SourceFileEditFromJson(json);
}
