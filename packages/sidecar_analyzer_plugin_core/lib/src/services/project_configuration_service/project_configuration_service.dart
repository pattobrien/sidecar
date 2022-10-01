import 'dart:async';
import 'dart:io' as io;

import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'package:sidecar/sidecar.dart';
import '../log_delegate/log_delegate.dart';

class ProjectConfigurationService {
  ProjectConfigurationService(
    Ref ref, {
    required this.contextRoot,
  }) : logger = ref.read(logDelegateProvider);

  final ContextRoot contextRoot;
  final LogDelegateBase logger;

  // final _controller = BehaviorSubject<ProjectConfiguration?>();
  // Stream<ProjectConfiguration?> get stream => _controller.stream;
  late ProjectConfiguration? configuration;

  Future<void> parse() async {
    logger.sidecarVerboseMessage('_parseProjectConfiguration');
    final optionsFile = contextRoot.optionsFile;
    if (optionsFile != null) {
      try {
        final contents = await io.File(optionsFile.path).readAsString();
        final sourceUrl = optionsFile.toUri();
        configuration =
            ProjectConfiguration.parse(contents, sourceUrl: sourceUrl);
        // _controller
        //     .add(ProjectConfiguration.parse(contents, sourceUrl: sourceUrl));
        return;
      } catch (e) {
        //
      }
    } else {
      // _controller.add(ProjectConfiguration(rawContent: contents));
    }

    // _controller.add(null);

    configuration = null;
    logger.sidecarVerboseMessage('_parseProjectConfiguration completed');
  }
}
