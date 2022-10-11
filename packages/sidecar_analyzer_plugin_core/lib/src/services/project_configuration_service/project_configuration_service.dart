import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../log_delegate/log_delegate.dart';

class ProjectConfigurationService {
  ProjectConfigurationService(
    this.ref, {
    required this.contextRoot,
  });

  final ContextRoot contextRoot;
  final Ref ref;

  LogDelegateBase get logger => ref.read(logDelegateProvider);

  Future<ProjectConfiguration?> parse() async {
    logger.sidecarVerboseMessage('_parseProjectConfiguration started');
    final optionsFile = contextRoot.optionsFile;
    if (optionsFile != null) {
      try {
        final contents = await io.File(optionsFile.path).readAsString();
        final sourceUrl = optionsFile.toUri();
        return ProjectConfiguration.parse(contents, sourceUrl: sourceUrl);
      } catch (e) {
        logger.sidecarVerboseMessage('_parseProjectConfiguration error: $e');
      }
    }
    return null;
  }
}
