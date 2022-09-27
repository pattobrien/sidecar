import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../utils/source_span_utilities.dart';
import 'analysis_result.dart';
import 'lint_rule.dart';
import 'lint_rule_type.dart';
import 'sidecar_base.dart';

part 'detected_lint.freezed.dart';

@freezed
class DetectedLint with _$DetectedLint {
  const factory DetectedLint({
    required SidecarBase rule,
    required AnalysisResult result,
    required LintRuleType lintType,
    required ResolvedUnitResult unit,
  }) = _DetectedLint;

  const DetectedLint._();

  Future<plugin.AnalysisErrorFixes> computeAnalysisErrorFixes(
    Ref ref,
  ) async {
    final fixes = await rule.computeSourceChanges(result);
    return plugin.AnalysisErrorFixes(
      toAnalysisError()..hasFix = fixes.isNotEmpty,
      fixes: fixes.map((e) => e.toPrioritizedSourceChange()).toList(),
    );
  }

  bool isWithinOffset(String filePath, int offset) {
    return result.sourceSpan.location.file == filePath &&
        result.sourceSpan.start.offset <= offset &&
        offset <= result.sourceSpan.start.offset + result.sourceSpan.length;
  }

  plugin.AnalysisError toAnalysisError() {
    final baseRule = rule;
    final concatenatedLintCode = '${baseRule.packageName}.${baseRule.code}';
    return plugin.AnalysisError(
      lintType.analysisError,
      plugin.AnalysisErrorType.HINT,
      result.sourceSpan.location,
      result.message,
      concatenatedLintCode,
      url: baseRule is LintRule ? baseRule.url : null,
      correction: result.correction,
      //TODO: hasFix
    );
  }
}
