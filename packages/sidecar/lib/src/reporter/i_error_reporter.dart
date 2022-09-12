import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

import '../models/detected_lint.dart';
import '../models/lint_rule.dart';

abstract class IErrorReporter {
  IErrorReporter(this.sourceUnit);

  final ResolvedUnitResult sourceUnit;
  final List<DetectedLint> detectedLints = <DetectedLint>[];

  void reportAstNode(AstNode? node, LintRule rule);
}
