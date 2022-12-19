// ignore_for_file: prefer_asserts_with_message

import 'dart:io' as io;

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
import '../../utils/file_paths.dart';
import '../../utils/get_sdk.dart';
import '../../utils/uri_ext.dart';
import 'expected_lint.dart';

@isTest
Future<void> ruleTest(
  String description,
  String content,
  List<ExpectedText> expectedResults, {
  String relativePath = '.dart_tool/sidecar_tests/lib/main.dart',
}) async {
  assert(expectedResults.every((e) => e.length == null) ||
      expectedResults.every((e) => e.length != null));
  assert(expectedResults.every((e) => e.offset == null) ||
      expectedResults.every((e) => e.offset != null));
  assert(expectedResults.every((e) => e.startColumn == null) ||
      expectedResults.every((e) => e.startColumn != null));
  assert(expectedResults.every((e) => e.startLine == null) ||
      expectedResults.every((e) => e.startLine != null));

  test.test(description, () async {
    final path = p.absolute(relativePath);
    await modifyFile(relativePath, content: content);

    final resolvedUnit = await context.currentSession.getResolvedUnit(path)
        as ResolvedUnitResult;

    for (final rule in registry.rules) {
      rule.setUnitContext(resolvedUnit);
    }

    resolvedUnit.unit.accept(visitor);

    final results = visitor.lintResults.map((e) => e.toExpectedText()).toList();
    test.expect(results, test.unorderedEquals(expectedResults));
  });
}

void setUpRules(List<Rule> rules) {
  setUpAll(() async {
    resourceProvider = PhysicalResourceProvider.INSTANCE;
    sidecarSpec = SidecarSpec.fromRuleCodes(rules.map((r) => r.code).toList());

    registry = NodeRegistry(rules.toSet());
    visitor = RegisteredRuleVisitor(registry);

    for (final rule in rules) {
      rule.setConfig(sidecarSpec: sidecarSpec);
    }

    final rootUri = io.Directory.current.uri;
    final testRoot = p.join(rootUri.path, kDartTool, 'sidecar_tests');
    final file = resourceProvider.getFile(p.join(testRoot, 'lib', 'main.dart'));
    file.parent.create();
    file.writeAsStringSync('');
    context = _createAnalysisContext(file.toUri(),
        resourceProvider: resourceProvider, root: rootUri);

    context.currentSession.analysisContext.changeFile(file.path);
    await context.currentSession.analysisContext.applyPendingFileChanges();

    // used to warm up the analyzer
    await context.currentSession.getResolvedUnit(file.path);
  });
}

late ResourceProvider resourceProvider;
late SidecarSpec sidecarSpec;
late NodeRegistry registry;
late RegisteredRuleVisitor visitor;
late AnalysisContext context;

Future<void> modifyFile(String relativePath, {required String content}) async {
  final path = p.absolute(relativePath);
  final file = resourceProvider.getFile(path);
  if (!file.exists) file.parent.create();
  file.writeAsStringSync(content);

  context.currentSession.analysisContext.changeFile(path);
  await context.currentSession.analysisContext.applyPendingFileChanges();
}

// void ruleTearDown() => tearDownAll(() {});

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
//   context = _createAnalysisContext(
//       path: path, resourceProvider: resourceProvider, packageRoot: packageRoot);
  return context.currentSession.getResolvedUnit(path);
}

/// Return a newly create analysis context in which the file at the given [path]
/// can be analyzed.
///
/// If a [resourceProvider] is given, it will be used to access the file system.
AnalysisContext _createAnalysisContext(
  Uri testRoot, {
  ResourceProvider? resourceProvider,
  required Uri root,
}) {
  final collection = AnalysisContextCollection(
      includedPaths: <String>[testRoot.pathNoTrailingSlash],
      resourceProvider: resourceProvider ?? PhysicalResourceProvider.INSTANCE,
      sdkPath: getDartSdkPathForPackage(
          root, resourceProvider ?? PhysicalResourceProvider.INSTANCE));
  final contexts = collection.contexts;
  if (contexts.length != 1) {
    throw ArgumentError('path must be an absolute path to a single file');
  }
  return contexts[0];
}
