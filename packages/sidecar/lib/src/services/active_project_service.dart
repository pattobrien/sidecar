import 'dart:convert';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

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
    final packageConfig = getPackageConfig(root);
    final pluginUri = getSidecarDependencyUri(packageConfig);
    final packages = getSidecarDependencies(packageConfig);
    final projectConfig = getSidecarOptions(root);
    final packageConfigJson = getPackageConfig(root);
    if (pluginUri == null || !isSidecarEnabled || projectConfig == null) {
      logger.info('context at ${root.path} is not an active sidecar context.');
      if (!isSidecarEnabled) {
        logger.info(
            '${root.path} does not have sidecar enabled in analysis_options.yaml');
      }
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
  PackageConfig getPackageConfig(Uri root) {
    final path = p.join(root.path, kDartTool, kPackageConfigJson);
    final file = resourceProvider.getFile(path);
    assert(file.exists, 'config file does not exist at path $path');
    final contents = file.readAsStringSync();
    final json = jsonDecode(contents) as Map<String, dynamic>;
    return PackageConfig.parseJson(json, file.toUri());
  }

  List<RulePackageConfiguration> getSidecarDependencies(PackageConfig config) {
    return config.packages
        .map((package) => parseLintPackage(package.name, package.root))
        .whereNotNull()
        .toList();
  }

  /// Parse a project's package_config.json file for ```sidecar``` dependency.
  Uri? getSidecarDependencyUri(PackageConfig config) {
    return config.packages.firstWhereOrNull((package) {
      return package.name == kSidecarPluginName;
    })?.root;
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
