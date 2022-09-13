// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import 'package:sidecar/sidecar.dart';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

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
  }) {
    Logger.logLine('SidecarAnalyzerPlugin initialized');
  }

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
    //TODO: remove restriction from plugin side, instead allow lints to do so
    // if (!path.endsWith('.dart')) return;

    try {
      final errors = await _getAnalysisErrors(analysisContext, path);
      final response =
          plugin.AnalysisErrorsParams(path, errors.toList()).toNotification();

      channel.sendNotification(response);
    } catch (e, stackTrace) {
      channel.sendNotification(
        plugin.PluginErrorParams(
          false,
          'error analyzing $path --${e.toString()}',
          stackTrace.toString(),
        ).toNotification(),
      );
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
      Logger.logLine('ERROR - handleEditGetFixes - $e $parameters');
      channel.sendNotification(
        plugin.PluginErrorParams(
          false,
          e.toString(),
          stackTrace.toString(),
        ).toNotification(),
      );
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

    if (unit is! ResolvedUnitResult) {
      return EditGetAssistsResult([]);
    }

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
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'CodeEdit EmptyConfiguration: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );

        // final path = unit.session.analysisContext.contextRoot.optionsFile!.path;
        // final analysisError = plugin.AnalysisError(
        //   plugin.AnalysisErrorSeverity.WARNING,
        //   plugin.AnalysisErrorType.HINT,
        //   unit.session.analysisContext.sidecarSourceSpan.location,
        //   'empty configuration',
        //   'empty_config',
        // );

        // final response =
        //     plugin.AnalysisErrorsParams(path, [analysisError]).toNotification();

        // channel.sendNotification(response);
      } on IncorrectConfiguration catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'CodeEdit IncorrectConfiguration: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );

        // final path = unit.session.analysisContext.contextRoot.optionsFile!.path;
        // final analysisError = plugin.AnalysisError(
        //   plugin.AnalysisErrorSeverity.WARNING,
        //   plugin.AnalysisErrorType.HINT,
        //   unit.session.analysisContext.sidecarSourceSpan.location,
        //   'incorrect configuration',
        //   'incorrect_config',
        // );

        // final response =
        //     plugin.AnalysisErrorsParams(path, [analysisError]).toNotification();

        // channel.sendNotification(response);
        // highlight node and state what missing configuration was
      } catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'CodeEdit Misc error: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );

        // final path = unit.session.analysisContext.contextRoot.optionsFile!.path;
        // final analysisError = plugin.AnalysisError(
        //   plugin.AnalysisErrorSeverity.WARNING,
        //   plugin.AnalysisErrorType.HINT,
        //   unit.session.analysisContext.sidecarSourceSpan.location,
        //   'misc configuration error',
        //   'misc_config_error',
        // );

        // final response =
        //     plugin.AnalysisErrorsParams(path, [analysisError]).toNotification();

        // channel.sendNotification(response);
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

    await Future.wait(allLints.map<Future<void>>((rule) async {
      final config = sidecarOptions
          .lintPackages?[rule.packageName]?.lints[rule.code]?.configuration;

      try {
        rule.initialize(configurationContent: config);
        final lints = await errorReporter.generateLints(analysisContext, rule);
        detectedLints.addAll(lints);
      } on EmptyConfiguration catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'LintRule EmptyConfiguration: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );

        _sendAnalysisOptionConfigError(
            analysisContext, rule.packageName, 'Empty configuration');
      } on IncorrectConfiguration catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'LintRule IncorrectConfiguration: ${e.error.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
        _sendAnalysisOptionConfigError(
            analysisContext, rule.packageName, 'Incorrect configuration');
        // highlight node and state what missing configuration was
      } catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'LintRule MiscError: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );

        _sendAnalysisOptionConfigError(analysisContext, rule.packageName,
            'Miscellaneous error; please check your lint configuration');
      }
    }));

    return detectedLints;
  }

  void _sendAnalysisOptionConfigError(
    AnalysisContext analysisContext,
    String packageId,
    String message,
  ) {
    final path = analysisContext.contextRoot.optionsFile!.path;
    final analysisError = plugin.AnalysisError(
      plugin.AnalysisErrorSeverity.ERROR,
      plugin.AnalysisErrorType.LINT,
      analysisContext.sidecarLintSourceSpan(packageId)!.location,
      message,
      'sidecar_misconfiguration',
    );

    final response =
        plugin.AnalysisErrorsParams(path, [analysisError]).toNotification();

    channel.sendNotification(response);
  }

  Future<Iterable<plugin.AnalysisError>> _getAnalysisErrors(
    AnalysisContext analysisContext,
    String path,
  ) async {
    final reportedErrors = await _getReportedErrors(analysisContext, path);
    return reportedErrors.map((lint) => lint.toAnalysisError());
  }
}
