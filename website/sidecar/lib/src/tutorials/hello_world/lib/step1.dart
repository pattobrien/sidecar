/* SNIPPET START */
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class HelloWorld extends LintRule {
  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    // TODO: implement visitSimpleStringLiteral
    super.visitSimpleStringLiteral(node);
  } /* SKIP */

  @override
  // TODO: implement code
  LintCode get code => throw UnimplementedError();

  @override
  void initializeVisitor(NodeRegistry registry) {
    // TODO: implement initializeVisitor
  }
  /* SKIP END */
}
/* SNIPPET END */