import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_options.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config_types.dart';

import '../../configurations/configurations.dart';
import '../../protocol/protocol.dart';
import 'context.dart';

class ActiveContext {
  ActiveContext(
    this.context, {
    required this.sidecarOptions,
    required this.sidecarPluginPackage,
    required this.sidecarPackages,
    required this.isMainRoot,
  });

  final AnalysisContext context;
  final ProjectConfiguration sidecarOptions;
  final Package sidecarPluginPackage;
  final List<RulePackageConfiguration> sidecarPackages;

  /// Indicates the package that explicitly activates Sidecar as a plugin.
  final bool isMainRoot;

  ActiveContextRoot get activeRoot => ActiveContextRoot(
        context.contextRoot,
        isMainRoot: isMainRoot,
      );

  // @override
  AnalysisOptions get analysisOptions => context.analysisOptions;

  // @override
  Future<List<String>> applyPendingFileChanges() =>
      context.applyPendingFileChanges();

  // @override
  void changeFile(String path) => context.changeFile(path);

  // @override
  ContextRoot get contextRoot => context.contextRoot;

  // @override
  AnalysisSession get currentSession => context.currentSession;

  // @override
  Folder? get sdkRoot => context.sdkRoot;
}

extension ContextsX on List<ActiveContext> {
  ActiveContext? contextFor(AnalyzedFile analyzedFile) {
    return firstWhereOrNull((activeContext) => activeContext.activeRoot
        .analyzedFiles()
        .any((filePath) => filePath == analyzedFile.path));
  }

  ActiveContext? contextForPath(String path) {
    return firstWhereOrNull((activeContext) => activeContext.activeRoot
        .analyzedFiles()
        .any((filePath) => filePath == path));
  }
}
