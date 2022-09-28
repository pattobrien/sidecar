import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:sidecar/builder.dart';

class AvoidIconLiteral extends LintRule {
  @override
  String get code => 'avoid_icon_literal';

  @override
  String get packageName => 'design_system_lints';

  @override
  FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return visitor.nodes;
  }
}

class _Visitor extends SidecarAstVisitor {
  @override
  visitPrefixedIdentifier(PrefixedIdentifier node) {
    final isIconData = _isIconData(node.prefix.staticElement);
    if (isIconData) {
      reportAstNode(
        node,
        message: 'Avoid IconData literal. Use design system spec instead.',
      );
    }
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
