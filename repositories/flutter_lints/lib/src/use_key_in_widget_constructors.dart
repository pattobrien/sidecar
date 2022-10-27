// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:flutter_analyzer_utils/foundation.dart';

import 'package:sidecar/sidecar.dart';

import 'constants.dart';

const _desc = r'Use key in widget constructors.';

class UseKeyInWidgetConstructors extends LintRule with LintVisitor {
  @override
  String get code => 'use_key_in_widget_constructors';

  @override
  String get packageName => kPackageName;

  @override
  String get url => '$kUrlBase/use_key_in_widget_constructors.html';

  @override
  SidecarAstVisitor get visitorCreator => _Visitor();
}

class _Visitor extends SidecarAstVisitor {
  _Visitor();

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    var classElement = node.declaredElement2;
    if (classElement != null &&
        classElement.isPublic &&
        // FlutterUtils().hasWidgetAsAscendant(classElement) &&
        widgetType.isAssignableFromType(classElement.thisType) &&
        classElement.constructors.where((e) => !e.isSynthetic).isEmpty) {
      reportAstNode(node.name, message: _desc);
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
        // FlutterUtils().hasWidgetAsAscendant(classElement) &&
        // !FlutterUtils().isExactWidget(classElement) &&
        widgetType.isAssignableFromType(classElement.thisType) &&
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
      final errorNode = node.name ?? node.returnType;
      reportAstNode(errorNode, message: _desc);
    }
    super.visitConstructorDeclaration(node);
  }

  bool _defineKeyArgument(ArgumentList argumentList) => argumentList.arguments
      .any((a) => a.staticParameterElement?.name == 'key');

  bool _defineKeyParameter(ConstructorElement element) =>
      // element.parameters.any((e) => e.name == 'key' && _isKeyType(e.type));
      element.parameters.any((e) => keyType.isAssignableFrom(e));

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
