import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:source_span/source_span.dart';

import '../utils/utils.dart';
import 'models.dart';

part 'analysis_result.freezed.dart';

@freezed
class AnalysisResult with _$AnalysisResult {
  const factory AnalysisResult.generic({
    required SidecarBase rule,
    required SourceSpan sourceSpan,
    required String message,
    String? correction,
    SourceSpan? highlightedSpan,
    @Default(<EditResult>[]) List<EditResult> edits,
  }) = GenericAnalysisResult;

  const factory AnalysisResult.dart({
    required SidecarBase rule,
    required SourceSpan sourceSpan,
    required String message,
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
    if (rule is CodeEdit) return null;
    final lintRule = rule as LintRule;
    final concatenatedLintCode = '${lintRule.packageName}.${lintRule.code}';
    return AnalysisError(
      lintRule.defaultType.analysisError,
      AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      concatenatedLintCode,
      url: lintRule.url,
      correction: correction,
      hasFix: edits.isNotEmpty,
      //TODO: hasFix
    );
  }
}

// extension DartAnalysisResultX on DartAnalysisResult {
//   // remove
//   AstNode? get node => sourceSpan.toAstNode(unit);
// }
