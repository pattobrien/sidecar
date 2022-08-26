import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import '../models/reported_lint_error.dart';
import '../models/lint_error.dart';
import '../ast/ast.dart';

abstract class IErrorReporter {
  IErrorReporter(
    this.unit, {
    this.reportedErrors = const <ReportedLintError>[],
  });

  final ResolvedUnitResult unit;
  final List<ReportedLintError> reportedErrors;

  void reportedLint(AstNode? node, LintError lint);
}
