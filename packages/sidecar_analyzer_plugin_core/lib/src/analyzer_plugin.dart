// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:riverpod/riverpod.dart';

import 'package:sidecar/sidecar.dart';

import 'channel_extension.dart';

const pluginName = 'sidecar_analyzer_plugin';

// this cannot be any random number for some reason
// ("Plugin is not compatible." error is thrown)
const pluginVersion = '1.0.0-alpha.0';

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin({
    required super.resourceProvider,
    required this.ref,
    required this.allLints,
    required this.allCodeEdits,
    required this.nodeRegistry,
  });

  final ProviderContainer ref;
  late AnalysisContextCollection _collection;
  final List<LintRule> allLints;
  final NodeLintRegistry nodeRegistry;
  final List<CodeEdit> allCodeEdits;

  @override
  List<String> get fileGlobsToAnalyze =>
      <String>['**/*.dart', '**/*.arb', '**/*.yaml'];

  @override
  String get name => pluginName;

  @override
  String get version => pluginVersion;

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) async {
    _collection = contextCollection;
    await super.afterNewContextCollection(contextCollection: contextCollection);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    if (!analysisContext.isSidecarEnabled) return;

    try {
      final errors = await _getAnalysisErrors(analysisContext, path);
      final notif = plugin.AnalysisErrorsParams(path, errors).toNotification();

      channel.sendNotification(notif);
    } catch (e, stackTrace) {
      channel.sendError('error analyzing $path -- ${e.toString()}', stackTrace);
    }
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    final filePath = parameters.file;
    try {
      final context = _collection.contextFor(filePath);

      final unit = await context.currentSession.getResolvedUnit(filePath);

      if (unit is ResolvedUnitResult) {
        final reportedErrors = await _getReportedErrors(context, filePath).then(
          (value) => value.where((reportedError) {
            final errorLocation = reportedError.toAnalysisError().location;

            return errorLocation.file == parameters.file &&
                errorLocation.offset <= parameters.offset &&
                parameters.offset <=
                    errorLocation.offset + errorLocation.length;
          }).toList(),
        );

        final analysisErrorFixes = await Future.wait<plugin.AnalysisErrorFixes>(
          reportedErrors.map((e) async => await e.toAnalysisErrorFixes(ref)),
        );

        final response = plugin.EditGetFixesResult(analysisErrorFixes);

        return response;
      }
    } on Exception catch (e, stackTrace) {
      channel.sendError(e.toString(), stackTrace);
    }
    return plugin.EditGetFixesResult(const <plugin.AnalysisErrorFixes>[]);
  }

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    EditGetAssistsParams parameters,
  ) async {
    final filePath = parameters.file;
    final context = _collection.contextFor(filePath);
    final unit = await context.currentSession.getResolvedUnit(filePath);

    if (unit is! ResolvedUnitResult) return EditGetAssistsResult([]);

    final codeEditRequests =
        _getCodeEditRequests(unit, parameters.offset, parameters.length);

    final changes = await Future.wait<plugin.PrioritizedSourceChange?>(
      codeEditRequests.map((e) async => await e.toPrioritizedSourceChange(ref)),
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
    final astNode = NodeLocator(
      offset,
      offset + length,
    ).searchWithin(unit.unit);

    for (final codeEdit in allCodeEdits) {
      final config = sidecarOptions.editPackages?[codeEdit.packageName]
          ?.edits[codeEdit.code]?.configuration;
      try {
        codeEdit.initialize(configurationContent: config);
        codeEditReporter.reportAstNode(astNode, codeEdit);
      } on EmptyConfiguration catch (e, stackTrace) {
        channel.sendError(
            'CodeEdit EmptyConfiguration: ${e.toString()}', stackTrace);
      } on IncorrectConfiguration catch (e, stackTrace) {
        channel.sendError(
            'CodeEdit IncorrectConfig: ${e.toString()}', stackTrace);
      } catch (e, stackTrace) {
        channel.sendError('CodeEdit Misc error: ${e.toString()}', stackTrace);
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

    await Future.wait(allLints.map<Future<void>>((rule) async {
      final config = sidecarOptions
          .lintPackages?[rule.packageName]?.lints[rule.code]?.configuration;

      try {
        rule.initialize(configurationContent: config);
        final lints = await errorReporter.generateLints(analysisContext, rule);
        detectedLints.addAll(lints);
      } on EmptyConfiguration catch (e, stackTrace) {
        channel.sendError('LintRule EmptyConfig: ${e.toString()}', stackTrace);

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
            'LintRule IncorrectConfig: ${e.toString()}', stackTrace);

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
    final path = analysisContext.contextRoot.optionsFile!.path;
    final response = plugin.AnalysisErrorsParams(path, errors).toNotification();

    channel.sendNotification(response);
  }

  plugin.AnalysisError _calculateAnalysisOptionConfigError(
    AnalysisContext analysisContext,
    String packageId,
    String lintId,
    String message,
  ) {
    final analysisError = plugin.AnalysisError(
      plugin.AnalysisErrorSeverity.ERROR,
      plugin.AnalysisErrorType.LINT,
      analysisContext.sidecarLintSourceSpan(packageId, lintId).location,
      message,
      'lint_misconfiguration',
    );
    return analysisError;
  }

  Future<List<plugin.AnalysisError>> _getAnalysisErrors(
    AnalysisContext analysisContext,
    String path,
  ) async {
    final reportedErrors = await _getReportedErrors(analysisContext, path);
    return reportedErrors.map((lint) => lint.toAnalysisError()).toList();
  }
}
