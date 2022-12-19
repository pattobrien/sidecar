import 'package:sidecar/src/test/utilities/expected_lint.dart';
import 'package:sidecar/src/test/utilities/utilities.dart';
import 'package:sidecar_lints/sidecar_lints.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    //
    test('First Test', () async {
      final rule = MissingVisitMethodRegistration();
      await testFile(rule, content, [ExpectedLint(rule.code, 469, 15)]);
    });
  });
}

const content = '''
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class ExampleLint extends Rule with Lint {
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
