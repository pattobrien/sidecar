import 'package:sidecar_lints/sidecar_lints.dart';
import 'package:sidecar_test/sidecar_test.dart';
import 'package:test/test.dart';

void main() {
  group('missing_visit_method_registration: ', () {
    setUpRules([MissingVisitMethodRegistration()]);

    ruleTest('all methods are registered', content, []);

    ruleTest(
      'missing registration',
      contentMissingRegistration,
      [ExpectedText('visitAnnotation')],
    );
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
  void initializeVisitor(NodeRegistry registry) => registry
    ..addAdjacentStrings(this)
    ..addAnnotation(this);

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

const contentMissingRegistration = '''
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
