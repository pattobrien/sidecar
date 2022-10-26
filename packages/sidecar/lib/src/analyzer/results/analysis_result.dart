import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../rules/rules.dart';
import '../../utils/utils.dart';
import 'edit_result.dart';

part 'analysis_result.freezed.dart';

@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult.lint({
    required LintRule rule,
    required AnalysisSource source,
    required String message,
    required LintSeverity severity,
    String? correction,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = LintResult;

  const factory AnalysisResult.assist({
    required AssistRule rule,
    required AnalysisSource source,
    required String message,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = AssistAnalysisResult;

  const AnalysisResult._();

  Uri get sourceUrl => source.span.sourceUrl!;
  String get path => source.span.sourceUrl!.path;

  bool isWithinOffset(String filePath, int offset) {
    return source.span.location.file == filePath &&
        source.span.start.offset <= offset &&
        offset <= source.span.start.offset + source.span.length;
  }
}

extension LintResultX on LintResult {
  AnalysisError? toAnalysisError() {
    final concatenatedLintCode = '${rule.packageName}.${rule.code}';
    return AnalysisError(
      severity.analysisError,
      AnalysisErrorType.HINT,
      source.span.location,
      message,
      concatenatedLintCode,
      url: rule.url,
      correction: correction,
      //TODO: hasFix does not seem to work properly
      hasFix: edits.isNotEmpty,
    );
  }
}
