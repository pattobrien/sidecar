/* SNIPPET START */
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class BlocOutsideControllerLayer extends LintRule {
  // we can use variables for better code legibility
  static const id = 'bloc_outside_controller_layer';
  static const package = 'bloc_feature_structure';
  static const message = 'Logic should be created in application folders.';

  @override
  LintCode get code => const LintCode(id, package: package);

  @override
  void initializeVisitor(NodeRegistry registry) {
    // TODO: implement initializeVisitor
  }
}
/* SNIPPET END */