import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';
import '../plugin/protocol/protocol.dart';
import 'log_delegate/log_delegate.dart';

class ActivePackageService {
  const ActivePackageService(this._ref);

  final Ref _ref;

  void _log(String message) => _ref.read(logDelegateProvider).sidecarMessage;
  void _logError(Object e, StackTrace stackTrace) =>
      _ref.read(logDelegateProvider).sidecarError(e, stackTrace);

  // is this needed for any external functions ?
  // bool isValidDartProject(Uri root) =>
  //     File(p.join(root.toFilePath(), 'pubspec.yaml')).existsSync();

  ActiveContext? initializeContext(AnalysisContext analysisContext) {
    final root = analysisContext.contextRoot;
    final contextUri = root.root.toUri();

    final pluginUri = getSidecarPluginUriForPackage(contextUri);
    final packages = getSidecarDependencies(contextUri);
    final projectConfig = getSidecarOptions(root);

    final isSidecarEnabled = analysisContext.isSidecarEnabled;
    final hasProjectConfiguration = projectConfig != null;
    final hasSidecarPlugin = pluginUri != null;
    final hasLintPackages = packages.isNotEmpty;

    if (!isSidecarEnabled ||
        !hasProjectConfiguration ||
        !hasSidecarPlugin ||
        !hasLintPackages) {
      return null;
    }
    return ActiveContext(
      analysisContext,
      sidecarOptions: projectConfig,
      sidecarPluginPackage: pluginUri,
      sidecarPackages: packages,
    );
  }

  // is this needed for any external functions ?
  PackageConfig _getPackageConfig(Uri root) {
    final path = p.join(root.toFilePath(), '.dart_tool', 'package_config.json');
    final contents = File(path).readAsBytesSync();
    return PackageConfig.parseBytes(contents, root);
  }

  List<SidecarPackage> getSidecarDependencies(Uri root) {
    _log('findAllSidecarDeps for ${root.toFilePath()} // ${root.path}');
    return _getPackageConfig(root)
        .packages
        .map<SidecarPackage?>((package) {
          try {
            // _log(
            //     'findAllSidecarDeps for name ${package.name} @ path ${package.root.toFilePath(windows: Platform.isWindows)} // ${package.root.normalizePath().path}');
            return parseLintPackage(package.name, package.root);
          } catch (e, stackTrace) {
            _logError('NON-FATAL ERROR: findAllSidecarDeps $e', stackTrace);
            return null;
          }
        })
        .whereType<SidecarPackage>()
        .toList();
  }

  /// Get the plugin package uri for the current Dart project.
  Package? getSidecarPluginUriForPackage(Uri root) {
    return _getPackageConfig(root).packages.firstWhereOrNull((package) {
      return package.name == kSidecarPluginName;
    });
  }

  ProjectConfiguration? getSidecarOptions(ContextRoot contextRoot) {
    _log('_parseProjectConfiguration started');
    final file = contextRoot.optionsFile;
    if (file == null) return null;
    try {
      final contents = File(file.path).readAsStringSync();
      return ProjectConfiguration.parse(contents, sourceUrl: file.toUri());
    } catch (e, stackTrace) {
      _logError('_parseProjectConfiguration error: $e', stackTrace);
      return null;
    }
  }
}

final activePackageServiceProvider = Provider(
  ActivePackageService.new,
  dependencies: [
    logDelegateProvider,
  ],
);
