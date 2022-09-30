import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/dart/analysis/results.dart' hide AnalysisResult;
import 'package:analyzer/source/line_info.dart';

import 'package:analyzer_plugin/channel/channel.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart'
    hide ContextRoot;

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:path/path.dart' as p;
import 'package:sidecar_analyzer_plugin_core/src/context_services/queued_files.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../log_delegate/log_delegate.dart';
import '../plugin/plugin.dart';
import '../reporters/error_reporter.dart';
import '../utils/channel_extension.dart';

import 'activated_edits.dart';
import 'activated_lints.dart';
import 'analysis_errors.dart';
import 'config_error_composer.dart';
import 'lint_constructor_providers.dart';
import 'project_configuration_service.dart';

class AnalysisContextService {
  AnalysisContextService(
    this.ref, {
    required this.context,
  })  : delegate = ref.read(logDelegateProvider),
        channel = ref.read(pluginChannelProvider)!,
        projectConfigurationService =
            ref.read(projectConfigurationServiceProvider(context.contextRoot)),
        root = context.contextRoot;

  final Ref ref;
  final AnalysisContext context;
  final ContextRoot root;

  final PluginCommunicationChannel channel;
  final LogDelegateBase delegate;
  final ProjectConfigurationService projectConfigurationService;

  ProjectConfiguration? get projectConfiguration =>
      projectConfigurationService.projectConfiguration;

  void queueFiles() {
    final paths = context.contextRoot.analyzedFiles();
    ref.read(queuedFilesProvider(root)).addPaths(paths);
  }

  void initializeLintsAndEdits() {
    final projectConfig = projectConfiguration;

    if (projectConfig == null) return;

    final errorComposer = ref.read(errorComposerProvider(root));
    final lintRules = ref.read(lintRuleConstructorProvider).entries;
    final codeEdits = ref.read(codeEditConstructorProvider).entries;
    ref.read(activatedLintsProvider(root)).clearLints();
    ref.read(activatedEditsProvider(root)).clearEdits();

    for (var lintRule in lintRules) {
      final lintId = lintRule.key;
      final config = projectConfig.getConfiguration(lintId);
      final lint = lintRule.value();
      final package = lint.packageName;
      final lintCode = lint.code;
      delegate.sidecarMessage('activating $lintCode');
      lint.initialize(
        configurationContent: config?.configuration,
        ref: ref,
        lintNameSpan: config!.lintNameSpan,
      );
      if (lint.errors?.isNotEmpty ?? false) {
        errorComposer.addErrors(lint.errors!);
      } else {
        final activateLints = ref.read(activatedLintsProvider(root));
        activateLints.addLint(lint);
      }
    }
    for (var codeEdit in codeEdits) {
      final editId = codeEdit.key;
      final edit = codeEdit.value();
      delegate.sidecarMessage('activating $editId');
      final config = projectConfig.getConfiguration(codeEdit.key);
      edit.initialize(
        configurationContent: config?.configuration,
        ref: ref,
        lintNameSpan: config!.lintNameSpan,
      );
      if (edit.errors != null) {
        errorComposer.addErrors(edit.errors!);
      } else {
        ref.read(activatedEditsProvider(root)).addEdit(edit);
      }
    }
  }

  Future<List<AnalysisError>> getAnalysisErrors(
    String path,
  ) async {
    final analyzedFile = AnalyzedFile(root, path);
    ref.read(queuedFilesProvider(root)).removePath(path);
    final rootPath = root.root.path;
    final analysisPath = context.contextRoot.optionsFile?.path;

    if (!context.isSidecarEnabled) return [];
    if (!p.isWithin(rootPath, path)) return [];

    if (path == analysisPath) {
      // we handle analyzing the config file separately
      final errorComposer = ref.read(errorComposerProvider(root));
      errorComposer.clearErrors();
      await projectConfigurationService.parse();
      initializeLintsAndEdits();
      return errorComposer.flush();
    }

    final analysisResults = await _computeLints(path);

    ref.read(analysisResultsProvider(analyzedFile).notifier).state =
        analysisResults;

    for (var result in analysisResults) {
      delegate.analysisResult(result);
    }

    return analysisResults
        .map((result) => result.toAnalysisError())
        .whereType<AnalysisError>()
        .toList();
  }

  Future<Iterable<PrioritizedSourceChange>> getCodeAssists(
    ResolvedUnitResult unit,
    int offset,
    int length,
  ) async {
    final analyzedFile = AnalyzedFile(root, unit.path);
    final codeEditReporter = ErrorReporter(analyzedFile, ref);
    final edits = ref.read(activatedEditsProvider(root)).codeEdits;
    final computedFixes = await Future.wait(edits.map((edit) async {
      try {
        return await codeEditReporter.generateDartFixes(
          unit,
          edit,
          offset,
          length,
        );
      } catch (e, stackTrace) {
        channel.sendError('CodeEdit Misc error: $e', stackTrace);
      }
    }));
    final flattenedList = computedFixes
        .whereType<List<PrioritizedSourceChange>>()
        .expand((element) => element)
        .toList();

    return flattenedList;
  }

  Future<Iterable<AnalysisResult>> _computeLints(
    String sourcePath,
  ) async {
    final analyzedFile = AnalyzedFile(root, sourcePath);
    final errorReporter = ErrorReporter(analyzedFile, ref);

    final detectedLints = <AnalysisResult>[];
    final allLintRules = ref.read(activatedLintsProvider(root)).lintRules;

    //TODO: allow analysis of other file extensions
    if (p.extension(sourcePath) == '.dart') {
      final unit = await context.currentSession.getResolvedUnit(sourcePath);

      if (unit is! ResolvedUnitResult) return [];

      delegate.sidecarVerboseMessage('analyzeFile          : $sourcePath');
      await Future.wait(allLintRules.map<Future<void>>((rule) async {
        if (!_isPathIncludedForRule(rule: rule, path: sourcePath)) {
          return;
        }

        try {
          final lintConfig =
              projectConfigurationService.getLintConfiguration(rule.id);

          final lints =
              await errorReporter.generateDartLints(unit, rule, lintConfig);
          detectedLints.addAll(lints);
        } catch (e, stackTrace) {
          channel.sendError('LintRule Error: ${e.toString()}', stackTrace);
        }
      }));
      delegate.sidecarVerboseMessage('analyzeFile completed: $sourcePath');
    }
    return detectedLints;
  }

  bool _isPathIncludedForRule({
    required String path,
    required LintRule rule,
  }) {
    final relativePath = p.relative(path, from: root.root.path);

    // #1 check explicit LintRule/CodeEdit includes from project config
    final ruleProjectConfig =
        projectConfigurationService.getLintConfiguration(rule.id);
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
    return projectConfigurationService.projectConfiguration
            ?.includes(relativePath) ??
        false;
  }

  SourceSpan sidecarLintSourceSpan(
    String packageId,
    String lintId,
  ) {
    final contents = projectConfigurationService.contents;
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
  }
}

final analysisContextServiceProvider =
    Provider.family<AnalysisContextService, AnalysisContext>(
        (ref, context) => AnalysisContextService(ref, context: context));
