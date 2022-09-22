import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import '../../sidecar.dart';

/// An instance of a detected lint, to be reported to the analyzer server.
class DetectedLint {
  const DetectedLint({
    required this.rule,
    required this.unit,
    required this.sourceSpan,
    this.message = '',
  });

  factory DetectedLint.fromAstNode(
    AstNode node,
    ResolvedUnitResult unit,
    LintRule rule, {
    String message = '',
  }) {
    return DetectedLint(
      rule: rule,
      unit: unit,
      message: message,
      sourceSpan: node.toSourceSpan(unit),
    );
  }

  final LintRule rule;

  final String message;

  /// Source of the source Ast Node
  final ResolvedUnitResult unit;

  final SourceSpan sourceSpan;

  DetectedLint copyWith({
    SourceSpan? sourceSpan,
  }) =>
      DetectedLint(
        rule: rule,
        message: message,
        unit: unit,
        sourceSpan: sourceSpan ?? this.sourceSpan,
      );

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
    return plugin.AnalysisError(
      rule.defaultType.analysisError,
      plugin.AnalysisErrorType.HINT,
      sourceSpan.location,
      rule.message,
      rule.code,
      url: rule.url,
    );
  }
}
