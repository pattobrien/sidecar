import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../../utils/json_utils/source_span_utils.dart';

part 'source_edit.freezed.dart';
part 'source_edit.g.dart';

@freezed
class SourceEdit with _$SourceEdit {
  const factory SourceEdit({
    @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
        required SourceSpan originalSourceSpan,
    required String replacement,
  }) = _SourceEdit;
  const SourceEdit._();

  factory SourceEdit.simple(
    int offset,
    int length, {
    Uri? sourceUri,
    String? originalText,
    required String replacement,
  }) {
    return SourceEdit(
      originalSourceSpan: SourceSpan(
          SourceLocation(offset, sourceUrl: sourceUri),
          SourceLocation(offset + length, sourceUrl: sourceUri),
          originalText ?? ' ' * length),
      replacement: replacement,
    );
  }

  factory SourceEdit.fromJson(Map<String, dynamic> json) =>
      _$SourceEditFromJson(json);

  /// Get the result of applying a set of [edits] to the given [code].  Edits
  /// are applied in the order they appear in [edits].  Access via
  /// SourceEdit.applySequence().
  static String applySequenceOfEdits(String code, Iterable<SourceEdit> edits) {
    var editedCode = code;
    for (final edit in edits) {
      editedCode = edit.applySourceEdit(editedCode);
    }
    return editedCode;
  }
}

/// Get the result of applying the edit to the given [code]. Access via
/// SourceEdit.apply().
String applyEdit(String code, SourceEdit edit) {
  if (edit.length < 0) {
    throw RangeError('length is negative');
  }
  return code.replaceRange(edit.offset, edit.end, edit.replacement);
}

extension SourceEditX on SourceEdit {
  String applySourceEdit(String source) => applyEdit(source, this);
  int get length => originalSourceSpan.length;
  int get offset => originalSourceSpan.start.offset;
  int get end => originalSourceSpan.end.offset;
}
// /// The offset of the region to be modified.
//   int offset;

//   /// The length of the region to be modified.
//   int length;

//   /// The code that is to replace the specified region in the original code.
//   String replacement;

//   /// An identifier that uniquely identifies this source edit from other edits
//   /// in the same response. This field is omitted unless a containing structure
//   /// needs to be able to identify the edit for some reason.
//   String? id;