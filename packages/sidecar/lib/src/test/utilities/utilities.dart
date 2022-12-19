// ignore_for_file: prefer_asserts_with_message

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as p;
import 'package:test/scaffolding.dart';
import 'package:test/test.dart' as test;

import '../../../rules/rules.dart';
import '../../analyzer/ast/registered_rule_visitor.dart';
import '../../configurations/configurations.dart';
import '../../protocol/models/models.dart';
import '../../utils/get_sdk.dart';
import 'expected_lint.dart';

@isTest
Future<void> ruleTest(
  String description,
  Rule rule,
  String content,
  List<ExpectedText> expectedResults, {
  String relativePath = '.dart_tool/sidecar_test/lib/main.dart',
}) async {
  assert(expectedResults.every((e) => e.length == null) ||
      expectedResults.every((e) => e.length != null));
  assert(expectedResults.every((e) => e.offset == null) ||
      expectedResults.every((e) => e.offset != null));

  test.test(description, () async {
    final resourceProvider = PhysicalResourceProvider.INSTANCE;
    final sidecarSpec = SidecarSpec.fromRuleCodes([rule.code]);

    final registry = NodeRegistry({rule});
    final visitor = RegisteredRuleVisitor(registry);

    final path = p.absolute(relativePath);
    final file = resourceProvider.getFile(path);
    if (!file.exists) file.parent.create();

    file.writeAsStringSync(content);
    final f = await resolveFile2(
        path: path,
        resourceProvider: resourceProvider,
        packageRoot: Directory.current.uri);
    final resolvedUnit = f as ResolvedUnitResult;

    rule.setUnitContext(resolvedUnit);
    rule.setConfig(sidecarSpec: sidecarSpec);

    resolvedUnit.unit.accept(visitor);

    final results = visitor.lintResults.map((e) => e.toExpectedText()).toList();
    test.expect(results, test.unorderedEquals(expectedResults));
  });
}

@isTestGroup
void ruleTestGroup(Rule rule, dynamic Function() body) {
  return test.group('${rule.code.id}:', () {
    // setUpAll(() {});
    // tearDown(() {});
    body();
  });
}

// test.Matcher expectedResult({
//   String? expectedText,
//   String? offset,
// }) {

//     test.expect(results, test.unorderedEquals(expectedResults));
// }

extension _ on LintResult {
  ExpectedLint toExpectedLint() =>
      ExpectedLint(rule, span.start.offset, span.length);

  ExpectedText toExpectedText({
    bool withText = true,
    bool withOffset = false,
    bool withLength = false,
  }) =>
      ExpectedText(
        span.text,
        offset: withOffset ? span.start.offset : null,
        length: withLength ? span.length : null,
      );
}

/// Return the result of resolving the file at the given [path].
///
/// If a [resourceProvider] is given, it will be used to access the file system.
///
/// Note that if more than one file is going to be resolved then this function
/// is inefficient. Clients should instead use [AnalysisContextCollection] to
/// create one or more contexts and use those contexts to resolve the files.
Future<SomeResolvedUnitResult> resolveFile2({
  required String path,
  ResourceProvider? resourceProvider,
  required Uri packageRoot,
}) async {
  final context = _createAnalysisContext(
      path: path, resourceProvider: resourceProvider, packageRoot: packageRoot);
  return context.currentSession.getResolvedUnit(path);
}

/// Return a newly create analysis context in which the file at the given [path]
/// can be analyzed.
///
/// If a [resourceProvider] is given, it will be used to access the file system.
AnalysisContext _createAnalysisContext({
  required String path,
  ResourceProvider? resourceProvider,
  required Uri packageRoot,
}) {
  final collection = AnalysisContextCollection(
      includedPaths: <String>[path],
      resourceProvider: resourceProvider ?? PhysicalResourceProvider.INSTANCE,
      sdkPath: getDartSdkPathForPackage(
          packageRoot, resourceProvider ?? PhysicalResourceProvider.INSTANCE));
  final contexts = collection.contexts;
  if (contexts.length != 1) {
    throw ArgumentError('path must be an absolute path to a single file');
  }
  return contexts[0];
}
