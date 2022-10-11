import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';

import '../services/error_reporter/error_reporter.dart';
import 'analyzed_file.dart';

@immutable
class AnalyzedFileService {
  const AnalyzedFileService(
    this.ref, {
    required this.context,
    required this.unitResult,
    required this.activatedRules,
    required this.projectConfiguration,
  });

  final Ref ref;
  final AnalysisContext context;
  final ResolvedUnitResult? unitResult;
  final List<SidecarBase> activatedRules;
  final ProjectConfiguration projectConfiguration;

  ContextRoot get root => context.contextRoot;

  Future<Iterable<AnalysisResult>> computeAnalysisResults(
    AnalyzedFile file,
  ) async {
    final analysisPath = root.optionsFile?.path;

    if (file.path == analysisPath) {
      //TODO: reimplement analysis file errors

      // return ref.read(projectConfigurationAnalysisErrorProvider(root).future);
      return [];
      // throw UnimplementedError();
    }
    // delegate.sidecarMessage(
    //     'analyzeFile STARTING for ${analyzedFile.relativePath}');
    //TODO: allow analysis of other file extensions
    if (file.isDartFile) {
      // TODO: handle below return better
      if (unitResult == null) return [];
      // reporter
      //   ..start()
      //   ..recordUnitStart();

      // reporter.recordUnitResolved();

      // reporter.recordLintsStarted();
      final errorReporter = ErrorReporter(ref, file);

      final results = await Future.wait(activatedRules
          .whereType<LintRule>()
          .map<Future<List<AnalysisResult>>>((rule) {
        if (!_isPathIncludedForRule(rule: rule, path: file.path)) {
          return Future.value([]);
        }

        try {
          return errorReporter.generateDartAnalysisResults(unitResult!, rule);
        } catch (e, stackTrace) {
          // delegate.sidecarError('LintRule Error: ${e.toString()}', stackTrace);
          return Future.value([]);
        }
      }));

      final sortedResults = results.expand((element) => element).toList()
        ..sort((a, b) => a.sourceSpan.location.startLine
            .compareTo(b.sourceSpan.location.startLine));
      return sortedResults;
      // reporter.recordLintsCompleted();
      // reporter.complete(state.asData?.value ?? []);

      // delegate.sidecarMessage(
      //     'analyzeFile completed w/ ${allRules.length} rules, ${state.value?.length ?? 0} errors: ${analyzedFile.relativePath}');
    } else {
      // TODO: handle non-Dart files
      return Future.value([]);
    }
  }

  bool _isPathIncludedForRule({
    required String path,
    required SidecarBase rule,
  }) {
    // final context = ref
    //     .read(enabledContextServiceProvider)
    //     .getContextFromRoot(analyzedFile.contextRoot);

    final relativePath = p.relative(path, from: context.contextRoot.root.path);

    // #1 check explicit LintRule/CodeEdit includes from project config
    final ruleConfig = projectConfiguration.getConfiguration(rule.id);

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
    return projectConfiguration.includes(relativePath);
  }

  Iterable<AnalysisResult> calculateAnalysisResultsAtOffset(
    Iterable<AnalysisResult> analysisResults,
    String path,
    int offset,
  ) {
    return analysisResults.where((analysisResult) {
      return analysisResult.isWithinOffset(path, offset) &&
          analysisResult.rule is LintRule;
    });
  }

  Future<Iterable<EditResult>> calculateEditResults(
    Iterable<AnalysisResult> filteredAnalysisResults,
    String path,
    int offset,
  ) async {
    final results = await Future.wait<List<EditResult>>(filteredAnalysisResults
        .map((e) => e.rule.computeSourceChanges(context.currentSession, e)));
    return results.expand((element) => element);
  }

  // Future<List<AnalysisResult>> getAssistResults() {
  //   //
  // }
}
