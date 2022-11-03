import 'package:freezed_annotation/freezed_annotation.dart';

import 'edit_result.dart';
import 'rule_code.dart';

part 'assist_result.freezed.dart';
part 'assist_result.g.dart';

@freezed
class AssistResult with _$AssistResult {
  const factory AssistResult({
    required RuleCode rule,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = _AssistResult;

  const AssistResult._();

  factory AssistResult.fromJson(Map<String, dynamic> json) =>
      _$AssistResultFromJson(json);
}
