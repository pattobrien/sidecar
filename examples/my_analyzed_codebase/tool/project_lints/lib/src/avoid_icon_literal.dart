import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:sidecar/builder.dart';

const _desc = r'Avoid IconData literal. Use design system spec instead.';

class AvoidIconLiteral extends LintRule {
  @override
  String get code => 'avoid_icon_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  Future<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) async {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes
        .map((e) => e.toDetectedLint(unit, this, message: _desc))
        .toList();
  }

  @override
  SourceSpan computeLintHighlight(DetectedLint lint) {
    final node = lint.sourceSpan.toAstNode(lint.unit);
    if (node is InstanceCreationExpression) {
      // return node;
    }
    return lint.sourceSpan;
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  @override
  visitPrefixedIdentifier(PrefixedIdentifier node) {
    final isIconData = _isIconData(node.prefix.staticElement);
    if (isIconData) nodes.add(node);
    return super.visitPrefixedIdentifier(node);
  }

  bool _isIconData(Element? element) {
    if (element != null) {
      final iconDataPath = 'flutter/src/material/icons.dart';
      final uri = element.librarySource?.uri;
      if (uri == null) return false;
      if (uri.isScheme('package') && uri.path == iconDataPath) {
        return true;
      }
    }
    return false;
  }
}
