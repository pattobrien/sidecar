import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../configurations/project/project_configuration.dart';
import '../protocol/constants/constants.dart';
import '../protocol/protocol.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

class ActivePackageService {
  const ActivePackageService(this._ref);

  final Ref _ref;

  void _log(String msg) => _ref.read(logDelegateProvider).sidecarMessage(msg);
  void _logError(Object e, StackTrace stackTrace) =>
      _ref.read(logDelegateProvider).sidecarError(e, stackTrace);

  // is this needed for any external functions ?
  // bool isValidDartProject(Uri root) =>
  //     File(p.join(root.toFilePath(), 'pubspec.yaml')).existsSync();

  ActiveContext? initializeContext(AnalysisContext analysisContext) {
    try {
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
    } catch (e, stackTrace) {
      _logError('ActivePackageService ERROR: ${e.toString()}', stackTrace);
      rethrow;
    }
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
    // final file = contextRoot.optionsFile;
    final rootPath = contextRoot.root.path;
    final sidecarYamlPath = p.join(rootPath, kSidecarOptionsYaml);
    final sidecarYamlFile = File(sidecarYamlPath);
    if (!sidecarYamlFile.existsSync()) return null;
    // if (file == null) return null;
    try {
      final contents = sidecarYamlFile.readAsStringSync();
      return ProjectConfiguration.parseFromSidecarYaml(contents,
          sourceUrl: sidecarYamlFile.uri);
    } catch (e, stackTrace) {
      _logError(
          'ISOLATE NON-FATAL: _parseProjectConfiguration || $e', stackTrace);
      return null;
    }
  }
}

final activePackageServiceProvider = Provider(
  ActivePackageService.new,
  name: 'activePackageServiceProvider',
  dependencies: [
    logDelegateProvider,
  ],
);
