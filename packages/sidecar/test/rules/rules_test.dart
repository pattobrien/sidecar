import 'package:intl_lints/intl_lints.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('BaseRule SidecarAstVisitor rule equality:', () {
    test('2 instance of the same rule', () {
      final someRule = AvoidStringLiteral();
      final rule2 = AvoidStringLiteral();
      expect(someRule, equals(rule2));
    });

    test('2 instance of the same rule (hashcode)', () {
      final someRule = AvoidStringLiteral();
      final rule2 = AvoidStringLiteral();
      expect(someRule.hashCode, equals(rule2.hashCode));
    });

    test('2 instance of the different rules', () {
      //TODO
    });

    test('2 instance of the different rules (hashcode)', () {
      //TODO
    });
  });
}
