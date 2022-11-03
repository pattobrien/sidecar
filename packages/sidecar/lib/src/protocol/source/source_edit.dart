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
    int length,
    Uri url,
    String originalText,
    String replacement,
  ) {
    return SourceEdit(
      originalSourceSpan: SourceSpan(
          SourceLocation(offset, sourceUrl: url),
          SourceLocation(
            offset + length,
            sourceUrl: url,
          ),
          originalText),
      replacement: replacement,
    );
  }

  factory SourceEdit.fromJson(Map<String, dynamic> json) =>
      _$SourceEditFromJson(json);
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