import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:riverpod/riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:sidecar/sidecar.dart';
import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';
import 'package:sidecar_analyzer_plugin_core/src/logger.dart';

import 'log_delegate.dart';
import 'channel_extension.dart';
import 'constants.dart';

enum SidecarAnalyzerPluginMode { debug, cli, plugin }

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin({
    required this.lintRuleConstructors,
    required this.codeEditConstructors,
    this.delegate = const DebuggerLogDelegate(),
    ResourceProvider? resourceProvider,
    required this.mode,
  })  : ref = ProviderContainer(),
        super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        ) {
    Logger.log('SidecarAnalyzerPlugin init started');
    delegate.sidecarVerboseMessage(
        'initializing ${lintRuleConstructors.length} lints and ${codeEditConstructors.length} edits.');
    for (var constructor in lintRuleConstructors) {
      allLintRules.add(constructor(ref));
    }

    for (var constructor in codeEditConstructors) {
      allCodeEdits.add(constructor(ref));
    }
    initialization();
    Logger.log('SidecarAnalyzerPlugin init completed');
  }
  late final HotReloader reloader;
  final reloadCompleter = Completer();
  final SidecarAnalyzerPluginMode mode;
  late ProjectConfiguration projectConfiguration;

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    Logger.log('start');
    super.start(channel);
    if (mode == SidecarAnalyzerPluginMode.debug) {
      _start(channel);
    }
    Logger.log('start completed');
  }

  Future<void> _start(plugin.PluginCommunicationChannel channel) async {
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
    await reloader.reloadCode();
    // test //
    delegate.sidecarVerboseMessage('reload request completed');
  }

  @override
  Future<plugin.PluginVersionCheckResult> handlePluginVersionCheck(
      plugin.PluginVersionCheckParams parameters) {
    Logger.log('handlePluginVersionCheck');
    delegate.sidecarVerboseMessage(
        'version check - server version ${parameters.version}');
    return super.handlePluginVersionCheck(parameters).then((value) {
      Logger.log('handlePluginVersionCheck completed');
      return value;
    });
  }

  Future<void> initialization() async {
    delegate
        .sidecarVerboseMessage('SidecarAnalyzerPlugin initialization complete');
    // todo:
    // read options file for sidecar configuration
  }

  Map<String, ProjectConfiguration> configurations = {};
  Map<String, Map<String, LintConfiguration?>> lintConfigurations = {};
  Map<String, Map<String, EditConfiguration?>> editConfigurations = {};

  Future<void> _getLintConfigs(
    AnalysisContextCollection contextCollection,
  ) async {
    lintConfigurations.clear();
    final List<MapEntry<String, Map<String, LintConfiguration?>>> configs = [];
    for (final context in contextCollection.contexts) {
      final sidecarOptions = configurations[context.contextRoot.root.path]!;
      final Map<String, LintConfiguration?> lintConfigs = {};
      for (final lint in allLintRules) {
        final config =
            sidecarOptions.lintConfiguration(lint.packageName, lint.code);
        lintConfigs.addEntries([MapEntry(lint.code, config)]);
      }
      configs.add(MapEntry(context.contextRoot.root.path, lintConfigs));
    }
    lintConfigurations.addEntries(configs);
  }

  Future<void> _getEditConfigs(
    AnalysisContextCollection contextCollection,
  ) async {
    lintConfigurations.clear();
    final List<MapEntry<String, Map<String, EditConfiguration?>>> configs = [];
    for (final context in contextCollection.contexts) {
      final sidecarOptions = configurations[context.contextRoot.root.path]!;
      final Map<String, EditConfiguration?> editConfigs = {};
      for (final edit in allCodeEdits) {
        final config =
            sidecarOptions.editConfiguration(edit.packageName, edit.code);
        editConfigs.addEntries([MapEntry(edit.code, config)]);
      }
      configs.add(MapEntry(context.contextRoot.root.path, editConfigs));
    }
    editConfigurations.addEntries(configs);
  }

  Future<void> _getConfigs(AnalysisContextCollection contextCollection) async {
    configurations.clear();
    await Future.wait<void>(contextCollection.contexts.map((context) async {
      final optionsFile = context.contextRoot.optionsFile;
      if (optionsFile != null) {
        final contents = await io.File(optionsFile.path).readAsString();

        try {
          configurations.addEntries([
            MapEntry(
              context.contextRoot.root.path,
              ProjectConfiguration.parse(contents),
            )
          ]);
        } catch (e) {
          throw UnimplementedError('cannot parse sidecar options: $e');
        }
      } else {
        configurations.addEntries([
          MapEntry(
            context.contextRoot.root.path,
            ProjectConfiguration(),
          )
        ]);
      }
    }));
  }

  final ProviderContainer ref;
  final List<LintRuleConstructor> lintRuleConstructors;
  final List<CodeEditConstructor> codeEditConstructors;
  final LogDelegate delegate;

  final List<CodeEdit> allCodeEdits = [];
  final List<LintRule> allLintRules = [];

  @override
  List<String> get fileGlobsToAnalyze =>
      <String>['**/*.dart', '**/*.arb', '**/*.yaml'];

  @override
  String get name => pluginName;

  @override
  String get version => pluginVersion;

  @override
  Future<plugin.PluginShutdownResult> handlePluginShutdown(
    plugin.PluginShutdownParams parameters,
  ) async {
    await flushAnalysisState(elementModels: true);
    return super.handlePluginShutdown(parameters);
  }

  @override
  Future<void> beforeContextCollectionDispose({
    required AnalysisContextCollection contextCollection,
  }) {
    delegate.sidecarVerboseMessage('beforeNewContextCollection');
    // channel.sendError('beforeNewContextCollection');
    return super
        .beforeContextCollectionDispose(contextCollection: contextCollection);
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    Logger.log('afterNewContextCollection started');
    delegate.sidecarVerboseMessage('afterNewContextCollection');
    await _getConfigs(contextCollection);
    await _getLintConfigs(contextCollection);
    await _getEditConfigs(contextCollection);
    channel.sendError('afterNewContextCollection');
    Logger.log('afterNewContextCollection complete');
    await super.afterNewContextCollection(contextCollection: contextCollection);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    Logger.log('analyzeFile          : $path');
    final rootPath = analysisContext.contextRoot.root.path;

    if (!analysisContext.isSidecarEnabled) {
      delegate.sidecarVerboseMessage(
          'analyzeFile: sidecar is not enabled in root dir: $rootPath     (file; $path)');
      return;
    }
    ;
    if (!p.isWithin(rootPath, path)) {
      delegate.sidecarVerboseMessage(
          'analyzeFile: file is not within root path    (file: $path) (root: $rootPath)');
      return;
    }

    try {
      final errors = await _getAnalysisErrors(analysisContext, path);
      final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();

      channel.sendNotification(notif);
      Logger.log('analyzeFile completed: $path');
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

      final reportedErrors = await _getReportedErrors(context, filePath).then(
        (value) => value.where((reportedError) {
          final errorLocation = reportedError.toAnalysisError().location;

          return errorLocation.file == parameters.file &&
              errorLocation.offset <= parameters.offset &&
              parameters.offset <= errorLocation.offset + errorLocation.length;
        }).toList(),
      );

      final analysisErrorFixes = await Future.wait<plugin.AnalysisErrorFixes>(
        reportedErrors.map((e) async => await e.toAnalysisErrorFixes(ref)),
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

    final editRequests =
        _getCodeEditRequests(unit, parameters.offset, parameters.length);

    final changes = await Future.wait<plugin.PrioritizedSourceChange?>(
      editRequests.map((e) async => await e.toPrioritizedSourceChange(ref)),
    );

    return EditGetAssistsResult(
      changes.whereType<plugin.PrioritizedSourceChange>().toList(),
    );
  }

  Iterable<RequestedCodeEdit> _getCodeEditRequests(
    ResolvedUnitResult unit,
    int offset,
    int length,
  ) {
    final codeEditReporter = CodeEditReporter(unit);

    final astNode = unit.astNodeAt(offset, length: length);

    for (final edit in allCodeEdits) {
      // final config = sidecarOptions.editPackages?[codeEdit.packageName]
      //     ?.edits[codeEdit.code]?.configuration;
      final analysisContext = unit.session.analysisContext;
      final rootPath = analysisContext.contextRoot.root.path;
      final config = editConfigurations[rootPath]?[edit.code]?.configuration;
      try {
        edit.initialize(configurationContent: config);
        codeEditReporter.reportAstNode(astNode, edit);
      } on EmptyConfiguration catch (e, stackTrace) {
        channel.sendError('CodeEdit EmptyConfig: $e', stackTrace);
      } on IncorrectConfiguration catch (e, stackTrace) {
        channel.sendError(
            'CodeEdit IncorrectConfig: ${e.lintName} ${e.error}', stackTrace);
      } catch (e, stackTrace) {
        channel.sendError('CodeEdit Misc error: $e', stackTrace);
      }
    }

    return codeEditReporter.reportedEdits;
  }

  Future<bool> _isPathIncludedForRule({
    required AnalysisContext analysisContext,
    required String path,
    required LintRule rule,
  }) async {
    final rootDirectory = analysisContext.contextRoot.root;
    final relativePath = p.relative(path, from: rootDirectory.path);
    final isIncluded =
        configurations[rootDirectory.path]!.includes(relativePath);

    // if (!isIncluded) return [];
    return isIncluded;
  }

  Future<Iterable<DetectedLint>> _getReportedErrors(
    AnalysisContext analysisContext,
    String sourcePath,
  ) async {
    Logger.log('_getReportedErrors started');
    final errorReporter = ErrorReporter(sourcePath);

    // final sidecarOptions =
    //     configurations[analysisContext.contextRoot.root.path]!;

    final detectedLints = <DetectedLint>[];
    final detectedConfigurationErrors = <plugin.AnalysisError>[];

    await Future.wait(allLintRules.map<Future<void>>((rule) async {
      // final config = sidecarOptions
      //     .lintConfiguration(rule.packageName, rule.code)
      //     ?.configuration;
      final rootPath = analysisContext.contextRoot.root.path;
      final config = lintConfigurations[rootPath]?[rule.code]?.configuration;

      try {
        Logger.log('try started ${rule.code}');
        rule.initialize(configurationContent: config);
        final lints = await errorReporter.generateLints(analysisContext, rule);
        detectedLints.addAll(lints);
        Logger.log('try ended   ${rule.code}');
      } on EmptyConfiguration catch (e, stackTrace) {
        delegate.lintError(rule, e.toString(), stackTrace.toString());
        channel.sendError('LintRule EmptyConfig: ${e.error}', stackTrace);

        detectedConfigurationErrors.add(
          _calculateAnalysisOptionConfigError(
            analysisContext,
            rule.packageName,
            rule.code,
            'Empty configuration',
          ),
        );
      } on IncorrectConfiguration catch (e, stackTrace) {
        channel.sendError(
            'LintRule IncorrectConfig: ${e.lintName} ${e.error}', stackTrace);

        detectedConfigurationErrors.add(
          _calculateAnalysisOptionConfigError(
            analysisContext,
            rule.packageName,
            rule.code,
            'Incorrect configuration',
          ),
        );
        // highlight node and state what missing configuration was
      } catch (e, stackTrace) {
        channel.sendError('LintRule MiscError: ${e.toString()}', stackTrace);

        detectedConfigurationErrors.add(
          _calculateAnalysisOptionConfigError(
            analysisContext,
            rule.packageName,
            rule.code,
            'Miscellaneous error; please check your lint configuration',
          ),
        );
      }
    }));
    _sendConfigErrors(detectedConfigurationErrors, analysisContext);

    Logger.log('_getReportedErrors complete');
    return detectedLints;
  }

  void _sendConfigErrors(
      List<plugin.AnalysisError> errors, AnalysisContext analysisContext) {
    if (errors.isNotEmpty) {
      final path = analysisContext.contextRoot.optionsFile!.path;
      final response =
          plugin.AnalysisErrorsParams(path, errors).toNotification();
      channel.sendNotification(response);
    }
  }

  plugin.AnalysisError _calculateAnalysisOptionConfigError(
    AnalysisContext analysisContext,
    String packageId,
    String lintId,
    String message,
  ) {
    return plugin.AnalysisError(
      plugin.AnalysisErrorSeverity.ERROR,
      plugin.AnalysisErrorType.LINT,
      analysisContext.sidecarLintSourceSpan(packageId, lintId).location,
      message,
      'lint_misconfiguration',
    );
  }

  Future<List<plugin.AnalysisError>> _getAnalysisErrors(
    AnalysisContext analysisContext,
    String path,
  ) async {
    final detectedLints = await _getReportedErrors(analysisContext, path);
    delegate.sidecarVerboseMessage('\n${detectedLints.length} errors found');
    for (var detectedLint in detectedLints) {
      delegate.lintMessage(detectedLint, detectedLint.message);
    }
    return detectedLints.map((lint) => lint.toAnalysisError()).toList();
  }
}
