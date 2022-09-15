import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:riverpod/riverpod.dart';
import 'package:path/path.dart' as p;

import 'package:sidecar/sidecar.dart';

import 'log_delegate.dart';
import 'channel_extension.dart';
import 'constants.dart';

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin({
    required this.lintRuleConstructors,
    required this.codeEditConstructors,
    this.delegate = const DebuggerLogDelegate(),
    ResourceProvider? resourceProvider,
  })  : ref = ProviderContainer(),
        super(
          resourceProvider:
              resourceProvider ?? PhysicalResourceProvider.INSTANCE,
        ) {
    delegate.sidecarMessage(
        'initializing ${lintRuleConstructors.length} lints and ${codeEditConstructors.length} edits.');
    for (var constructor in lintRuleConstructors) {
      allLintRules.add(constructor(ref));
    }

    for (var constructor in codeEditConstructors) {
      allCodeEdits.add(constructor(ref));
    }
    initialization();
  }
  @override
  Future<plugin.PluginVersionCheckResult> handlePluginVersionCheck(
      plugin.PluginVersionCheckParams parameters) {
    delegate
        .sidecarMessage('version check - server version ${parameters.version}');
    return super.handlePluginVersionCheck(parameters);
  }

  void initialization() {
    delegate.sidecarMessage('SidecarAnalyzerPlugin initialization complete');
    // todo:
    // read options file for sidecar configuration
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
    delegate.sidecarMessage('beforeNewContextCollection');
    // channel.sendError('beforeNewContextCollection');
    return super
        .beforeContextCollectionDispose(contextCollection: contextCollection);
  }

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    delegate.sidecarMessage('afterNewContextCollection');
    channel.sendError('afterNewContextCollection');
    await super.afterNewContextCollection(contextCollection: contextCollection);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    final rootPath = analysisContext.contextRoot.root.path;

    if (!analysisContext.isSidecarEnabled) {
      delegate.sidecarMessage(
          'analyzeFile: sidecar is not enabled in root dir: $rootPath     (file; $path)');
      return;
    }
    ;
    if (!p.isWithin(rootPath, path)) {
      delegate.sidecarMessage(
          'analyzeFile: file is not within root path    (file: $path) (root: $rootPath)');
      return;
    }

    try {
      final errors = await _getAnalysisErrors(analysisContext, path);
      final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();

      channel.sendNotification(notif);
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

    final sidecarOptions = unit.session.analysisContext.sidecarOptions;
    final astNode = unit.astNodeAt(offset, length: length);

    for (final codeEdit in allCodeEdits) {
      final config = sidecarOptions.editPackages?[codeEdit.packageName]
          ?.edits[codeEdit.code]?.configuration;
      try {
        codeEdit.initialize(configurationContent: config);
        codeEditReporter.reportAstNode(astNode, codeEdit);
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

  Future<Iterable<DetectedLint>> _getReportedErrors(
    AnalysisContext analysisContext,
    String sourcePath,
  ) async {
    final errorReporter = ErrorReporter(sourcePath);

    final sidecarOptions = analysisContext.sidecarOptions;
    final detectedLints = <DetectedLint>[];
    final detectedConfigurationErrors = <plugin.AnalysisError>[];

    await Future.wait(allLintRules.map<Future<void>>((rule) async {
      final config = sidecarOptions
          .lintPackages?[rule.packageName]?.lints[rule.code]?.configuration;

      try {
        rule.initialize(configurationContent: config);
        final lints = await errorReporter.generateLints(analysisContext, rule);
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
    final reportedErrors = await _getReportedErrors(analysisContext, path);
    delegate.sidecarMessage(
        '_getAnalysisErrors: ${reportedErrors.length} errors found');
    for (var element in reportedErrors) {
      delegate.lintMessage(element.rule, element.message);
    }
    return reportedErrors.map((lint) => lint.toAnalysisError()).toList();
  }
}
