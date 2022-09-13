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
  final List<LintRule> allLints;
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
  }) async {
    _collection = contextCollection;
    await super.afterNewContextCollection(contextCollection: contextCollection);
  }

  @override
  Future<void> analyzeFile({
    required AnalysisContext analysisContext,
    required String path,
  }) async {
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: start analyzeFile()',
        'file path: $path',
      ).toNotification(),
    );
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
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: end analyzeFile()',
        'file path: $path',
      ).toNotification(),
    );
  }

  @override
  Future<plugin.EditGetFixesResult> handleEditGetFixes(
    plugin.EditGetFixesParams parameters,
  ) async {
    final filePath = parameters.file;
    try {
      channel.sendNotification(
        plugin.PluginErrorParams(
          false,
          'log: start handleEditGetFixes()',
          'file path: $filePath',
        ).toNotification(),
      );
      final context = _collection.contextFor(filePath);

      final unit = await context.currentSession.getResolvedUnit(filePath);

      if (unit is ResolvedUnitResult) {
        final reportedErrors = _getReportedErrors(unit).where((reportedError) {
          final errorLocation = reportedError.toAnalysisError().location;

          return errorLocation.file == parameters.file &&
              errorLocation.offset <= parameters.offset &&
              parameters.offset <= errorLocation.offset + errorLocation.length;
        }).toList();

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
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: end handleEditGetFixes()',
        'file path: $filePath',
      ).toNotification(),
    );
    return plugin.EditGetFixesResult(const <plugin.AnalysisErrorFixes>[]);
  }

  @override
  Future<plugin.EditGetAssistsResult> handleEditGetAssists(
    EditGetAssistsParams parameters,
  ) async {
    final filePath = parameters.file;
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: starthandleEditGetAssists()',
        'file path: $filePath',
      ).toNotification(),
    );
    final context = _collection.contextFor(filePath);

    final unit = await context.currentSession.getResolvedUnit(filePath);

    if (unit is! ResolvedUnitResult) {
      channel.sendNotification(
        plugin.PluginErrorParams(
          false,
          'log: unit is not resolved',
          'file path: $filePath',
        ).toNotification(),
      );
      // Lo
      return EditGetAssistsResult([]);
    }

    final codeEditRequests =
        _getCodeEditRequests(unit, parameters.offset, parameters.length);

    final changes = await Future.wait<plugin.PrioritizedSourceChange?>(
      codeEditRequests.map((e) async => await e.toPrioritizedSourceChange(ref)),
    );
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: end handleEditGetAssists() with ${changes.length} codeEdits',
        'file path: $filePath',
      ).toNotification(),
    );
    return EditGetAssistsResult(
        changes.whereType<plugin.PrioritizedSourceChange>().toList());
  }

  Iterable<RequestedCodeEdit> _getCodeEditRequests(
    ResolvedUnitResult unit,
    int offset,
    int length,
  ) {
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: starting _getCodeEditRequests',
        'file path: ${unit.path}',
      ).toNotification(),
    );
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
        codeEdit.initialize(
          configurationContent: config,
          reporter: codeEditReporter,
        );
      } on EmptyConfiguration catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'CodeEdit Empty Configuration: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
        // highlight node
        // errorReporter.reportYamlNode(node, rule);
      } on IncorrectConfiguration catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'CodeEdit Incorrect Configuration: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
        // highlight node and state what missing configuration was
      } catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'CodeEdit Misc error: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
      }

      try {
        codeEdit.generateReport(astNode);
      } catch (e, stackTrace) {
        // UnimplementedError('error generating code edit report: $e');
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'Empty Configuration: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
      }
    }

    final codeEdits = codeEditReporter.reportedEdits;

    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: ending _getCodeEditRequests() with ${codeEdits.length} detected code edits',
        'file path: ${unit.path}',
      ).toNotification(),
    );
    // Logger.logLine(
    //     '# OF CODE EDITS = ${codeEdits.length} for file ${unit.path}');
    return codeEdits;
  }

  Iterable<DetectedLint> _getReportedErrors(ResolvedUnitResult unit) {
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: starting _getReportedErrors',
        'file path: ${unit.path}',
      ).toNotification(),
    );
    final errorReporter = ErrorReporter(unit);
    final sidecarOptions = unit.session.analysisContext.sidecarOptions;
    final detectedLints = <DetectedLint>[];

    for (final rule in allLints) {
      final config = sidecarOptions
          .lintPackages?[rule.packageName]?.lints[rule.code]?.configuration;

      try {
        rule.initialize(configurationContent: config);
        detectedLints.addAll(errorReporter.generateLints(rule));
      } on EmptyConfiguration catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'Empty Configuration: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
        // highlight node
        // errorReporter.reportYamlNode(node, rule);
      } on IncorrectConfiguration catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'Incorrect Configuration: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
        // highlight node and state what missing configuration was
      } catch (e, stackTrace) {
        channel.sendNotification(
          plugin.PluginErrorParams(
            false,
            'Misc error: ${e.toString()}',
            stackTrace.toString(),
          ).toNotification(),
        );
      }
    }
    channel.sendNotification(
      plugin.PluginErrorParams(
        false,
        'log: ending _getReportedErrors() with ${detectedLints.length} detected lints',
        'file path: ${unit.path}',
      ).toNotification(),
    );
    // final lintVisitor = LintVisitor(nodeRegistry);
    // unit.unit.accept(lintVisitor);

    // final errors = errorReporter.detectedLints;

    // Logger.logLine(
    //     '# OF FIXES (RECEIVED) = ${errors.length} for file ${unit.path}');
    return detectedLints;
  }

  Iterable<plugin.AnalysisError> _getAnalysisErrors(
    ResolvedUnitResult unit,
  ) {
    final reportedErrors = _getReportedErrors(unit);
    final analysisErrors = reportedErrors.map((e) => e.toAnalysisError());
    return analysisErrors;
  }
}
