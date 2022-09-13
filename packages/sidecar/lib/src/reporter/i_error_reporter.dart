import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:yaml/yaml.dart';

import '../models/detected_lint.dart';
import '../models/lint_rule.dart';

abstract class IErrorReporter {
  IErrorReporter(this.sourceUnit);

  final ResolvedUnitResult sourceUnit;
  // final List<DetectedLint> detectedLints = <DetectedLint>[];

  List<DetectedLint> generateLints(LintRule rule);

  // void reportAstNode(AstNode? node, LintRule rule);
  // void reportYamlNode(YamlNode? node, LintRule rule);
}
