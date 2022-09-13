import 'package:analyzer/dart/ast/ast.dart';
import 'package:yaml/yaml.dart';

import '../models/models.dart';
import '../utils/utils.dart';
import 'i_error_reporter.dart';

class ErrorReporter extends IErrorReporter {
  ErrorReporter(super.unit);

  @override
  List<DetectedLint> generateLints(LintRule rule) {
    final reportedNode = rule.computeAnalysisError(sourceUnit);
    final x = sourceUnit.unit;

    return reportedNode.map((node) {
      final highlightedError = rule.computeLintHighlight(node);
      return node.copyWith(sourceSpan: highlightedError);
    }).toList();
  }

  // @override
  // void reportAstNode(AstNode? node, LintRule rule) {
  //   if (node != null) {
  //     final reportedLintError = DetectedLint(
  //       unit: sourceUnit,
  //       sourceSpan: node.toSourceSpan(sourceUnit),
  //       rule: rule,
  //     );

  //     final reportedNode = rule.computeAnalysisError(sourceUnit);
  //     final highlightedError = rule.computeLintHighlight(reportedLintError);

  //     final highlightedErrors =
  //         reportedNode.map((e) => e.copyWith(sourceSpan: highlightedError));

  //     detectedLints.addAll(highlightedErrors);
  //   }
  // }

  // @override
  // void reportYamlNode(YamlNode? node, LintRule rule) {
  //   if (node != null) {
  //     final reportedLintError =
  //         DetectedLint(unit: sourceUnit, sourceSpan: node.span, rule: rule);
  //     // final highlightedError = lint.computeLintHighlight(reportedLintError);
  //     detectedLints.add(reportedLintError);
  //   }
  // }
}
