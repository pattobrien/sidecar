import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import 'log_delegate/log_delegate.dart';

class ProjectConfigurationService {
  const ProjectConfigurationService(this.ref);

  final Ref ref;

  LogDelegateBase get logger => ref.read(logDelegateProvider);

  ProjectConfiguration? parse(ContextRoot contextRoot) {
    logger.sidecarVerboseMessage('_parseProjectConfiguration started');
    final file = contextRoot.optionsFile;
    if (file == null) return null;
    try {
      final contents = io.File(file.path).readAsStringSync();
      return ProjectConfiguration.parse(contents, sourceUrl: file.toUri());
    } catch (e) {
      logger.sidecarVerboseMessage('_parseProjectConfiguration error: $e');
      return null;
    }
  }
}
