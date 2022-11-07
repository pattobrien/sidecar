import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../../utils/json_utils/json_utils.dart';
import 'edit_result.dart';
import 'rule_code.dart';

part 'assist_result.freezed.dart';
part 'assist_result.g.dart';

@freezed
class AssistResult with _$AssistResult {
  const factory AssistResult({
    required RuleCode code,
    @JsonKey(toJson: sourceSpanToJson, fromJson: sourceSpanFromJson)
        required SourceSpan span,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = _AssistResult;

  const AssistResult._();

  factory AssistResult.fromJson(Map<String, dynamic> json) =>
      _$AssistResultFromJson(json);

  Uri get sourceUrl => span.sourceUrl!;

  bool isWithinOffset(String filePath, int offset) =>
      sourceUrl.path == filePath &&
      span.start.offset <= offset &&
      offset <= span.start.offset + span.length;
}
