import 'package:sidecar_lints/sidecar_lints.dart';
import 'package:sidecar_test/sidecar_test.dart';
import 'package:test/test.dart';

void main() {
  group('rule_not_declared:', () {
    setUpRules([RuleNotDeclared()]);
    // these rules need access to a testable pubspec

    // ruleTest('id matches', contentIdMatch, []);

    // ruleTest('id doesnt match case', contentIdMatch, [ExpectedText('Foo')]);

    // ruleTest('id doesnt match', contentIdDoesntMatch, [ExpectedText('bar')]);
  });
}

const contentIdMatch = '''
import 'package:sidecar/sidecar.dart';

class Foo extends LintRule {
  @override
  LintCode get code => LintCode('foo', package: 'sidecar_lints');

  @override
  void initializeVisitor(NodeRegistry registry) {}
}
''';

const contentIdDoesntMatch = '''
import 'package:sidecar/sidecar.dart';

class Foo extends LintRule {
  @override
  LintCode get code => LintCode('bar', package: 'sidecar_lints');

  @override
  void initializeVisitor(NodeRegistry registry) {}
}
''';

const contentIdWrongCase = '''
import 'package:sidecar/sidecar.dart';

class Foo extends LintRule {
  @override
  LintCode get code => LintCode('Foo', package: 'sidecar_lints');

  @override
  void initializeVisitor(NodeRegistry registry) {}
}
''';
