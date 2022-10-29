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

class ActiveContext implements AnalysisContext {
  ActiveContext(
    this._context, {
    required this.sidecarOptions,
    required this.sidecarPluginPackage,
    required this.sidecarPackages,
    // required this.localDependencyContexts,

    required this.isMainRoot,
  });

  final AnalysisContext _context;
  final ProjectConfiguration sidecarOptions;
  final Package sidecarPluginPackage;
  final List<RulePackageConfiguration> sidecarPackages;
  // final List<AnalysisContext> localDependencyContexts;

  /// Indicates the package that explicitly activates Sidecar as a plugin.
  final bool isMainRoot;

  ActiveContextRoot get activeRoot => ActiveContextRoot(
        _context.contextRoot,
        isMainRoot: isMainRoot,
      );

  @override
  AnalysisOptions get analysisOptions => _context.analysisOptions;

  @override
  Future<List<String>> applyPendingFileChanges() =>
      _context.applyPendingFileChanges();

  @override
  void changeFile(String path) => _context.changeFile(path);

  @override
  ContextRoot get contextRoot => _context.contextRoot;

  @override
  AnalysisSession get currentSession => _context.currentSession;

  @override
  Folder? get sdkRoot => _context.sdkRoot;
}

extension ContextsX on List<ActiveContext> {
  ActiveContext? contextFor(AnalyzedFile analyzedFile) {
    return firstWhereOrNull((activeContext) => activeContext.activeRoot
        .analyzedFiles()
        .any((filePath) => filePath == analyzedFile.path));
  }
}
