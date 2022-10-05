import 'package:analyzer_plugin/channel/channel.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../../../sidecar_analyzer_plugin_core.dart';
import '../../context_services/analysis_errors.dart';
import '../../reports/file_report_notifier.dart';
import '../../services/analysis_context_collection_service/analysis_context_collection_service.dart';
import '../../services/error_reporter/error_reporter.dart';
import '../../services/log_delegate/log_delegate.dart';
import '../../services/project_configuration_service/providers.dart';
import '../../services/resolved_unit_service/resolved_unit_service.dart';
import '../activated_rules/activated_rules_notifier.dart';
import '../annotations/file_annotations_notifier.dart';
import 'file_report_provider.dart';

class AnalysisNotifier extends StateNotifier<AsyncValue<List<AnalysisResult>>> {
  AnalysisNotifier(
    this.ref, {
    required this.analyzedFile,
  }) : super(const AsyncValue.loading());

  final Ref ref;

  final AnalyzedFile analyzedFile;

  LogDelegateBase get delegate => ref.read(logDelegateProvider);
  PluginCommunicationChannel get channel => ref.read(pluginChannelProvider);

  FileReportNotifier get reporter =>
      ref.read(fileReportProvider(analyzedFile).notifier);

  Future<void> initializeAnnotations() async {}

  Future<void> refreshAnalysis() async {
    state = const AsyncLoading();
    //TODO: allow analysis of other file extensions
    if (analyzedFile.isDartFile) {
      reporter
        ..start()
        ..recordUnitStart();

      final unit = await ref
          .read(resolvedUnitServiceProvider(analyzedFile))
          .getResolvedUnit();

      reporter.recordUnitResolved();
      if (unit == null) {
        return;
      }

      ref.read(annotationsNotifierProvider(analyzedFile).notifier).refresh();

      reporter.recordLintsStarted();
      final errorReporter = ErrorReporter(ref, analyzedFile);

      final context = ref
          .read(analysisContextCollectionServiceProvider)
          .getContextFromRoot(analyzedFile.contextRoot);

      final allRules =
          ref.read(activatedRulesNotifierProvider(context.contextRoot)).rules;

      await Future.wait(
          allRules.whereType<LintRule>().map<Future<void>>((rule) async {
        if (!_isPathIncludedForRule(rule: rule, path: analyzedFile.path)) {
          return;
        }

        try {
          final results =
              await errorReporter.generateDartAnalysisResults(unit, rule);

          state = AsyncValue.data(List<AnalysisResult>.from(
              <AnalysisResult>[...?state.value, ...results]));
        } catch (e, stackTrace) {
          delegate.sidecarError('LintRule Error: ${e.toString()}', stackTrace);
        }
      }));

      reporter.recordLintsCompleted();
      reporter.complete(state.asData?.value ?? []);

      delegate.sidecarVerboseMessage(
          'analyzeFile completed w/ ${allRules.length} rules: ${analyzedFile.relativePath}');
    } else {
      // set all non-Dart files to having no errors
      state = const AsyncValue.data([]);
    }
  }

  bool _isPathIncludedForRule({
    required String path,
    required SidecarBase rule,
  }) {
    final context = ref
        .read(analysisContextCollectionServiceProvider)
        .getContextFromRoot(analyzedFile.contextRoot);

    final relativePath = p.relative(path, from: context.contextRoot.root.path);

    // #1 check explicit LintRule/CodeEdit includes from project config
    final projectConfig =
        ref.read(projectConfigurationProvider(context.contextRoot));

    final ruleConfig = projectConfig?.getConfiguration(rule.id);

    if (ruleConfig != null && ruleConfig.includes != null) {
      return ruleConfig.includes!.any((glob) => glob.matches(relativePath));
    }

    // #2 check default LintRule/CodeEdit includes from lint/edit definition
    if (rule.includes != null) {
      return rule.includes!.any((glob) => glob.matches(relativePath));
    }

    // TODO: #3 check explicit LintPackage includes from project config
    // TODO: #4 check default LintPackage includes from LintPackage definition

    // #5 check project configuration
    return projectConfig?.includes(relativePath) ?? false;
  }
}

final analysisNotifierProvider = StateNotifierProvider.family<AnalysisNotifier,
    AsyncValue<List<AnalysisResult>>, AnalyzedFile>((ref, analyzedFile) {
  final analysisNotifier = AnalysisNotifier(ref, analyzedFile: analyzedFile);

  ref.listen<List<SidecarAnnotatedNode>>(
      annotationsAggregateProvider(analyzedFile.contextRoot), (previous, next) {
    analysisNotifier.refreshAnalysis();
  });
  return analysisNotifier;
});
