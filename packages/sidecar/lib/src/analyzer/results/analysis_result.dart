import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../../rules/rules.dart';
import '../../utils/utils.dart';
import 'edit_result.dart';

part 'analysis_result.freezed.dart';

@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult.lint({
    required LintRule rule,
    required SourceSpan sourceSpan,
    required String message,
    required LintSeverity severity,
    String? correction,
    SourceSpan? highlightedSpan,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = LintAnalysisResult;

  const factory AnalysisResult.assist({
    required AssistRule rule,
    required SourceSpan sourceSpan,
    required String message,
    String? correction,
    SourceSpan? highlightedSpan,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = AssistAnalysisResult;

  const AnalysisResult._();

  Uri get sourceUrl => sourceSpan.sourceUrl!;
  String get path => sourceSpan.sourceUrl!.path;

  bool isWithinOffset(String filePath, int offset) {
    return sourceSpan.location.file == filePath &&
        sourceSpan.start.offset <= offset &&
        offset <= sourceSpan.start.offset + sourceSpan.length;
  }
}

extension DartAnalysisResultX on LintAnalysisResult {
  AnalysisError? toAnalysisError() {
    final concatenatedLintCode = '${rule.packageName}.${rule.code}';
    return AnalysisError(
      severity.analysisError,
      AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      concatenatedLintCode,
      url: rule.url,
      correction: correction,
      //TODO: hasFix does not seem to work properly
      hasFix: edits.isNotEmpty,
    );
  }
}
