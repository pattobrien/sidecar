import 'package:sidecar/src/test/utilities/expected_lint.dart';
import 'package:sidecar/src/test/utilities/utilities.dart';
import 'package:sidecar_lints/sidecar_lints.dart';
import 'package:test/test.dart';

void main() {
  group('missing_visit_method_registration:', () {
    final rule = MissingVisitMethodRegistration();
    test('missing method', () async {
      await testLint(
          rule, contentMissingBasic, [ExpectedLint(rule.code, 441, 15)]);
    });

    test('missing method cascade', () async {
      await testLint(rule, contentMissingMethodCascade, [
        ExpectedLint(rule.code, 571, 17),
      ]);
    });

    test('no missing methods', () async {
      await testLint(rule, contentNoMissingMethod, []);
    });
  });
}

const contentMissingBasic = '''
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class ExampleLint extends Rule with Lint {
  @override
  LintCode get code => LintCode('example_lint', package: 'example');

  @override
  void initializeVisitor(NodeRegistry registry) =>
      registry.addAdjacentStrings(this);

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

const contentMissingMethodCascade = '''
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class ExampleLint extends Rule with Lint {
  @override
  LintCode get code => LintCode('example_lint', package: 'example');


  @override
  void initializeVisitor(NodeRegistry registry) {
    registry
      ..addAdjacentStrings(this)
      ..addAnnotation(this);
  }

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    super.visitAdjacentStrings(node);
  }

  @override
  void visitAnnotation(Annotation node) {
    super.visitAnnotation(node);
  }

  @override
  void visitArgumentList(ArgumentList node) {
    super.visitArgumentList(node);
  }
}
''';

const contentNoMissingMethod = '''
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';

class ExampleLint extends Rule with Lint {
  @override
  LintCode get code => LintCode('example_lint', package: 'example');

  @override
  void initializeVisitor(NodeRegistry registry) =>
      registry.addAdjacentStrings(this);

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    super.visitAdjacentStrings(node);
  }
}
''';
