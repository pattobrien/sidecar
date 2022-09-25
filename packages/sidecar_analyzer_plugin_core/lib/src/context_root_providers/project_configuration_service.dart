import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_analyzer_plugin_core/sidecar_analyzer_plugin_core.dart';

import 'error_composer.dart';

final projectConfigurationServiceProvider =
    Provider.family<ProjectConfigurationService, ContextRoot>(
  (ref, contextRoot) =>
      ProjectConfigurationService(ref, contextRoot: contextRoot),
);

class ProjectConfigurationService {
  ProjectConfigurationService(
    this.ref, {
    required this.contextRoot,
  })  : logger = ref.read(logDelegateProvider),
        errorComposer = ref.read(errorComposerProvider(contextRoot));

  final ContextRoot contextRoot;
  final Ref ref;
  final LogDelegate logger;
  final ErrorComposer errorComposer;

  late String _contents;
  late ProjectConfiguration? _projectConfiguration;

  ProjectConfiguration? get projectConfiguration => _projectConfiguration;

  Future<void> parse() async {
    await _parseProjectConfiguration();
    // _getEditConfigurations();
    // _getLintConfigurations();
  }

  Future<void> _parseProjectConfiguration() async {
    logger.sidecarVerboseMessage('_parseProjectConfiguration');
    final optionsFile = contextRoot.optionsFile;
    if (optionsFile != null) {
      try {
        _contents = await io.File(optionsFile.path).readAsString();
        final sourceUrl = optionsFile.toUri();
        _projectConfiguration =
            ProjectConfiguration.parse(_contents, sourceUrl: sourceUrl);
        errorComposer.addErrors(_projectConfiguration!.sourceErrors);
      } catch (e) {
        _projectConfiguration = null;
        // throw UnimplementedError('cannot parse sidecar options: $e');
      }
    } else {
      _projectConfiguration = ProjectConfiguration();
    }

    logger.sidecarVerboseMessage('_parseProjectConfiguration completed');
  }

  // void _getEditConfigurations() {
  //   final editConfigurations = {};
  //   final edits = [...allCodeEdits[root]!];
  //   for (final edit in edits) {
  //     // delegate.sidecarVerboseMessage('setting up ${edit.code}');
  //     final config =
  //         _projectConfiguration.editConfiguration(edit.packageName, edit.code);
  //     if (config != null) {
  //       editConfigurations[contextRoot]![edit.code] = config;
  //     } else {
  //       editConfigurations[contextRoot]!.remove(edit.code);
  //     }
  //   }
  // }

  // void _getLintConfigurations() {
  //   lintConfigurations[root] = {};
  //   final rules = [...allLintRules[root]!];
  //   for (final lint in rules) {
  //     delegate.sidecarVerboseMessage('setting up ${lint.code}');
  //     final config =
  //         sidecarOptions.lintConfiguration(lint.packageName, lint.code);
  //     if (config != null) {
  //       lintConfigurations[root]![lint.code] = config;
  //     } else {
  //       lintConfigurations[root]!.remove(lint.code);
  //     }
  //     try {
  //       lint.initialize(configurationContent: config?.configuration, ref: ref);
  //     } catch (e) {
  //       // if the lint fails to configure, then it shouldnt be run
  //       allLintRules.remove(lint);
  //     }
  //   }
  // }
}
