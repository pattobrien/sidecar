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
import 'package:path/path.dart' as p;

import 'package:sidecar/sidecar.dart';

import '../context_services/context_services.dart';

import '../utils/channel_extension.dart';
import '../constants.dart';
import '../log_delegate/log_delegate.dart';
import 'plugin_mode.dart';
import 'plugin_providers.dart';

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin({
    required this.lintRuleConstructors,
    required this.codeEditConstructors,
    required SidecarAnalyzerPluginMode mode,
    DebuggerLogDelegate delegate = const DebuggerLogDelegate(),
    ResourceProvider? resourceProvider,
  })  : ref = ProviderContainer(
          overrides: [
            logDelegateProvider.overrideWithValue(delegate),
            pluginMode.overrideWithValue(mode),
          ],
        ),
        super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        );

  HotReloader? reloader;
  final reloadCompleter = Completer();

  SidecarAnalyzerPluginMode get mode => ref.read(pluginMode);
  LogDelegateBase get delegate => ref.read(logDelegateProvider);

  final ProviderContainer ref;
  final Map<Id, LintRuleConstructor> lintRuleConstructors;
  final Map<Id, CodeEditConstructor> codeEditConstructors;

  @override
  List<String> get fileGlobsToAnalyze =>
      <String>['**/*.dart', '**/*.arb', '**/*.yaml'];

  @override
  String get name => pluginName;

  @override
  String get version => pluginVersion;

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    ref.read(pluginChannelProvider.notifier).state = channel;
    super.start(channel);
    if (mode.isDebug) _startWithHotReload(channel);
  }

  Future<void> _startWithHotReload(
    plugin.PluginCommunicationChannel channel,
  ) async {
    reloader = await HotReloader.create(onAfterReload: (c) {
      if (c.result == HotReloadResult.Succeeded) {
        channel.sendNotification(
          plugin.Notification('sidecar.auto_reload', {}),
        );
      }
    });
    reloadCompleter.complete();
  }

  Future<void> reload() async {
    delegate.sidecarVerboseMessage('reload request received');
    await reloadCompleter.future;
    await reloader?.reloadCode();
    delegate.sidecarVerboseMessage('reload request completed');
  }

  @override
  Future<plugin.PluginShutdownResult> handlePluginShutdown(
    plugin.PluginShutdownParams parameters,
  ) async {
    await flushAnalysisState(elementModels: true);
    return super.handlePluginShutdown(parameters);
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    delegate.sidecarVerboseMessage('afterNewContextCollection');

    await Future.wait(contextCollection.contexts.map<Future<void>>(
      (context) async {
        await ref
            .read(projectConfigurationServiceProvider(context.contextRoot))
            .parse();
        _initializeLintsAndEdits(context);
      },
    ));

    delegate.sidecarVerboseMessage('afterNewContextCollection complete');
    await super.afterNewContextCollection(contextCollection: contextCollection);
  }

  void _initializeLintsAndEdits(
    AnalysisContext context,
  ) {
    final projectConfigurationService =
        ref.read(projectConfigurationServiceProvider(context.contextRoot));
    final projectConfig = projectConfigurationService.projectConfiguration;
    final root = context.contextRoot;
    final errorComposer = ref.read(errorComposerProvider(root));
    if (projectConfig == null) return;

    for (var lintRule in lintRuleConstructors.entries) {
      final lintRuleId = lintRule.key.id;
      final packageId = lintRule.key.packageId;

      final config = projectConfig.lintConfiguration(packageId, lintRuleId);
      final lint = lintRule.value();
      lint.initialize(configurationContent: config?.configuration, ref: ref);
      if (lint.errors?.isNotEmpty ?? false) {
        errorComposer.addErrors(lint.errors!);
      } else {
        final activateLints = ref.read(activatedLintsProvider(root));
        activateLints.addLint(lint);
      }
    }
    for (var codeEdit in codeEditConstructors.entries) {
      final edit = codeEdit.value();
      final config =
          projectConfig.editConfiguration(edit.packageName, edit.code);
      edit.initialize(configurationContent: config?.configuration, ref: ref);
      if (edit.errors != null) {
        errorComposer.addErrors(edit.errors!);
      } else {
        ref.read(activatedEditsProvider(root)).addEdit(edit);
      }
    }
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    final rootPath = analysisContext.contextRoot.root.path;
    final analysisPath = analysisContext.contextRoot.optionsFile?.path;
    final analysisContextService =
        ref.read(analysisContextServiceProvider(analysisContext));

    if (path == analysisPath) {
      // we handle analyzing the config file separately

    }

    if (!analysisContext.isSidecarEnabled) {
      // delegate.sidecarVerboseMessage(
      //     'analyzeFile: sidecar is not enabled in root dir: $rootPath     (file; $path)');
      return;
    }

    if (!p.isWithin(rootPath, path)) {
      delegate.sidecarVerboseMessage(
          'analyzeFile: file is not within root path    (file: $path) (root: $rootPath)');
      return;
    }
    try {
      final errors = await analysisContextService.getAnalysisErrors(path);
      final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();

      channel.sendNotification(notif);
      // delegate.sidecarVerboseMessage('analyzeFile completed: $path');
    } catch (e, stackTrace) {
      delegate.sidecarError(
          'error analyzing $path -- ${e.toString()}', stackTrace);
      channel.sendError('error analyzing $path -- ${e.toString()}', stackTrace);
    }
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    final filePath = parameters.file;
    try {
      final unit = await getResolvedUnitResult(filePath);
      final context = unit.session.analysisContext;
      final analysisContextService =
          ref.read(analysisContextServiceProvider(context));

      final detectedLints =
          await analysisContextService.computeLints(filePath).then(
                (value) => value.where((detectedLint) {
                  final lintLocation = detectedLint.toAnalysisError().location;

                  return lintLocation.file == parameters.file &&
                      lintLocation.offset <= parameters.offset &&
                      parameters.offset <=
                          lintLocation.offset + lintLocation.length;
                }).toList(),
              );

      final analysisErrorFixes = await Future.wait<plugin.AnalysisErrorFixes>(
        detectedLints.map((e) async => await e.computeAnalysisErrorFixes(ref)),
      );

      return plugin.EditGetFixesResult(analysisErrorFixes);
    } on Exception catch (e, stackTrace) {
      channel.sendError(e.toString(), stackTrace);
    }
    return plugin.EditGetFixesResult(const <plugin.AnalysisErrorFixes>[]);
  }

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    EditGetAssistsParams parameters,
  ) async {
    final unit = await getResolvedUnitResult(parameters.file);

    final analysisContextService =
        ref.read(analysisContextServiceProvider(unit.session.analysisContext));

    final editRequests = analysisContextService.getCodeEditRequests(
        unit, parameters.offset, parameters.length);

    final changes = await Future.wait<plugin.PrioritizedSourceChange?>(
      editRequests.map((e) async => await e.toPrioritizedSourceChange(ref)),
    );

    return EditGetAssistsResult(
      changes.whereType<plugin.PrioritizedSourceChange>().toList(),
    );
  }
}
