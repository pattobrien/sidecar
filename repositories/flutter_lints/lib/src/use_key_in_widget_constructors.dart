// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:sidecar/sidecar.dart';
import 'package:flutter_utilities/flutter_utilities.dart';

import 'utils/utils.dart';

const _desc = r'Use key in widget constructors.';

const _details = r'''
**DO** use key in widget constructors.

It's a good practice to expose the ability to provide a key when creating public
widgets.

**BAD:**
```dart
class MyPublicWidget extends StatelessWidget {
}
```

**GOOD:**
```dart
class MyPublicWidget extends StatelessWidget {
  MyPublicWidget({super.key});
}
```
''';

class UseKeyInWidgetConstructors extends LintError {
  UseKeyInWidgetConstructors(super.ref);

  @override
  String get code => 'use_key_in_widget_constructors';

  @override
  LintErrorType get defaultType => LintErrorType.info;

  @override
  String get message => _desc;

  @override
  String get packageName => 'flutter_lints';

  @override
  void registerNodeProcessors(NodeLintRegistry registry) {
    var visitor = _Visitor(this);
    registry.addClassDeclaration(this, visitor);
    registry.addConstructorDeclaration(this, visitor);
  }
}

class _Visitor extends SimpleAstVisitor<void> {
  final LintError rule;

  _Visitor(this.rule);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    var classElement = node.declaredElement2;
    if (classElement != null &&
        classElement.isPublic &&
        FlutterUtils().hasWidgetAsAscendant(classElement) &&
        classElement.constructors.where((e) => !e.isSynthetic).isEmpty) {
      rule.reportedAstNode(node.name);
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
      rule.reportedAstNode(errorNode);
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
