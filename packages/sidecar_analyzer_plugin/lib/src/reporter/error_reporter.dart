import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'package:sidecar/sidecar.dart';

class ErrorReporter extends IErrorReporter {
  ErrorReporter(
    super.unit, {
    super.reportedErrors = const <ReportedLintError>[],
  });

  @override
  void reportedLint(AstNode? node, LintError lint) {
    if (node != null) {
      final sourceSpan = node.toSourceSpan(unit);
      final reportedLintError = ReportedLintError(
          sourceUnit: unit, sourceSpan: sourceSpan, lint: lint);
      reportedErrors.add(reportedLintError);
    }
  }
}
