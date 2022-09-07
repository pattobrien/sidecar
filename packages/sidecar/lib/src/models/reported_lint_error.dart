import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:riverpod/riverpod.dart';

import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;

import '../utils/source_span_utilities.dart';
import '../utils/ast_utilities.dart';

import 'lint_error.dart';

class ReportedLintError {
  ReportedLintError({
    required this.lint,
    required this.sourceUnit,
    required this.reportedNode,
    AstNode? highlightedNode,
  }) : highlightedNode = highlightedNode ?? reportedNode;

  final LintError lint;
  final ResolvedUnitResult sourceUnit;
  final AstNode reportedNode;
  final AstNode highlightedNode;

  ReportedLintError copyWith({
    AstNode? highlightedNode,
  }) =>
      ReportedLintError(
        lint: lint,
        sourceUnit: sourceUnit,
        reportedNode: reportedNode,
        highlightedNode: highlightedNode ?? this.highlightedNode,
      );

  Future<plugin.AnalysisErrorFixes> toAnalysisErrorFixes(
    ProviderContainer ref,
  ) async {
    return plugin.AnalysisErrorFixes(
      toAnalysisError(),
      fixes: (await lint.computeFixes(this)),
    );
  }

  plugin.AnalysisError toAnalysisError() {
    return plugin.AnalysisError(
      lint.defaultType.analysisError,
      plugin.AnalysisErrorType.HINT,
      highlightedNode.toSourceSpan(sourceUnit).location,
      lint.message,
      lint.code,
    );
  }
}
