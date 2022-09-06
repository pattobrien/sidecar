import 'package:analyzer/dart/ast/ast.dart';

import 'flutter_utilities.dart';

extension FlutterAstNodeX on AstNode {
  bool isInsideBuildMethod() {
    final node = thisOrAncestorMatching((node) {
      // Logger.logLine(
      //     'ANCESTOR: ${node.runtimeType} w/ SOURCE ${node.toSource()}');
      if (node is MethodDeclaration) {
        // Logger.logLine('FOUND METHOD: ${node.toSource()}');
        final parent = node.parent;
        final isBuildMethod = node.name.name == 'build';
        final isParentClassDeclaration = parent is ClassDeclaration;
        // Logger.logLine(
        //     'isBuildMethod: $isBuildMethod / isParentClassDeclaration: $isParentClassDeclaration');
        if (isBuildMethod && isParentClassDeclaration) {
          final flutter = FlutterUtils();
          // final flutter = FlutterUtils('package:flutter');
          final isWidget = flutter.isWidget(parent.declaredElement2!);
          // final supertypes = parent.declaredElement2?. ?? [];

          // for (final element in supertypes) {
          //   print(element.getDisplayString(withNullability: false));
          // }

          // final isWidget = supertypes.firstWhereOrNull((element) =>
          //         element.getDisplayString(withNullability: false) ==
          //         'Widget') !=
          //     null;

          // Logger.logLine('isWidget: $isWidget ');
          return isWidget;
          // return true;
        }
        return false;
      } else {
        return false;
      }
    });
    return node != null;
  }
}
