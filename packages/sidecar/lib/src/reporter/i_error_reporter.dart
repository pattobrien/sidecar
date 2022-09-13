import 'package:analyzer/dart/analysis/results.dart';

import '../models/detected_lint.dart';
import '../models/lint_rule.dart';

abstract class IErrorReporter {
  IErrorReporter(this.sourceUnit);

  final ResolvedUnitResult sourceUnit;

  List<DetectedLint> generateLints(LintRule rule);
}
