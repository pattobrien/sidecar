import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/source/line_info.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/channel/channel.dart' as plugin;
import 'package:riverpod/riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:sidecar/sidecar.dart' hide ContextRoot;
import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';
import 'package:yaml/yaml.dart';

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
        );

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

  final ProviderContainer ref;
  final List<LintRuleConstructor> lintRuleConstructors;
  final List<CodeEditConstructor> codeEditConstructors;
  final LogDelegate delegate;

  final List<CodeEdit> allCodeEdits = [];
  final List<LintRule> allLintRules = [];

  Map<ContextRoot, ProjectConfiguration> configurations = {};
  Map<ContextRoot, Map<LintRuleId, LintConfiguration>> lintConfigurations = {};
  Map<ContextRoot, Map<CodeEditId, EditConfiguration>> editConfigurations = {};
  Map<ContextRoot, String> sidecarOptionContents = {};

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
    await _initializeLintsAndEdits();
    delegate.sidecarVerboseMessage('afterNewContextCollection _getConfigs');
    await _getConfigs(contextCollection);
    delegate.sidecarVerboseMessage('afterNewContextCollection complete');
    await super.afterNewContextCollection(contextCollection: contextCollection);
  }

  Future<void> _initializeLintsAndEdits() async {
    delegate.sidecarVerboseMessage(
        'initializing ${lintRuleConstructors.length} lints and ${codeEditConstructors.length} edits.');
    for (var constructor in lintRuleConstructors) {
      allLintRules.add(constructor(ref));
    }

    for (var constructor in codeEditConstructors) {
      allCodeEdits.add(constructor(ref));
    }
  }

  void _getConfigurationErrors(AnalysisContext context) {
    final errors = <YamlSourceError>[];

    final lintConfigs = lintConfigurations[context.contextRoot];
    for (final config in lintConfigs!.entries) {
      errors.addAll(config.value.sourceErrors);
    }
    // final editsConfigs = editConfigurations[root];
    // for (final config in editsConfigs!.entries) {
    //   errors.addAll(config.value.sourceErrors);
    // }
    final analysisErrors = errors.map((e) => e.toAnalysisError()).toList();
    delegate.sidecarMessage('analysis config errors: ${analysisErrors.length}');
    _sendConfigErrors(analysisErrors, context);
  }

  void _getEditConfigurations(
    ProjectConfiguration sidecarOptions,
    ContextRoot root,
  ) {
    editConfigurations[root] = {};
    for (final edit in allCodeEdits) {
      delegate.sidecarVerboseMessage('setting up ${edit.code}');
      final config =
          sidecarOptions.editConfiguration(edit.packageName, edit.code);
      if (config != null) {
        editConfigurations[root]![edit.code] = config;
      } else {
        editConfigurations[root]!.remove(edit.code);
      }
      edit.initialize(configurationContent: config?.configuration);
    }
    delegate.sidecarVerboseMessage('setting up');
  }

  void _getLintConfigurations(
      ProjectConfiguration sidecarOptions, ContextRoot root) {
    lintConfigurations[root] = {};
    for (final lint in allLintRules) {
      delegate.sidecarVerboseMessage('setting up ${lint.code}');
      final config =
          sidecarOptions.lintConfiguration(lint.packageName, lint.code);
      if (config != null) {
        lintConfigurations[root]![lint.code] = config;
      } else {
        lintConfigurations[root]!.remove(lint.code);
      }
      lint.initialize(configurationContent: config?.configuration);
    }
  }

  Future<void> _getConfigs(AnalysisContextCollection contextCollection) async {
    configurations.clear();
    sidecarOptionContents.clear();

    await Future.wait<void>(contextCollection.contexts.map((context) async {
      final optionsFile = context.contextRoot.optionsFile;
      final root = context.contextRoot;
      if (optionsFile != null) {
        final contents = await io.File(optionsFile.path).readAsString();
        sidecarOptionContents[root] = contents;

        try {
          configurations[root] = ProjectConfiguration.parse(contents,
              sourceUrl: optionsFile.toUri());
        } catch (e) {
          throw UnimplementedError('cannot parse sidecar options: $e');
        }
      } else {
        configurations[root] = ProjectConfiguration();
      }

      _getEditConfigurations(configurations[root]!, root);
      _getLintConfigurations(configurations[root]!, root);

      delegate.sidecarVerboseMessage('getting configuration errors');
      _getConfigurationErrors(context);
      delegate.sidecarVerboseMessage('getting configuration errors completed');
    }));
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    delegate.sidecarVerboseMessage('analyzeFile          : $path');
    final rootPath = analysisContext.contextRoot.root.path;
    final analysisPath = analysisContext.contextRoot.optionsFile?.path;

    if (path == analysisPath) {
      // we handle analyzing the config file separately

    }

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
    final ruleConfigIncludes = ruleProjectConfig?.includes;

    if (ruleProjectConfig != null && ruleConfigIncludes != null) {
      return ruleConfigIncludes.any((glob) => glob.matches(relativePath));
    }

    // #2 check default LintRule/CodeEdit includes from lint/edit definition
    if (rule.includes != null) {
      return rule.includes!.any((glob) => glob.matches(relativePath));
    }

    // TODO: #3 check explicit LintPackage includes from project config
    // TODO: #4 check default LintPackage includes from LintPackage definition

    // #5 check project configuration
    return configurations[contextRoot]!.includes(relativePath);
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
          final lintConfig =
              lintConfigurations[analysisContext.contextRoot]![rule.code];
          final lints =
              await errorReporter.generateDartLints(unit, rule, lintConfig);
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
      // _sendConfigErrors(detectedConfigurationErrors, analysisContext);
    }
    return detectedLints;
  }

  void _sendConfigErrors(
    List<plugin.AnalysisError> errors,
    AnalysisContext analysisContext,
  ) {
    final path = analysisContext.contextRoot.optionsFile?.path;
    if (path == null) return;
    final response = plugin.AnalysisErrorsParams(path, errors).toNotification();
    channel.sendNotification(response);
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
      sidecarLintSourceSpan(analysisContext, packageId, lintId).location,
      message,
      'lint_misconfiguration',
    );
  }

  SourceSpan sidecarLintSourceSpan(
    AnalysisContext context,
    String packageId,
    String lintId,
  ) {
    final contents = sidecarOptionContents[context.contextRoot]!;
    final uri = context.contextRoot.root.toUri();
    final doc = loadYamlNode(contents, sourceUrl: uri) as YamlMap;

    final sidecar = doc.nodes['sidecar']! as YamlMap;

    final packages = sidecar.nodes['lints']! as YamlMap;

    final lints = packages.nodes[packageId]! as YamlMap;
    delegate.sidecarVerboseMessage(
        'root ${context.contextRoot.root.path} searching for $packageId - $lintId');

    delegate.sidecarVerboseMessage(
        'nodes ${lints.nodes.entries.map((e) => '${e.key}-${e.value}').toString()}');
    //TODO: is this a dart error?
    final myLintKey = lints.nodes.entries.firstWhere((entry) {
      final isMatch = entry.key.toString() == lintId;
      delegate.sidecarVerboseMessage(
          'node search for $lintId - ${entry.key} ${entry.value} - $isMatch');
      return isMatch;
    }).key as YamlScalar;

    final startOffset = myLintKey.span.start.offset;
    final endOffset = myLintKey.span.end.offset;

    final lineInfo = LineInfo.fromContent(contents);
    final startLocation = lineInfo.getLocation(startOffset);
    final endLocation = lineInfo.getLocation(endOffset);
    final sourceSpan = SourceSpan(
      SourceLocation(
        startOffset,
        column: startLocation.columnNumber,
        line: startLocation.lineNumber,
        sourceUrl: uri,
      ),
      SourceLocation(
        endOffset,
        column: endLocation.columnNumber,
        line: endLocation.lineNumber,
        sourceUrl: uri,
      ),
      contents.substring(startOffset, endOffset),
    );
    return sourceSpan;
    // } catch (e) {
    //   throw UnimplementedError('cannot parse sidecar options: $e');
    // }
    // } else {
    //   throw UnimplementedError('yaml options file doesnt exist');
    // }
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
