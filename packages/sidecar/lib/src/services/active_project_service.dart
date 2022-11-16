import 'dart:convert';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../analyzer/plugin/plugin.dart';
import '../analyzer/server/runner/context_providers.dart';
import '../configurations/project/project_configuration.dart';
import '../configurations/rule_package/rule_package_configuration.dart';
import '../protocol/active_package.dart';
import '../protocol/active_package_root.dart';
import '../protocol/constants/constants.dart';
import '../protocol/constants/default_sidecar_yaml.dart';
import '../protocol/protocol.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

class ActiveProjectService {
  const ActiveProjectService({
    required this.resourceProvider,
  });

  final ResourceProvider resourceProvider;

  List<ActivePackage> getActivePackagesFromCollection(
    AnalysisContextCollection collection,
  ) {
    return collection.contexts
        .map(getActivePackageFromContext)
        .whereNotNull()
        .map((e) => e.copyWith(
            workspaceScope: collection.contexts
                .map((e) => e.contextRoot.root.toUri())
                .where((contextUri) =>
                    e.packageConfig?.packages
                        .any((dependency) => dependency.root == contextUri) ??
                    false)
                .toList()))
        .toList();
  }

  ActivePackage? getActivePackageFromUri(Uri root) {
    var path = root.path;
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    final collection = AnalysisContextCollection(
        includedPaths: [path], resourceProvider: resourceProvider);
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
      packageRoot: ActivePackageRoot(root),
      sidecarOptionsFile: projectConfig,
      sidecarPluginPackage: pluginUri,
      // sidecarPackages: packages,
      packageConfig: packageConfigJson,
    );
  }

  Future<bool> createDefaultSidecarYaml(Uri root) async {
    const contents = defaultSidecarContent;
    final path = p.join(root.path, kSidecarYaml);
    final file = resourceProvider.getFile(path);
    if (file.exists) {
      return false;
    } else {
      file.writeAsStringSync(contents);
      return true;
    }
  }

  // is this needed for any external functions ?
  PackageConfig _getPackageConfig(Uri root) {
    final path = p.join(root.path, '.dart_tool', 'package_config.json');
    final file = resourceProvider.getFile(path);
    assert(file.exists, 'config file does not exist at path $path');
    final contents = file.readAsStringSync();
    final json = jsonDecode(contents) as Map<String, dynamic>;
    return PackageConfig.parseJson(json, file.toUri());
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
    final sidecarYamlUri = Uri.parse(p.join(root.path, kSidecarYaml));
    final sidecarYamlFile = resourceProvider.getFile(sidecarYamlUri.path);
    if (!sidecarYamlFile.exists) return null;
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
  (ref) {
    final resourceProvider = ref.watch(runnerResourceProvider);
    return ActiveProjectService(resourceProvider: resourceProvider);
  },
  name: 'activeProjectServiceNewProvider',
  dependencies: [
    runnerResourceProvider,
  ],
);
