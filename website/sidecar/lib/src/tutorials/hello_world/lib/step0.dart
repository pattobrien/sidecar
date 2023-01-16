/* SNIPPET START */
import 'package:sidecar/sidecar.dart';

class HelloWorld extends LintRule {
  @override
  LintCode get code =>
      const LintCode('hello_world', package: 'hello_world_rules');
  /* SKIP */

  @override
  void initializeVisitor(NodeRegistry registry) {
    // TODO: implement initializeVisitor
  }
  /* SKIP END */
}
/* SNIPPET END */