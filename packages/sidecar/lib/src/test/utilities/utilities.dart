import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import '../../../rules/rules.dart';
import '../../analyzer/ast/registered_rule_visitor.dart';
import '../../configurations/configurations.dart';
import '../../protocol/models/models.dart';
import 'expected_lint.dart';

Future<void> testLint(
  Rule rule,
  String content,
  List<ExpectedLint> expectedResults, {
  String relativePath = 'test/example/lib/main.dart',
}) async {
  final resourceProvider = PhysicalResourceProvider.INSTANCE;
  final sidecarSpec = SidecarSpec.fromRuleCodes([rule.code]);

  final registry = NodeRegistry({rule});
  final visitor = RegisteredRuleVisitor(registry);

  final path = p.absolute(relativePath);
  resourceProvider.getFile(path).writeAsStringSync(content);
  final f = await resolveFile2(path: path, resourceProvider: resourceProvider);
  final resolvedUnit = f as ResolvedUnitResult;

  rule.setUnitContext(resolvedUnit);
  rule.setConfig(sidecarSpec: sidecarSpec);

  resolvedUnit.unit.accept(visitor);

  final results = visitor.lintResults.map((e) => e.toExpectedLint()).toList();

  // for (final expectedResult in expectedResults) {
  // use anyElement or unorderedEquals from package:matcher
  expect(results, unorderedEquals(expectedResults));
  // }
}

extension _ on LintResult {
  ExpectedLint toExpectedLint() =>
      ExpectedLint(rule, span.start.offset, span.length);
}
