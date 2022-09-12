import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import '../utils/ast_utilities.dart';
import '../utils/source_span_utilities.dart';
import 'lint_rule.dart';

/// An instance of a detected lint, to be reported to the analyzer server.
class DetectedLint {
  const DetectedLint({
    required this.rule,
    required this.unit,
    required this.node,
    // required this.message,
    AstNode? highlightedNode,
  }) : highlightedNode = highlightedNode ?? node;

  final LintRule rule;

  /// Source of the source Ast Node
  final ResolvedUnitResult unit;

  /// Main source node of the reported lint
  final AstNode node;
  final AstNode highlightedNode;
  // final String message;

  DetectedLint copyWith({
    AstNode? highlightedNode,
  }) =>
      DetectedLint(
        rule: rule,
        unit: unit,
        node: node,
        // message: message,
        highlightedNode: highlightedNode ?? this.highlightedNode,
      );

  Future<plugin.AnalysisErrorFixes> toAnalysisErrorFixes(
    ProviderContainer ref,
  ) async {
    return plugin.AnalysisErrorFixes(
      toAnalysisError(),
      fixes: await rule.computeCodeEdits(this),
    );
  }

  plugin.AnalysisError toAnalysisError() {
    return plugin.AnalysisError(
      rule.defaultType.analysisError,
      plugin.AnalysisErrorType.HINT,
      highlightedNode.toSourceSpan(unit).location,
      rule.message,
      rule.code,
      url: rule.url,
    );
  }
}
