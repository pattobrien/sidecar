import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;

import '../../../rules/rules.dart';
import '../../analyzer/ast/registered_rule_visitor.dart';
import '../../configurations/configurations.dart';
import '../../utils/duration_ext.dart';
import 'expected_lint.dart';

Future<void> testFile(
  Rule rule,
  String content,
  List<ExpectedLint> expectedResults, {
  String relativePath = 'test/example/lib/main.dart',
}) async {
  final watch = Stopwatch()..start();
  final resourceProvider = PhysicalResourceProvider.INSTANCE;
  final sidecarSpec = SidecarSpec.fromRuleCodes([rule.code]);

  final registry = NodeRegistry({rule});
  final visitor = RegisteredRuleVisitor(registry);

  final path = p.absolute(relativePath);

  final a1 = Stopwatch()..start();
  final f = await resolveFile2(path: path, resourceProvider: resourceProvider);
  print(a1.elapsed.prettified());
  final resolvedUnit = f as ResolvedUnitResult;

  rule.setUnitContext(resolvedUnit);
  rule.setConfig(sidecarSpec: sidecarSpec);

  resolvedUnit.unit.accept(visitor);
  print(watch.elapsed.prettified());
  final results = visitor.lintResults;
  final watch2 = Stopwatch()..start();
  resourceProvider.getFile(path).writeAsStringSync(content);
  final a2 = Stopwatch()..start();
  final f2 = await resolveFile2(path: path, resourceProvider: resourceProvider);
  print(a2.elapsed.prettified());
  final resolvedUnit2 = f2 as ResolvedUnitResult;

  rule.setUnitContext(resolvedUnit2);
  rule.setConfig(sidecarSpec: sidecarSpec);

  resolvedUnit2.unit.accept(visitor);
  print(watch2.elapsed.prettified());
}
