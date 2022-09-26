import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../log_delegate/log_delegate.dart';
import 'config_error_composer.dart';

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
  final LogDelegateBase logger;
  final ConfigErrorComposer errorComposer;

  late String _contents;
  late ProjectConfiguration? _projectConfiguration;

  LintConfiguration? getLintConfiguration(Id id) =>
      _projectConfiguration?.lintConfiguration(id);

  EditConfiguration? getEditConfiguration(Id id) =>
      _projectConfiguration?.editConfiguration(id);

  ProjectConfiguration? get projectConfiguration => _projectConfiguration;
  String get contents => _contents;

  Future<void> parse() async {
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
      }
    } else {
      _projectConfiguration = ProjectConfiguration();
    }

    logger.sidecarVerboseMessage('_parseProjectConfiguration completed');
  }
}
