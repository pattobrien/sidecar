import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../configurations/project/project_configuration.dart';
import '../configurations/rule_package/rule_package_configuration.dart';
import '../protocol/active_package.dart';
import '../protocol/constants/constants.dart';
import '../protocol/constants/default_sidecar_yaml.dart';
import '../protocol/protocol.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

class ActiveProjectService {
  const ActiveProjectService();

  List<ActivePackage> getActivePackagesFromCollection(
    AnalysisContextCollection collection,
  ) {
    return collection.contexts
        .map(getActivePackageFromContext)
        .whereNotNull()
        .map((e) => e.copyWith(
            workspaceScope: collection.contexts
                .map((e) => e.contextRoot.root.toUri())
                .where((contextUri) => e.dependencies
                    .any((dependency) => dependency == contextUri))
                .toList()))
        .toList();
  }

  ActivePackage? getActivePackageFromUri(Uri root) {
    var path = root.path;
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    final collection = AnalysisContextCollection(includedPaths: [path]);
    final rootContext = collection.contextFor(path);
    return getActivePackageFromContext(rootContext);
  }

  ActivePackage? getActivePackageFromContext(
    AnalysisContext context,
  ) {
    //
    final root = context.contextRoot.root.toUri();
    final isSidecarEnabled = context.isSidecarEnabled;
    final pluginUri = _getSidecarPluginUriForPackage(root);
    final packages = getSidecarDependencies(root);
    final projectConfig = getSidecarOptions(root);
    final packageConfigJson = _getPackageConfig(root);
    if (pluginUri == null || !isSidecarEnabled || projectConfig == null) {
      return null;
    }
    return ActivePackage(
      root: root,
      sidecarOptionsFile: root.resolve(kSidecarYaml),
      sidecarPluginPackage: pluginUri.root,
      sidecarPackages: packages.map((e) => e.uri).toList(),
      dependencies: packageConfigJson.packages.map((e) => e.root).toList(),
    );
  }

  Future<bool> createDefaultSidecarYaml(Uri root) async {
    const contents = defaultSidecarContent;
    final file = io.File(p.join(root.path, kSidecarYaml));
    if (file.existsSync()) {
      return false;
    } else {
      await file.writeAsString(contents);
    }
    return true;
  }

  // is this needed for any external functions ?
  PackageConfig _getPackageConfig(Uri root) {
    final path = p.join(root.toFilePath(), '.dart_tool', 'package_config.json');
    final file = io.File(path);
    final contents = file.readAsBytesSync();
    return PackageConfig.parseBytes(contents, file.uri);
  }

  List<RulePackageConfiguration> getSidecarDependencies(Uri root) {
    return _getPackageConfig(root)
        .packages
        .map<RulePackageConfiguration?>((package) {
          try {
            return parseLintPackage(package.name, package.root);
          } catch (e, stackTrace) {
            logger.shout('ActivePackageService NON-FATAL', e, stackTrace);
            return null;
          }
        })
        .whereType<RulePackageConfiguration>()
        .toList();
  }

  /// Get the plugin package uri for the current Dart project.
  Package? _getSidecarPluginUriForPackage(Uri root) {
    return _getPackageConfig(root).packages.firstWhereOrNull((package) {
      return package.name == kSidecarPluginName;
    });
  }

  String? _getSidecarFile(Uri root) {
    final sidecarYamlPath = p.join(root.path, kSidecarYaml);
    final sidecarYamlFile = io.File(sidecarYamlPath);
    if (!sidecarYamlFile.existsSync()) return null;
    return sidecarYamlFile.readAsStringSync();
  }

  ProjectConfiguration? getSidecarOptions(Uri root) {
    logger.finer('getSidecarOptions started');
    try {
      final contents = _getSidecarFile(root);
      if (contents == null) return null;
      return ProjectConfiguration.fromYaml(
        contents,
        fileUri: Uri.parse(p.canonicalize(p.join(root.path, kSidecarYaml))),
      );
    } catch (e, stackTrace) {
      logger.shout('ISOLATE NON-FATAL: ', e, stackTrace);
      return null;
    }
  }
}

final activeProjectServiceProvider = Provider(
  (ref) => const ActiveProjectService(),
  name: 'activeProjectServiceNewProvider',
  dependencies: const [],
);
