import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/channel/channel.dart' as plugin;

import 'package:hotreloader/hotreloader.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_analyzer_plugin_core/src/context_services/queued_files.dart';

import '../context_services/context_services.dart';

import '../constants.dart';
import '../log_delegate/log_delegate.dart';
import 'analyzer_mode.dart';
import '../utils/utils.dart';

import 'package:path/path.dart' as p;

final pluginProvider = Provider((ref) => SidecarAnalyzerPlugin(ref));

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin(
    this._ref, {
    ResourceProvider? resourceProvider,
  }) : super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? _reloader;
  final initializationCompleter = Completer();
  final Ref _ref;

  @override
  String get name => pluginName;

  @override
  String get version => pluginVersion;

  @override
  List<String> get fileGlobsToAnalyze => pluginGlobs;
  // Future<void> get isInitialized => _initializationCompleter.future;
  SidecarAnalyzerMode get mode => _ref.read(sidecarAnalyzerMode);
  LogDelegateBase get delegate => _ref.read(logDelegateProvider);

  AnalysisContextService getAnalysisContextService(AnalysisContext context) =>
      _ref.read(analysisContextServiceProvider(context));

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    if (mode.isDebug) _startWithHotReload(channel);
    super.start(channel);
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    _reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        channel.sendNotification(
          plugin.Notification('sidecar.auto_reload', {}),
        );
      }
    });
    // _initializationCompleter.complete();
  }

  Future<void> reload() async {
    delegate.sidecarVerboseMessage('reload request received');
    // await _initializationCompleter.future;
    await _reloader?.reloadCode();
    delegate.sidecarVerboseMessage('reload request completed');
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    delegate.sidecarVerboseMessage('afterNewContextCollection');
    await Future.wait(contextCollection.contexts.map<Future<void>>(
      (context) async {
        await _ref
            .read(projectConfigurationServiceProvider(context.contextRoot))
            .parse();

        _ref
            .read(analysisContextServiceProvider(context))
            .initializeLintsAndEdits();
        if (mode.isCli) {
          _ref.read(analysisContextServiceProvider(context)).queueFiles();
        }
        delegate.sidecarMessage('completed: ${context.contextRoot.root.path}');
      },
    ));

    delegate.sidecarVerboseMessage('afterNewContextCollection complete');
    return super
        .afterNewContextCollection(contextCollection: contextCollection);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    if (!analysisContext.isSidecarEnabled) return;
    final analysisContextService = getAnalysisContextService(analysisContext);

    try {
      final errors = await analysisContextService.getAnalysisErrors(path);
      final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();
      channel.sendNotification(notif);
    } catch (e, stackTrace) {
      delegate.sidecarError(
          'error analyzing $path -- ${e.toString()}', stackTrace);
      channel.sendError('error analyzing $path -- ${e.toString()}', stackTrace);
    }
    if (mode.isCli) {
      if (_ref
          .read(queuedFilesProvider(analysisContext.contextRoot))
          .paths
          .isEmpty) {
        initializationCompleter.complete();
      }
    }
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    final filePath = parameters.file;
    final offset = parameters.offset;

    final unit = await getResolvedUnitResult(filePath);
    final context = unit.session.analysisContext;

    final analyzedFile = AnalyzedFile(context.contextRoot, filePath);

    final analysisResults =
        _ref.read(analysisResultsProvider(analyzedFile)).where((element) {
      final isWithinOffset = element.isWithinOffset(filePath, offset);
      final isLintRule = element.rule is LintRule;
      return isWithinOffset && isLintRule;
    });
    final analysisErrorFixes = await Future.wait<plugin.AnalysisErrorFixes>(
      analysisResults.map(
        (e) => e.rule.computeSourceChanges(e).then(
              (value) => plugin.AnalysisErrorFixes(
                e.toAnalysisError()!,
                fixes: value.map((e) => e.toPrioritizedSourceChange()).toList(),
              ),
            ),
      ),
    );

    return plugin.EditGetFixesResult(analysisErrorFixes);
  }

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    plugin.EditGetAssistsParams parameters,
  ) async {
    final filePath = parameters.file;
    final offset = parameters.offset;
    final length = parameters.length;

    if (p.extension(filePath) == '.dart') {
      final unit = await getResolvedUnitResult(filePath);
      final context = unit.session.analysisContext;
      final analysisContextService = getAnalysisContextService(context);

      final edits =
          await analysisContextService.getCodeAssists(unit, offset, length);

      return plugin.EditGetAssistsResult(edits.toList());
    }
    return plugin.EditGetAssistsResult([]);
  }
}
