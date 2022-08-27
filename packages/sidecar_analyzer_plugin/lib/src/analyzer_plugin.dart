// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import 'package:sidecar_analyzer_plugin/src/plugin_bootstrapper.dart';

import 'reporter/reporter.dart';

import 'package:sidecar/sidecar.dart';

const pluginName = 'sidecar_analyzer_plugin';
const pluginVersion = '1.0.0';

class SidecarAnalyzerPlugin extends plugin.ServerPlugin {
  SidecarAnalyzerPlugin({
    required super.resourceProvider,
    required this.ref,
  }) {
    Logger.logLine('SidecarAnalyzerPlugin initialized');

    allLints = pluginBootstrapper(nodeRegistry, ref);
  }

  final ProviderContainer ref;
  late final AnalysisContextCollection _collection;
  final nodeRegistry = NodeLintRegistry();
  late List<LintError> allLints;

  @override
  List<String> get fileGlobsToAnalyze => <String>['**/*.dart', '**/*.arb'];

  @override
  String get name => pluginName;

  @override
  String get version => pluginVersion;

  @override
  Future<void> afterNewContextCollection({
    required AnalysisContextCollection contextCollection,
  }) {
    Logger.logLine('afterNewContextCollection started');
    _collection = contextCollection;
    return super
        .afterNewContextCollection(contextCollection: contextCollection);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    //TODO: remove restriction from plugin side, instead allow lints to do so
    if (!path.endsWith('.dart')) return;
    final sidecarOptions = analysisContext.sidecarOptions;
    final doesMatchGlob =
        sidecarOptions.includes.map((e) => Glob(e).matches(path)).isNotEmpty;

    if (!doesMatchGlob) return;

    final isPluginEnabled =
        analysisContext.analysisOptions.enabledPluginNames.contains(name);
    analysisContext.contextRoot.excludedPaths.forEach(Logger.logLine);
    final isPathExcluded =
        analysisContext.contextRoot.excludedPaths.contains(path);
    if (!isPathExcluded && isPluginEnabled) {
      final unit = await analysisContext.currentSession.getResolvedUnit(path);

      if (unit is ResolvedUnitResult) {
        try {
          final errors = _getAnalysisErrors(unit);
          final response = plugin.AnalysisErrorsParams(
            path,
            errors.toList(),
          ).toNotification();
          Logger.logLine('ANALYZEDFILE = SUCCESS $path');
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
      } else {
        Logger.logLine('ANALYZEDFILE = FAILURE $path');
      }
    }
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    try {
      final filePath = parameters.file;
      final analysisContext = _collection.contextFor(filePath);
      // analysisContext.changeFile(filePath);
      // await analysisContext.applyPendingFileChanges();
      final unit =
          await analysisContext.currentSession.getResolvedUnit(filePath);

      if (unit is ResolvedUnitResult) {
        final reportedErrors = _getReportedErrors(unit).where((reportedError) {
          final errorLocation = reportedError.analysisError.location;

          return errorLocation.file == parameters.file &&
              errorLocation.offset <= parameters.offset &&
              parameters.offset <= errorLocation.offset + errorLocation.length;
        }).toList();

        Logger.logLine(
            '# OF ANALYSIS ERRORS TO GET FIXES FOR:  ${reportedErrors.length}');

        final analysisErrorFixes = await Future.wait<plugin.AnalysisErrorFixes>(
          reportedErrors.map((e) => e.toAnalysisErrorFixes(ref)),
        );

        final response = plugin.EditGetFixesResult(analysisErrorFixes);

        Logger.logLine('handleEditGetFixes => ${response.toJson()}');

        return response;
      } else {
        Logger.logLine('ERROR - handleEditGetFixes - ELSE CLAUSE $parameters');
      }
    } on Exception catch (e, stackTrace) {
      Logger.logLine('ERROR - handleEditGetFixes - $e $parameters');
      channel.sendNotification(
        plugin.PluginErrorParams(false, e.toString(), stackTrace.toString())
            .toNotification(),
      );
    }

    return plugin.EditGetFixesResult(const <plugin.AnalysisErrorFixes>[]);
  }

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    EditGetAssistsParams parameters,
  ) async {
    return EditGetAssistsResult(<plugin.PrioritizedSourceChange>[
      plugin.PrioritizedSourceChange(
        0,
        plugin.SourceChange(
          'TEST ASSIST: NO EDIT',
          edits: [],
        ),
      )
    ]);
  }

  Iterable<ReportedLintError> _getReportedErrors(
    ResolvedUnitResult unit,
  ) {
    final errorReporter = ErrorReporter(unit);

    for (final linter in allLints) {
      linter.reporter = errorReporter;
    }
    final lintVisitor = LintVisitor(nodeRegistry);
    unit.unit.accept(lintVisitor);

    final errors = errorReporter.reportedErrors;

    Logger.logLine(
        '# OF FIXES (RECEIVED) = ${errors.length} for file ${unit.path}');
    return errors;
  }

  Iterable<plugin.AnalysisError> _getAnalysisErrors(
    ResolvedUnitResult unit,
  ) {
    final reportedErrors = _getReportedErrors(unit);
    final analysisErrors = reportedErrors.map((e) => e.analysisError);
    return analysisErrors;
  }
}
