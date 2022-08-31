import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import 'package:sidecar/sidecar.dart';

class ErrorReporter extends IErrorReporter {
  ErrorReporter(
    super.unit,
  );

  @override
  void reportedLint(AstNode? node, LintError lint) {
    if (node != null) {
      final reportedLintError =
          ReportedLintError(sourceUnit: unit, sourceNode: node, lint: lint);
      reportedErrors.add(reportedLintError);
    }
  }
}
