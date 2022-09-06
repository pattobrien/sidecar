import 'package:analyzer/dart/ast/ast.dart';

import 'flutter_utilities.dart';

extension FlutterAstNodeX on AstNode {
  bool isInsideBuildMethod() {
    final node = thisOrAncestorMatching((node) {
      if (node is MethodDeclaration) {
        final parent = node.parent;
        final isBuildMethod = node.name.name == 'build';
        final isParentClassDeclaration = parent is ClassDeclaration;

        if (isBuildMethod && isParentClassDeclaration) {
          return FlutterUtils().isWidget(parent.declaredElement2!);
        }
        return false;
      } else {
        return false;
      }
    });
    return node != null;
  }
}
