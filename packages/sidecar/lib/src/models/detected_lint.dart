import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:source_span/source_span.dart';

import '../utils/source_span_utilities.dart';
import 'lint_rule.dart';

part 'detected_lint.freezed.dart';

@freezed
class DetectedLint with _$DetectedLint {
  const factory DetectedLint({
    required LintRule rule,
    required String message,
    required LintRuleType lintType,
    required ResolvedUnitResult unit,
    required SourceSpan sourceSpan,
    String? correction,
  }) = _DetectedLint;

  const DetectedLint._();

  Future<plugin.AnalysisErrorFixes> computeAnalysisErrorFixes(
    Ref ref,
  ) async {
    final fixes = await rule.computeCodeEdits(this);
    return plugin.AnalysisErrorFixes(
      toAnalysisError()..hasFix = fixes.isNotEmpty,
      fixes: fixes,
    );
  }

  bool isWithinOffset(String filePath, int offset) {
    return sourceSpan.location.file == filePath &&
        sourceSpan.start.offset <= offset &&
        offset <= sourceSpan.start.offset + sourceSpan.length;
  }

  plugin.AnalysisError toAnalysisError() {
    final concatenatedLintCode = '${rule.packageName}.${rule.code}';
    return plugin.AnalysisError(
      lintType.analysisError,
      plugin.AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      concatenatedLintCode,
      url: rule.url,
      correction: correction,
      //TODO: hasFix
    );
  }
}
