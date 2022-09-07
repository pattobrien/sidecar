// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';

import 'package:analyzer_plugin/plugin/plugin.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_common.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol.dart' as plugin;
import 'package:analyzer_plugin/protocol/protocol_generated.dart' as plugin;
import 'package:glob/glob.dart';
import 'package:riverpod/riverpod.dart';

import 'reporter/reporter.dart';

import 'package:sidecar/sidecar.dart';

import 'package:path/path.dart' as p;

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
  final List<LintError> allLints;
  final NodeLintRegistry nodeRegistry;
  final List<CodeEdit> allCodeEdits;

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
    final rootDirectory = analysisContext.contextRoot.root;
    final relativePath = p.relative(path, from: rootDirectory.path);
    // check if the path is included for analysis via the sidecar options
    final doesMatchGlob = sidecarOptions.includes
        .map((e) => Glob(e, context: p.context).matches(relativePath))
        .where((element) => element == true)
        .isNotEmpty;

    if (!doesMatchGlob) return;

    final isPluginEnabled =
        analysisContext.analysisOptions.enabledPluginNames.contains(name);

    final isPathExcluded =
        analysisContext.contextRoot.excludedPaths.contains(path);

    // check if we should analyze this file or not
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

      final unit =
          await analysisContext.currentSession.getResolvedUnit(filePath);

      if (unit is ResolvedUnitResult) {
        final reportedErrors = _getReportedErrors(unit).where((reportedError) {
          final errorLocation = reportedError.toAnalysisError().location;

          return errorLocation.file == parameters.file &&
              errorLocation.offset <= parameters.offset &&
              parameters.offset <= errorLocation.offset + errorLocation.length;
        }).toList();

        final analysisErrorFixes = await Future.wait<plugin.AnalysisErrorFixes>(
          reportedErrors.map((e) => e.toAnalysisErrorFixes(ref)),
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

    final changes = await Future.wait<plugin.PrioritizedSourceChange>(
      codeEditRequests
          .map((e) async => await e.toPrioritizedSourceChanges(ref)),
    );
    return EditGetAssistsResult(changes);
  }

  Iterable<RequestedCodeEdit> _getCodeEditRequests(
    ResolvedUnitResult unit,
    int offset,
    int length,
  ) {
    final codeEditReporter = CodeEditReporter(unit);

    final astNode = NodeLocator(
      offset,
      offset + length,
    ).searchWithin(unit.unit);

    for (final codeEdit in allCodeEdits) {
      codeEdit.reporter = codeEditReporter;
      codeEdit.generateReport(astNode);
    }

    final codeEdits = codeEditReporter.reportedEdits;

    Logger.logLine(
        '# OF CODE EDITS = ${codeEdits.length} for file ${unit.path}');
    return codeEdits;
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
    final analysisErrors = reportedErrors.map((e) => e.toAnalysisError());
    return analysisErrors;
  }
}
