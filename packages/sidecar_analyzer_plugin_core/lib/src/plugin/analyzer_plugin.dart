import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:hotreloader/hotreloader.dart';
import 'package:riverpod/riverpod.dart';

import 'package:sidecar/sidecar.dart';

import '../context_services/context_services.dart';

import '../constants.dart';
import '../log_delegate/log_delegate.dart';
import 'analyzer_mode.dart';

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
  // final _initializationCompleter = Completer();
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
            .initializeLintsAndEdits(context);
        delegate.sidecarMessage('completed: ${context.contextRoot.root.path}');
      },
    ));

    delegate.sidecarVerboseMessage('afterNewContextCollection complete');
    await super.afterNewContextCollection(contextCollection: contextCollection);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    final analysisContextService = getAnalysisContextService(analysisContext);

    // try {
    final errors = await analysisContextService.getAnalysisErrors(path);
    final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();
    channel.sendNotification(notif);
    // } catch (e, stackTrace) {
    //   delegate.sidecarError(
    //       'error analyzing $path -- ${e.toString()}', stackTrace);
    //   channel.sendError('error analyzing $path -- ${e.toString()}', stackTrace);
    // }
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    final filePath = parameters.file;
    final offset = parameters.offset;

    final unit = await getResolvedUnitResult(filePath);
    final context = unit.session.analysisContext;
    final analysisContextService = getAnalysisContextService(context);

    final detectedLints = await analysisContextService
        .computeLints(filePath)
        .then((value) => value.where(
            (detectedLint) => detectedLint.isWithinOffset(filePath, offset)));

    final analysisErrorFixes = await Future.wait<plugin.AnalysisErrorFixes>(
      detectedLints.map((e) async => await e.computeAnalysisErrorFixes(_ref)),
    );

    return plugin.EditGetFixesResult(analysisErrorFixes);
  }

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    EditGetAssistsParams parameters,
  ) async {
    final filePath = parameters.file;
    final offset = parameters.offset;
    final length = parameters.length;

    final unit = await getResolvedUnitResult(filePath);
    final context = unit.session.analysisContext;
    final analysisContextService = getAnalysisContextService(context);

    final edits =
        analysisContextService.getCodeEditRequests(unit, offset, length);

    final changes = await Future.wait<plugin.PrioritizedSourceChange?>(
      edits.map((e) async => await e.toPrioritizedSourceChange(_ref)),
    );

    return EditGetAssistsResult(
      changes.whereType<plugin.PrioritizedSourceChange>().toList(),
    );
  }
}
