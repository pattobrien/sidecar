import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

/* SNIP TypeChecker */
// 1. Create the TypeChecker
const statelessWidget =
    TypeChecker.fromName('StatelessWidget', packageName: 'flutter');

/* SNIP TypeChecker END */
/* SNIP ClassStart */
class MyLint extends LintRule {
/* SNIP ClassStart END */
  @override
  LintCode get code => throw UnimplementedError();

  @override
  void initializeVisitor(NodeRegistry registry) {
    // TODO: implement initializeVisitor
  }
  /* SNIP VisitMethod */
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    // 2. Use the TypeChecker to check the type of a particular AstNode
    final returnType = node.constructorName.staticElement?.returnType;
    if (statelessWidget.isAssignableFromType(returnType)) {
      // do something
    }
  }
  /* SNIP VisitMethod END */
  /* SNIP ClassEnd */
}
/* SNIP ClassEnd END */

/* SNIP DartType */
@override
void visitInstanceCreationExpression(InstanceCreationExpression node) {
  // 2. Use the TypeChecker to check the type of a particular AstNode
  const colorTypeChecker = TypeChecker.fromDartType('Color', package: 'ui');
  final returnType = node.constructorName.staticElement?.returnType;
  if (colorTypeChecker.isAssignableFromType(returnType)) {
    // do something
  }
}
/* SNIP DartType END */
