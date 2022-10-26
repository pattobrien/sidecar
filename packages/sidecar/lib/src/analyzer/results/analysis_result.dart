import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../../rules/rules.dart';
import '../../utils/utils.dart';
import 'edit_result.dart';

part 'analysis_result.freezed.dart';

@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult.dart({
    required BaseRule rule,
    required SourceSpan sourceSpan,
    required String message,
    LintSeverity? severity,
    String? correction,
    SourceSpan? highlightedSpan,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = DartAnalysisResult;

  const AnalysisResult._();

  Uri get sourceUrl => sourceSpan.sourceUrl!;
  String get path => sourceSpan.sourceUrl!.path;

  bool isWithinOffset(String filePath, int offset) {
    return sourceSpan.location.file == filePath &&
        sourceSpan.start.offset <= offset &&
        offset <= sourceSpan.start.offset + sourceSpan.length;
  }

  AnalysisError? toAnalysisError() {
    if (rule is AssistRule) return null;
    final lintRule = rule as LintRule;
    final concatenatedLintCode = '${lintRule.packageName}.${lintRule.code}';
    return AnalysisError(
      severity?.analysisError ?? lintRule.defaultType.analysisError,
      AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      concatenatedLintCode,
      url: lintRule.url,
      correction: correction,
      //TODO: hasFix does not seem to work properly
      hasFix: edits.isNotEmpty,
    );
  }
}
