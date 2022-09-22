import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:riverpod/riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:sidecar/sidecar.dart' hide ContextRoot;
import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

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
    delegate.sidecarVerboseMessage(
        'initializing ${lintRuleConstructors.length} lints and ${codeEditConstructors.length} edits.');
    for (var constructor in lintRuleConstructors) {
      allLintRules.add(constructor(ref));
    }

    for (var constructor in codeEditConstructors) {
      allCodeEdits.add(constructor(ref));
    }
    initialization();
    delegate.sidecarVerboseMessage('init complete');
  }
  late final HotReloader reloader;
  final reloadCompleter = Completer();
  final SidecarAnalyzerPluginMode mode;
  late ProjectConfiguration projectConfiguration;

  @override
  void start(plugin.PluginCommunicationChannel channel) {
    delegate.sidecarVerboseMessage('start');
    super.start(channel);
    if (mode == SidecarAnalyzerPluginMode.debug) {
      _start(channel);
    }
    delegate.sidecarVerboseMessage('start completed');
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
    delegate.sidecarVerboseMessage('handlePluginVersionCheck start');
    delegate.sidecarVerboseMessage(
        'version check - server version ${parameters.version}');
    return super.handlePluginVersionCheck(parameters).then((value) {
      delegate.sidecarVerboseMessage('handlePluginVersionCheck complete');
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

  // Map<ContextRoot, Map<String, LintPackageConfiguration?>>
  //     lintPackageConfigurations = {};

  // Map<ContextRoot, Map<String, EditPackageConfiguration?>>
  //     editPackageConfigurations = {};

  Map<ContextRoot, Map<String, LintConfiguration?>> lintConfigurations = {};
  Map<ContextRoot, Map<String, EditConfiguration?>> editConfigurations = {};

  Future<void> _getLintConfigs(
    AnalysisContextCollection contextCollection,
  ) async {
    lintConfigurations.clear();
    final List<MapEntry<ContextRoot, Map<String, LintConfiguration?>>> configs =
        [];
    for (final context in contextCollection.contexts) {
      final sidecarOptions = configurations[context.contextRoot.root.path]!;
      final Map<String, LintConfiguration?> lintConfigs = {};
      for (final lint in allLintRules) {
        final config =
            sidecarOptions.lintConfiguration(lint.packageName, lint.code);
        lintConfigs.addEntries([MapEntry(lint.code, config)]);
        lint.initialize(configurationContent: config?.configuration);
      }
      configs.add(MapEntry(context.contextRoot, lintConfigs));
    }
    lintConfigurations.addEntries(configs);
  }

  Future<void> _getEditConfigs(
    AnalysisContextCollection contextCollection,
  ) async {
    lintConfigurations.clear();
    final List<MapEntry<ContextRoot, Map<String, EditConfiguration?>>> configs =
        [];
    for (final context in contextCollection.contexts) {
      final sidecarOptions = configurations[context.contextRoot.root.path]!;
      final Map<String, EditConfiguration?> editConfigs = {};
      for (final edit in allCodeEdits) {
        final config =
            sidecarOptions.editConfiguration(edit.packageName, edit.code);
        editConfigs.addEntries([MapEntry(edit.code, config)]);
        edit.initialize(configurationContent: config?.configuration);
      }
      configs.add(MapEntry(context.contextRoot, editConfigs));
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
    return super
        .beforeContextCollectionDispose(contextCollection: contextCollection);
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    delegate.sidecarVerboseMessage('afterNewContextCollection');
    await _getConfigs(contextCollection);
    await _getLintConfigs(contextCollection);
    await _getEditConfigs(contextCollection);
    channel.sendError('afterNewContextCollection');
    delegate.sidecarVerboseMessage('afterNewContextCollection complete');
    await super.afterNewContextCollection(contextCollection: contextCollection);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    delegate.sidecarVerboseMessage('analyzeFile          : $path');
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
      delegate.sidecarVerboseMessage('analyzeFile completed: $path');
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
      try {
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

  bool _isPathIncludedForRule({
    required ContextRoot contextRoot,
    required String path,
    required LintRule rule,
  }) {
    final rootDirectory = contextRoot.root;
    final relativePath = p.relative(path, from: rootDirectory.path);

    // #1 check explicit LintRule/CodeEdit includes from project config
    final ruleProjectConfig = lintConfigurations[contextRoot]?[rule.code];
    if (ruleProjectConfig != null && ruleProjectConfig.includes != null) {
      return ruleProjectConfig.includes!.any((glob) => glob.matches(path));
    }

    // #2 check default LintRule/CodeEdit includes from lint/edit definition
    if (rule.includes != null) {
      return rule.includes!.any((glob) => glob.matches(path));
    }

    // TODO: #3 check explicit LintPackage includes from project config
    // TODO: #4 check default LintPackage includes from LintPackage definition

    // #5 check project configuration
    return configurations[rootDirectory.path]!.includes(relativePath);
  }

  Future<Iterable<DetectedLint>> _getReportedErrors(
    AnalysisContext analysisContext,
    String sourcePath,
  ) async {
    final errorReporter = ErrorReporter(sourcePath);

    final detectedLints = <DetectedLint>[];
    final detectedConfigurationErrors = <plugin.AnalysisError>[];

    if (p.extension(sourcePath) == '.dart') {
      final unit =
          await analysisContext.currentSession.getResolvedUnit(sourcePath);

      if (unit is! ResolvedUnitResult) return [];

      await Future.wait(allLintRules.map<Future<void>>((rule) async {
        if (!_isPathIncludedForRule(
            contextRoot: analysisContext.contextRoot,
            rule: rule,
            path: sourcePath)) {
          return;
        }

        try {
          final lints = await errorReporter.generateDartLints(unit, rule);
          detectedLints.addAll(lints);
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
    }
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
