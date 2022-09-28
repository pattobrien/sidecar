import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'package:source_span/source_span.dart';

import '../models/models.dart';
import '../utils/utils.dart';

abstract class SidecarAstVisitor extends GeneralizingAstVisitor<void> {
  // SidecarAstVisitor._();

  final List<DartAnalysisResult> nodes = [];
  late SidecarBase rule;
  late ResolvedUnitResult unit;

  void initializeVisitor(SidecarBase rule, ResolvedUnitResult unit) {
    this.unit = unit;
    this.rule = rule;
  }

  void reportAstNode(
    AstNode node, {
    required String message,
    String? correction,
  }) {
    final result = DartAnalysisResult(
      unit: unit,
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
    final start = SourceLocation(token.offset, sourceUrl: unit.path);
    final end =
        SourceLocation(token.offset + token.length, sourceUrl: unit.path);
    final result = DartAnalysisResult(
      unit: unit,
      rule: rule,
      sourceSpan: SourceSpan(start, end, token.lexeme),
      message: message,
      correction: correction,
    );
    nodes.add(result);
  }
}
