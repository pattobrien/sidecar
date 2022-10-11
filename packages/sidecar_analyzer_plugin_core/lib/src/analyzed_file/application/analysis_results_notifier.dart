// import 'package:path/path.dart' as p;
// import 'package:riverpod/riverpod.dart';
// import 'package:sidecar/builder.dart';

// import '../../analysis_context/resolved_unit_service.dart';
// import '../../analysis_context_collection/enabled_contexts_provider.dart';
// import '../../application/analysis_results/file_report_provider.dart';
// import '../../analysis_context/file_annotations_provider.dart';
// import '../../application/rules/activated_rules_notifier.dart';
// import '../../reports/file_report_notifier.dart';
// import '../../services/error_reporter/error_reporter.dart';
// import '../../services/log_delegate/log_delegate.dart';
// import '../../services/project_configuration_service/providers.dart';
// import '../analyzed_file.dart';

// class AnalysisResultsNotifier
//     extends StateNotifier<AsyncValue<List<AnalysisResult>>> {
//   AnalysisResultsNotifier(
//     this.ref, {
//     required this.analyzedFile,
//   }) : super(const AsyncValue.loading());

//   final Ref ref;
//   final AnalyzedFile analyzedFile;

//   LogDelegateBase get delegate => ref.read(logDelegateProvider);

//   FileReportNotifier get reporter =>
//       ref.read(fileReportProvider(analyzedFile).notifier);

//   Future<void> refreshAnalysis() async {
    
//     // state = const AsyncLoading();
//     // delegate.sidecarMessage(
//     //     'analyzeFile STARTING for ${analyzedFile.relativePath}');
//     // //TODO: allow analysis of other file extensions
//     // if (analyzedFile.isDartFile) {
//     //   reporter
//     //     ..start()
//     //     ..recordUnitStart();

//     //   ref.invalidate(resolvedUnitProvider(analyzedFile));

//     //   final unit = await ref.read(resolvedUnitProvider(analyzedFile).future);
//     //   reporter.recordUnitResolved();

//     //   await ref.read(fileAnnotationProvider(analyzedFile).future);

//     //   reporter.recordLintsStarted();
//     //   final errorReporter = ErrorReporter(ref, analyzedFile);

//     //   final context = ref.read(analysisContextProvider(analyzedFile.path));

//     //   final allRules =
//     //       ref.read(activatedRulesNotifierProvider(context.contextRoot));

//     //   await Future.wait(
//     //       allRules.whereType<LintRule>().map<Future<void>>((rule) async {
//     //     if (!_isPathIncludedForRule(rule: rule, path: analyzedFile.path)) {
//     //       return;
//     //     }

//     //     try {
//     //       final results =
//     //           await errorReporter.generateDartAnalysisResults(unit, rule);

//     //       state = AsyncValue.data(List<AnalysisResult>.from(
//     //           <AnalysisResult>[...?state.value, ...results]));
//     //     } catch (e, stackTrace) {
//     //       delegate.sidecarError('LintRule Error: ${e.toString()}', stackTrace);
//     //     }
//     //   }));

//     //   reporter.recordLintsCompleted();
//     //   reporter.complete(state.asData?.value ?? []);

//     //   delegate.sidecarMessage(
//     //       'analyzeFile completed w/ ${allRules.length} rules, ${state.value?.length ?? 0} errors: ${analyzedFile.relativePath}');
//     // } else {
//     //   // set all non-Dart files to having no errors
//     //   state = const AsyncValue.data([]);
//     // }
//   }

// //   bool _isPathIncludedForRule({
// //     required String path,
// //     required SidecarBase rule,
// //   }) {
// //     final context = ref
// //         .read(enabledContextServiceProvider)
// //         .getContextFromRoot(analyzedFile.contextRoot);

// //     final relativePath = p.relative(path, from: context.contextRoot.root.path);

// //     // #1 check explicit LintRule/CodeEdit includes from project config
// //     final projectConfig =
// //         ref.read(projectConfigurationProvider(context.contextRoot));

// //     final ruleConfig = projectConfig?.getConfiguration(rule.id);

// //     if (ruleConfig != null && ruleConfig.includes != null) {
// //       return ruleConfig.includes!.any((glob) => glob.matches(relativePath));
// //     }

// //     // #2 check default LintRule/CodeEdit includes from lint/edit definition
// //     if (rule.includes != null) {
// //       return rule.includes!.any((glob) => glob.matches(relativePath));
// //     }

// //     // TODO: #3 check explicit LintPackage includes from project config
// //     // TODO: #4 check default LintPackage includes from LintPackage definition

// //     // #5 check project configuration
// //     return projectConfig?.includes(relativePath) ?? false;
// //   }
// // }

// final analysisNotifierProvider = StateNotifierProvider.family<
//     AnalysisResultsNotifier,
//     AsyncValue<List<AnalysisResult>>,
//     AnalyzedFile>((ref, analyzedFile) {
//   final analysisNotifier =
//       AnalysisResultsNotifier(ref, analyzedFile: analyzedFile);

//   ref.listen<List<SidecarAnnotatedNode>>(
//       fileAnnotationsAggregateProvider(analyzedFile.contextRoot),
//       (previous, next) {
//     // analysisNotifier.refreshAnalysis();
//   });
//   return analysisNotifier;
// });
