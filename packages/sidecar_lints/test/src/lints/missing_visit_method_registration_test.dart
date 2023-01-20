import 'package:sidecar/test.dart';
import 'package:sidecar_lints/sidecar_lints.dart';
import 'package:test/test.dart';

void main() {
  group('missing_visit_method_registration: ', () {
    setUpRules([MissingVisitMethodRegistration()]);

    ruleTest('missing annotation', content, [ExpectedText('visitAnnotation')]);
  });
}

const content = '''
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class ExampleLint extends LintRule {
  static const _id = 'example_lint';

  @override
  LintCode get code => LintCode(_id, package: 'example');

  @override
  void initializeVisitor(NodeRegistry registry) =>
      registry..addAdjacentStrings(this);

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    super.visitAdjacentStrings(node);
  }

  @override
  void visitAnnotation(Annotation node) {
    super.visitAnnotation(node);
  }
}
''';
