import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../rules/rules.dart';
import '../../utils/utils.dart';
import 'edit_result.dart';

part 'analysis_result.freezed.dart';

@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult.lint({
    required LintRule rule,
    required AnalysisSourceSpan span,
    required String message,
    required LintSeverity severity,
    String? correction,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = LintResult;

  const factory AnalysisResult.assist({
    required AssistRule rule,
    required AnalysisSourceSpan span,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = AssistResult;

  const AnalysisResult._();

  Uri get sourceUrl => map(
        lint: (lint) => lint.span.sourceUrl,
        assist: (assist) => assist.span.sourceUrl,
      );
  // String get path => source.span.sourceUrl!.path;

  bool isWithinOffset(String filePath, int offset) {
    return sourceUrl.path == filePath &&
        span.source.start.offset <= offset &&
        offset <= span.source.start.offset + span.source.length;
  }
}

extension LintResultX on LintResult {
  AnalysisError toAnalysisError() {
    final concatenatedLintCode = '${rule.packageName}.${rule.code}';
    return AnalysisError(
      severity.analysisError,
      AnalysisErrorType.HINT,
      span.source.location,
      message,
      concatenatedLintCode,
      url: rule.url,
      correction: correction,
      //TODO: hasFix does not seem to work properly
      hasFix: edits.isNotEmpty,
    );
  }
}

extension AssistResultX on AssistResult {
  List<PrioritizedSourceChange> toPrioritizedSourceChanges() {
    return edits.map((e) => e.toPrioritizedSourceChange()).toList();
  }
}
