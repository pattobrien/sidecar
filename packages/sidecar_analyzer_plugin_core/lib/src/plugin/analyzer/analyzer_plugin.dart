import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:hotreloader/hotreloader.dart';
import 'package:riverpod/riverpod.dart';

import '../../constants.dart';
import '../../services/log_delegate/log_delegate.dart';

import '../analyzer_mode.dart';
import '../protocol/isolate_communication_protocol.dart';
import 'activated_rules_provider.dart';
import 'active_context_provider.dart';
import 'plugin_contexts_provider.dart';
import 'resolved_unit_provider.dart';
import 'rule_constructors_provider.dart';

final pluginProvider = Provider(
  SidecarAnalyzerPlugin.new,
  dependencies: [
    activatedRulesProvider,
    // analysisErrorsProvider,
    // projectConfigurationServiceProvider,
    // analysisContextServiceProvider,
    // analysisContextsProvider,
    logDelegateProvider,
    ruleConstructorProvider,
    sidecarAnalyzerMode,
  ],
);

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin(
    this.ref, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  final initializationCompleter = Completer<void>();
  final Ref ref;

  @override
  String get name => kSidecarPluginName;

  @override
  String get version => pluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => pluginGlobs;

  SidecarAnalyzerMode get mode => ref.read(sidecarAnalyzerMode);

  void _log(String message) => ref.read(logDelegateProvider).sidecarMessage;
  void _logError(Object e, [StackTrace? stackTrace]) =>
      ref.read(logDelegateProvider).sidecarError;

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    _log('END PLUGIN STARTING....');
    _log('# of rules to activate: ${ref.read(ruleConstructorProvider).length}');
    if (mode.isDebug) _startWithHotReload(channel);
    super.start(channel);
    channel.sendNotification(
      plugin.Notification(kInitializationCompleteMethod, {}),
    );
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        channel.sendNotification(
          plugin.Notification(kSidecarHotReloadMethod, {}),
        );
      }
    });
  }

  Future<void> reload() async {
    await _reloader?.reloadCode();
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    try {
      _log('ISOLATE: afterNewContextCollection');
      ref.invalidate(allAnalysisContextsProvider);
      ref.read(allAnalysisContextsProvider.state).state =
          contextCollection.contexts;

      _log('afterNewContextCollection complete');
      if (!initializationCompleter.isCompleted) {
        initializationCompleter.complete();
      }
      // await Future.wait(contextCollection.contexts.map((context) async {
      //   ref.read(activatedRulesProvider(context.contextRoot));
      // }));

      return super
          .afterNewContextCollection(contextCollection: contextCollection);
    } catch (e, stackTrace) {
      _logError('afterNewContextCollection err -- $e', stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> analyzeFiles({
    required AnalysisContext analysisContext,
    required List<String> paths,
  }) async {
    ref.read(activePluginContextsProvider.notifier).update(analysisContext);
    for (final path in paths) {
      ref.refresh(resolvedUnitProvider(path));
    }
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    // // TODO: implement analyzeFile
    // throw UnimplementedError();
  }

  // @override
  // Future<void> analyzeFile({
  //   required AnalysisContext analysisContext,
  //   required String path,
  // }) async {
  //   try {
  //     // final enabledContexts = ref.read(analysisContextsProvider);
  //     // if (enabledContexts.entries.every((enabledContext) =>
  //     //     analysisContext.contextRoot.root.path !=
  //     //     enabledContext.value.contextRoot.root.path)) {
  //     //   // dont analyze
  //     //   delegate.sidecarMessage('ISOLATE: skip analyzeFile $path');

  //     //   channel.sendNotification(
  //     //       plugin.AnalysisErrorsParams(path, []).toNotification());
  //     //   return;
  //     // }
  //     // delegate.sidecarMessage('ISOLATE: analyzeFile $path');
  //     //  ResolvedUnitResult  unit;
  //     // final analyzedFile = AnalyzedFile(analysisContext.contextRoot, path);
  //     try {
  //       final contextRoot = analysisContext.contextRoot;
  //       final analyzedFile = AnalyzedFile(analysisContext.contextRoot, path);
  //       final errorReporter = ErrorReporter(ref, analyzedFile);
  //       final rules = ref.read(activatedRulesProvider(contextRoot));
  //       // final unit = await getResolvedUnitResult(path);
  //       // change this to use analysis cntext
  //       final unit = await analysisContext.currentSession.getResolvedUnit(path);
  //       if (unit is! ResolvedUnitResult) return;

  //       final results =
  //           await Future.wait(rules.whereType<LintRule>().map((rule) async {
  //         return errorReporter.generateDartAnalysisResults(unit, rule);
  //       }));

  //       final analysisErrors = results
  //           .expand((element) => element)
  //           .map((e) => e.toAnalysisError()!)
  //           .toList();
  //       // final analyzedFileService =
  //       //     ref.read(analyzedFileServiceProvider(analyzedFile));
  //       // final analysisResults =
  //       //     await ref.read(analysisErrorsProvider(analyzedFile).future);
  //       // await analyzedFileService.computeAnalysisResults(analyzedFile);
  //       // final results =
  //       //     await ref.watch(analysisErrorsProvider(analyzedFile).future);
  //       channel.sendNotification(
  //           plugin.AnalysisErrorsParams(path, analysisErrors).toNotification());
  //     } on InconsistentAnalysisException catch (e, stackTrace) {
  //       _log('ISOLATE ERROR: analyzeFile $path $e ${stackTrace.toString()}');
  //     }
  //   } catch (e, stackTrace) {
  //     _log('ISOLATE ERROR: analyzeFile $path $e ${stackTrace.toString()}');
  //     // rethrow;
  //   }
  // }

  // @override
  // Future<plugin.EditGetFixesResult> handleEditGetFixes(
  //   plugin.EditGetFixesParams parameters,
  // ) async {
  //   final path = parameters.file;
  //   final offset = parameters.offset;
  //   try {
  //     final contexts = await ref.read(enabledContextsProvider.future);
  //     final context = contexts
  //         .firstWhere((element) => element.contextRoot.isAnalyzed(path));
  //     final analyzedFile = AnalyzedFile(context.contextRoot, path);
  //     final editRequest = EditRequest(offset: offset, file: analyzedFile);

  //     final fixes =
  //         await ref.read(analysisErrorFixesProvider(editRequest).future);

  //     return plugin.EditGetFixesResult(fixes);
  //   } catch (e, stackTrace) {
  //     delegate.sidecarError('handleEditGetFixes $path -- $e', stackTrace);
  //     rethrow;
  //   }
  // }

  // @override
  // Future<plugin.EditGetAssistsResult> handleEditGetAssists(
  //   plugin.EditGetAssistsParams parameters,
  // ) async {
  //   final path = parameters.file;
  //   final offset = parameters.offset;
  //   final length = parameters.length;
  //   try {
  //     // final context = ref
  //     //     .read(analysisContextCollectionServiceProvider)
  //     //     .getContextFromPath(path);

  //     // final results = await ref
  //     //     .read(analysisContextServiceProvider(context))
  //     //     .getCodeAssists(path, offset, length);
  //     final results = <plugin.PrioritizedSourceChange>[];

  //     return plugin.EditGetAssistsResult(results.toList());
  //   } catch (e, stackTrace) {
  //     delegate.sidecarError('handleEditGetAssists $path -- $e', stackTrace);
  //     rethrow;
  //   }
  // }
}
