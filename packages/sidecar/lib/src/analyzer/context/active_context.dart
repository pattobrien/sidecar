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
    required this.isExplicitlyEnabled,
  });

  final AnalysisContext context;
  final ProjectConfiguration sidecarOptions;
  final Package sidecarPluginPackage;
  final List<RulePackageConfiguration> sidecarPackages;

  /// Indicates the package was explicitly activated as a Sidecar plugin, as
  /// opposed to being a dependency of a package that has Sidecar enabled.
  final bool isExplicitlyEnabled;

  bool get isDependency => !isExplicitlyEnabled;

  ActiveContextRoot get activeRoot => ActiveContextRoot(
        context.contextRoot,
        isExplicitlyEnabledRoot: isExplicitlyEnabled,
      );

  AnalysisOptions get analysisOptions => context.analysisOptions;

  Future<List<String>> applyPendingFileChanges() =>
      context.applyPendingFileChanges();

  void changeFile(String path) => context.changeFile(path);

  ContextRoot get contextRoot => context.contextRoot;

  AnalysisSession get currentSession => context.currentSession;

  Folder? get sdkRoot => context.sdkRoot;
}

enum ActiveContextType { dependency, explicit }

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
