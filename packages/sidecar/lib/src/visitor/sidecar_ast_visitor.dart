import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../models/models.dart';
import '../utils/utils.dart';

abstract class SidecarAstVisitor extends GeneralizingAstVisitor<void> {
  final List<DartAnalysisResult> nodes = [];
  late SidecarBase rule;
  late ResolvedUnitResult unit;
  late List<AnnotatedNode> annotatedNodes;

  void initializeVisitor(
    SidecarBase rule,
    ResolvedUnitResult unit, [
    List<AnnotatedNode> annotatedNodes = const [],
  ]) {
    this.unit = unit;
    this.rule = rule;
    this.annotatedNodes = annotatedNodes;
  }

  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
  }) {
    final result = DartAnalysisResult(
      rule: rule,
      sourceSpan: node.toSourceSpan(unit),
      message: message,
      correction: correction,
    );
    nodes.add(result);
  }

  void reportToken(
    Token token, {
    required String message,
    String? correction,
  }) {
    final result = DartAnalysisResult(
      rule: rule,
      sourceSpan: token.toSourceSpan(unit),
      message: message,
      correction: correction,
    );
    nodes.add(result);
  }
}
