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
    required this.sourceNode,
  });

  final LintError lint;
  final ResolvedUnitResult sourceUnit;
  final AstNode sourceNode;

  ReportedLintError copyWith({
    AstNode? sourceNode,
  }) =>
      ReportedLintError(
        lint: lint,
        sourceUnit: sourceUnit,
        sourceNode: sourceNode ?? this.sourceNode,
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
      sourceNode.toSourceSpan(sourceUnit).location,
      lint.message,
      lint.code,
    );
  }
}
