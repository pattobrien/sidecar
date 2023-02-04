import 'dart:async';
import 'dart:developer';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../../context/context.dart';
import '../../protocol/models/analysis_results.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../../server/communication_channel.dart';
import '../../services/file_analyzer_service_impl.dart';
import '../../utils/utils.dart';
import '../analyzer_logger.dart';
import '../ast/registered_rule_visitor.dart';
import '../context/context.dart';
import '../sidecar_analyzer.dart';
import 'providers.dart';

/// Analyze a Dart file and generate the Element/ASTNode/Type structures.
final resolvedUnitForFileProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>((ref, file) async {
  if (!file.isDartFile && !file.isSidecarYamlFile) return null;

  final context = ref.watch(_contextForFileProvider(file));
  if (context == null) return null;

  final result = await context.currentSession.getResolvedUnit(file.path);
  return result as ResolvedUnitResult;
});

final _contextForFileProvider =
    Provider.family<AnalysisContext?, AnalyzedFile>((ref, file) {
  final contexts = ref.watch(contextCollectionProvider);
  return contexts.contextForRoot(file.contextRoot);
});

final sidecarContextProvider =
    Provider.family<SidecarContext?, AnalyzedFile>((ref, file) {
  final context = ref.watch(_contextForFileProvider(file));
  if (context == null) return null;

  final sidecarSpec = ref.watch(projectSidecarSpecProvider);
  final targetUri = ref.watch(activeTargetRootProvider);

  return SidecarContextImpl(context, sidecarSpec, targetUri: targetUri);
});

/// Compute and cache lint results for a given file.
final lintResultsProvider =
    FutureProvider.family<LintResults, AnalyzedFile>((ref, file) async {
  final fileService = ref.watch(fileAnalyzerServiceProvider);
  final rulesForFile = ref.watch(scopedLintRulesForFileProvider(file));
  final registry = ref.watch(nodeRegistryForFileLintsProvider(file));
  final logger = ref.watch(loggerProvider);

  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);

  final results = fileService.visitLintResults(unit, rulesForFile, registry);

  for (final rule in rulesForFile) {
    logger.finest(ShortRuleLog(rule.code,
        '${results.where((e) => e.code == rule.code).length} lint results ${file.relativePath}'));
  }
  logger.finer('${results.length} lint results ${file.relativePath}');

  final channel = ref.watch(communicationChannelProvider);
  if (ref.state.value != results) {
    channel.sendNotification(LintNotification(file, results));
  }
  return results;
});

/// Locate all QuickAssist nodes for which code edits can be calculated from.
///
/// As opposed to the AssistResults, which are calculated on-demand based on
/// an IDE client's cursor offset/length, AssistFilters are outputs of an
/// ASTNode scan which is generated pro-actively.
final assistFiltersProvider =
    FutureProvider.family<Set<AssistResult>, AnalyzedFile>((ref, file) async {
  final rules = ref.watch(scopedAssistRulesForFileProvider(file));
  final fileService = ref.watch(fileAnalyzerServiceProvider);
  final registry = ref.watch(nodeRegistryForFileAssistsProvider(file));
  final logger = ref.watch(loggerProvider);

  final unit = await ref.watch(resolvedUnitForFileProvider(file).future);

  final results = fileService.visitAssistFilters(unit, rules, registry);

  for (final rule in rules) {
    logger.finest(ShortRuleLog(rule.code,
        '${results.where((e) => e.code == rule.code).length} assist results ${file.relativePath}'));
  }
  logger.finer('${results.length} assist results ${file.relativePath}');

  return results;
});

/// Compute all quick fixes from applicable Lint results.
final quickFixResultsProvider =
    FutureProvider.family<List<LintWithEditsResult>, AnalyzedFile>(
        (ref, file) async {
  final lints = ref.watch(lintResultsProvider(file).select((v) => v.value));
  final lintResults = lints?.where((e) => e.editsComputer != null);
  final logger = ref.watch(loggerProvider);

  final results =
      await Future.wait<LintWithEditsResult>(lintResults?.map((e) async {
            final edits = await e.editsComputer!();
            return e.copyWithEdits(edits: edits);
          }) ??
          []);

  final rules =
      ref.watch(scopedLintRulesForFileProvider(file)).whereType<QuickFix>();
  for (final rule in rules) {
    logger.finest(ShortRuleLog(rule.code,
        '${results.where((e) => e.code == rule.code).length} quickfix results ${file.relativePath}'));
  }
  logger.finer('${results.length} quickfix results ${file.relativePath}');

  return results;
});

/// Compute all data results from applicable results.
final dataResultsProvider =
    Provider.family<Set<SingleDataResult>, AnalyzedFile>((ref, file) {
  final fileService = ref.watch(fileAnalyzerServiceProvider);
  final registry = ref.watch(nodeRegistryForFileDataProvider(file));
  final rulesForFile = ref.watch(scopedDataRulesForFileProvider(file));

  final unit = ref.watch(resolvedUnitForFileProvider(file)).valueOrNull;
  return fileService.visitDataResults(unit, rulesForFile, registry);
});

final totalDataResultsProvider = Provider<Set<TotalDataResult>>((ref) {
  final files = ref.watch(activeProjectScopedFilesProvider);
  final allDataResults = <SingleDataResult>[];

  for (final file in files) {
    final data = ref.watch(dataResultsProvider(file));
    allDataResults.addAll(data);
  }

  final totalDataResults = <TotalDataResult>{};

  for (final dataRule in allDataResults.map((e) => e.code).toSet()) {
    final results = allDataResults.where((r) => r.code == dataRule);
    totalDataResults.add(TotalDataResult(
        code: dataRule, data: results.map<Object>((e) => e.data).toList()));
  }
  return totalDataResults;
});
