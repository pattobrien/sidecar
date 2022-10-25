import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:flutter_analyzer_utils/material.dart';
import 'package:sidecar/sidecar.dart';

import 'constants.dart';

class AvoidIconLiteral extends LintRule {
  @override
  String get code => 'avoid_icon_literal';

  @override
  String get packageName => kDesignSystemPackageId;

  @override
  String? get url => kUrl;

  @override
  Future<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor();
    visitor.initializeVisitor(this, unit, annotatedNodes);
    unit.unit.accept(visitor);
    return Future.value(visitor.nodes);
  }
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    // final isIconData = _isIconData(node.prefix.staticElement);
    final type = node.identifier.staticType;
    if (type != null) {
      if (iconDataType.isAssignableFromType(type)) {
        final matchingAnnotation = node.thisOrAncestorMatching((astNode) {
          final isMatch = astNode is AnnotatedNode &&
              astNode.metadata.isNotEmpty &&
              annotatedNodes.any((annotation) {
                final isSameSource =
                    annotation.annotatedNode.toSourceSpan(unit) ==
                        astNode.toSourceSpan(unit);
                return isSameSource &&
                    annotation.input.packageName == kDesignSystemPackageId;
              });
          return isMatch;
        });

        if (matchingAnnotation == null) {
          reportAstNode(
            node,
            message: 'Avoid IconData literal.',
            correction: 'Use design system spec instead.',
          );
        }
      }
    }
    return super.visitPrefixedIdentifier(node);
  }
}
