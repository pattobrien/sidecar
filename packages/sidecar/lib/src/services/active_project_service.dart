import 'dart:convert';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../analyzer/server/runner/context_providers.dart';
import '../configurations/rule_package/rule_package_configuration.dart';
import '../configurations/sidecar_spec/sidecar_spec.dart';
import '../protocol/active_package.dart';
import '../protocol/constants/constants.dart';
import '../protocol/constants/default_sidecar_yaml.dart';
import '../protocol/protocol.dart';
import '../utils/logger/logger.dart';
import '../utils/uri_ext.dart';
import '../utils/utils.dart';

/// Interact with a package to determine if its capable of Sidecar analysis.
class ActiveProjectService {
  /// Interact with a package to determine if its capable of Sidecar analysis.
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
                .where((contextUri) => e.packageConfig.packages
                    .any((dependency) => dependency.root == contextUri))
                .toList()))
        .toList();
  }

  ActivePackage? getActivePackageFromUri(Uri root) {
    final path = root.pathNoTrailingSlash;
    final collection = AnalysisContextCollection(
        includedPaths: [path], resourceProvider: resourceProvider);
    final rootContext = collection.contextFor(path);
    return getActivePackageFromContext(rootContext);
  }

  ActivePackage? getActivePackageFromContext(
    AnalysisContext context,
  ) {
    final root = context.contextRoot.root.toUri();
    final isSidecarEnabled = context.isSidecarEnabled;
    final packageConfig = getPackageConfig(root);
    final pluginUri = getSidecarDependencyUri(packageConfig);
    final projectSidecarSpec = getSidecarOptions(root);
    final packageConfigJson = getPackageConfig(root);

    if (pluginUri == null || !isSidecarEnabled || projectSidecarSpec == null) {
      logger.info('context at ${root.path} is not an active sidecar context.');
      if (!isSidecarEnabled) {
        logger.info(
            '${root.path} does not have sidecar enabled in analysis_options.yaml');
      }
      return null;
    }
    return ActivePackage(root: root, packageConfig: packageConfigJson);
  }

  Future<bool> createDefaultSidecarYaml(Uri root) async {
    const contents = templateSidecarContent;
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

  SidecarSpec? getSidecarOptions(Uri root) {
    logger.finer('getSidecarOptions started');
    try {
      final contents = _getSidecarFile(root);
      if (contents == null) return null;
      return parseSidecarSpec(
        contents,
        fileUri: Uri.parse(p.canonicalize(p.join(root.path, kSidecarYaml))),
      ).item1;
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
