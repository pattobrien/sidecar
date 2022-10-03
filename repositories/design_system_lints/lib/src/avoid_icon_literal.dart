import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:sidecar/builder.dart';

const designSystemPackage = 'design_system_lints';

class AvoidIconLiteral extends LintRule {
  @override
  String get code => 'avoid_icon_literal';

  @override
  String get packageName => designSystemPackage;

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
      final matchingAnnotation = node.thisOrAncestorMatching((astNode) {
        final isMatch = astNode is AnnotatedNode &&
            astNode.metadata.isNotEmpty &&
            annotatedNodes.any((annotation) {
              final isSameSource =
                  annotation.annotatedNode.toSourceSpan(unit) ==
                      astNode.toSourceSpan(unit);
              return isSameSource &&
                  annotation.input.packageName == designSystemPackage;
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
