// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:path/path.dart' as p;

import 'package:sidecar/sidecar.dart';
import 'package:flutter_utilities/flutter_utilities.dart';

const _desc = r'Use key in widget constructors.';

class UseKeyInWidgetConstructors extends LintRule {
  UseKeyInWidgetConstructors(super.ref);

  @override
  String get code => 'use_key_in_widget_constructors';

  @override
  LintRuleType get defaultType => LintRuleType.info;

  @override
  String get message => _desc;

  @override
  String get packageName => 'flutter_lints';

  @override
  String? get url =>
      'https://dart-lang.github.io/linter/lints/use_key_in_widget_constructors.html';

  @override
  Future<List<DetectedLint>> computeAnalysisError(
    AnalysisContext analysisContext,
    String path,
  ) async {
    final visitor = _Visitor();
    final rootDirectory = analysisContext.contextRoot.root;
    final relativePath = p.relative(path, from: rootDirectory.path);
    final isIncluded = analysisContext.sidecarOptions.includes(relativePath);

    if (!isIncluded) return [];
    final unit = await analysisContext.currentSession.getResolvedUnit(path);
    if (unit is! ResolvedUnitResult) return [];
    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(unit, this);
  }
}

class _Visitor extends GeneralizingAstVisitor<void> {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    var classElement = node.declaredElement2;
    if (classElement != null &&
        classElement.isPublic &&
        FlutterUtils().hasWidgetAsAscendant(classElement) &&
        classElement.constructors.where((e) => !e.isSynthetic).isEmpty) {
      // rule.reportAstNode(node.name);
      // final lint = DetectedLint.fromAstNode(node.name, unit, rule);

      nodes.add(node.name);
    }
    super.visitClassDeclaration(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    var constructorElement = node.declaredElement2;
    if (constructorElement == null) {
      return;
    }
    var classElement = constructorElement.enclosingElement3;
    if (constructorElement.isPublic &&
        !constructorElement.isFactory &&
        classElement.isPublic &&
        classElement is ClassElement &&
        FlutterUtils().hasWidgetAsAscendant(classElement) &&
        !FlutterUtils().isExactWidget(classElement) &&
        !_hasKeySuperParameterInitializerArg(node) &&
        !node.initializers.any((initializer) {
          if (initializer is SuperConstructorInvocation) {
            var staticElement = initializer.staticElement;
            return staticElement != null &&
                (!_defineKeyParameter(staticElement) ||
                    _defineKeyArgument(initializer.argumentList));
          } else if (initializer is RedirectingConstructorInvocation) {
            var staticElement = initializer.staticElement;
            return staticElement != null &&
                (!_defineKeyParameter(staticElement) ||
                    _defineKeyArgument(initializer.argumentList));
          }
          return false;
        })) {
      var errorNode = node.name ?? node.returnType;
      nodes.add(errorNode);
    }
    super.visitConstructorDeclaration(node);
  }

  bool _defineKeyArgument(ArgumentList argumentList) => argumentList.arguments
      .any((a) => a.staticParameterElement?.name == 'key');

  bool _defineKeyParameter(ConstructorElement element) =>
      element.parameters.any((e) => e.name == 'key' && _isKeyType(e.type));

  bool _isKeyType(DartType type) => type.implementsInterface('Key', '');

  bool _hasKeySuperParameterInitializerArg(ConstructorDeclaration node) {
    for (var parameter in node.parameters.parameters) {
      var element = parameter.declaredElement;
      if (element is SuperFormalParameterElement && element.name == 'key') {
        return true;
      }
    }

    return false;
  }
}
