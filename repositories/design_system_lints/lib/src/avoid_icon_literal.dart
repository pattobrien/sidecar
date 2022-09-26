import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:sidecar/sidecar.dart';

class AvoidIconLiteral extends LintRule {
  @override
  String get code => 'avoid_icon_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(unit, this,
        message: 'Avoid IconData literal. Use design system spec instead.');
  }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

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
