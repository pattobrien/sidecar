import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/analysis_result.dart';
import '../models/assist_result.dart';

part 'response_union.freezed.dart';
part 'response_union.g.dart';

@freezed
class SidecarResponse with _$SidecarResponse {
  const SidecarResponse._();
  const factory SidecarResponse.contextCollection() = ContextCollectionResponse;

  const factory SidecarResponse.assist(List<AssistResult> results) =
      AssistResponse;

  const factory SidecarResponse.quickFix(List<LintResultWithEdits> results) =
      QuickFixResponse;

  const factory SidecarResponse.lint(List<LintResult> lints) = LintResponse;

  factory SidecarResponse.fromJson(Map<String, dynamic> json) =>
      _$SidecarResponseFromJson(json);
}
