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
    visitor.initializeVisitor(this, unit, annotatedNodes);
    unit.unit.accept(visitor);
    return visitor.nodes;
  }
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    final isIconData = _isIconData(node.prefix.staticElement);
    if (isIconData) {
      final matchingAnnotation = node.thisOrAncestorMatching((ancestorNode) {
        final isMatch = ancestorNode is AnnotatedNode &&
            ancestorNode.metadata.isNotEmpty &&
            annotatedNodes.any((annotation) {
              final isSameSource = annotation.toSourceSpan(unit) ==
                  ancestorNode.toSourceSpan(unit);
              return isSameSource;
            });
        return isMatch;
      });

      if (matchingAnnotation == null) {
        reportAstNode(
          node,
          message:
              '1.20 Avoid IconData literal. Use design system spec instead.',
        );
      }
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
