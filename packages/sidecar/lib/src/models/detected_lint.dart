import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../../sidecar.dart';

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

  Future<plugin.AnalysisErrorFixes> toAnalysisErrorFixes(
    ProviderContainer ref,
  ) async {
    final fixes = await rule.computeCodeEdits(this);
    return plugin.AnalysisErrorFixes(
      toAnalysisError()..hasFix = fixes.isNotEmpty,
      fixes: fixes,
    );
  }

  plugin.AnalysisError toAnalysisError() {
    final concatLintCode = '${rule.packageName}.${rule.code}';
    return plugin.AnalysisError(
      lintType.analysisError,
      plugin.AnalysisErrorType.HINT,
      sourceSpan.location,
      message,
      concatLintCode,
      url: rule.url,
      correction: correction,
      //TODO: hasFix
    );
  }
}
