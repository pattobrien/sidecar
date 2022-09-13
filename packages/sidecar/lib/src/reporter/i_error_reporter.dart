import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';

import '../models/detected_lint.dart';
import '../models/lint_rule.dart';

abstract class IErrorReporter {
  IErrorReporter(this.sourcePath);

  // final ResolvedUnitResult sourceUnit;
  final String sourcePath;
  // final String code;

  Future<List<DetectedLint>> generateLints(
    AnalysisContext context,
    LintRule rule,
  );
}
