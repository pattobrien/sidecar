import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_options.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/dart/analysis/session.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:package_config/package_config_types.dart';

import '../../configurations/configurations.dart';
import '../../protocol/protocol.dart';
import 'context.dart';

part 'active_context.freezed.dart';
// part 'active_context.g.dart';

@freezed
class ActiveContext with _$ActiveContext {
  const factory ActiveContext({
    required AnalysisContext context,

    /// Active configuration file for this context.
    required ProjectConfiguration sidecarOptions,

    /// Used to keep track of the running plugin's version.
    required Package sidecarPluginPackage,

    /// Contains details of this context's dependencies.
    required PackageConfig packageConfigJson,

    /// List of all packages that contain lint/assist rules.
    required List<RulePackageConfiguration> sidecarPackages,

    /// Indicates the package was explicitly activated as a Sidecar plugin, as
    /// opposed to being a dependency of a package that has Sidecar enabled.
    required bool isExplicitlyEnabled,
    required List<AnalysisContext> allRoots,
  }) = _ActiveContext;

  const ActiveContext._();

  bool get isDependency => !isExplicitlyEnabled;

  ActiveContextRoot get activeRoot => ActiveContextRoot(
        context.contextRoot,
        // isExplicitlyEnabledRoot: isExplicitlyEnabled,
      );

  List<String> activeAnalyzedFiles() {
    return [
      ...contextRoot.analyzedFiles(),
    ];
  }

  AnalysisOptions get analysisOptions => context.analysisOptions;

  Future<List<String>> applyPendingFileChanges() =>
      context.applyPendingFileChanges();

  void changeFile(String path) => context.changeFile(path);

  ContextRoot get contextRoot => context.contextRoot;

  AnalysisSession get currentSession => context.currentSession;

  Folder? get sdkRoot => context.sdkRoot;
}

enum ActiveContextType { dependency, explicit }

extension ActiveContextsX on List<ActiveContext> {
  ActiveContext? contextFor(AnalyzedFile analyzedFile) {
    return firstWhereOrNull((activeContext) => activeContext.activeRoot
        .analyzedFiles()
        .any((file) => file == analyzedFile.path));
  }

  ActiveContext? contextForPath(String path) {
    return firstWhereOrNull((activeContext) => activeContext.activeRoot
        .analyzedFiles()
        .any((filePath) => filePath == path));
  }
}

extension AnalysisContextsX on List<AnalysisContext> {
  AnalysisContext? contextForPath(String path) {
    return firstWhereOrNull((context) => context.contextRoot
        .analyzedFiles()
        .any((filePath) => filePath == path));
  }

  AnalysisContext? contextForRoot(Uri root) {
    return firstWhereOrNull((context) {
      final contextRoot = context.contextRoot.root.toUri();
      return contextRoot == root;
    });
  }

  Context? contextRootForPath(String path) {
    final analysisContext = firstWhereOrNull((context) => context.contextRoot
        .analyzedFiles()
        .any((filePath) => filePath == path));
    if (analysisContext == null) return null;
    return Context(root: analysisContext.contextRoot.root.toUri());
  }
}
