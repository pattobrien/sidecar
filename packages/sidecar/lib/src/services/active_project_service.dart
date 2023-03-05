import 'dart:convert';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../configurations/rule_package/rule_package_configuration.dart';
import '../configurations/sidecar_spec/add_rules.dart';
import '../configurations/sidecar_spec/sidecar_spec.dart';
import '../protocol/active_package.dart';
import '../protocol/constants/constants.dart';
import '../protocol/protocol.dart';
import '../server/server_providers.dart';
import '../utils/get_sdk.dart';
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
                .where((contextUri) => e.packageConfig.packages.any(
                    (dependency) =>
                        dependency.root.toFilePath() ==
                        contextUri.toFilePath()))
                .toList()))
        .toList();
  }

  ActivePackage? getActivePackageFromUri(Uri root) {
    final path = root.pathNoTrailingSlash;
    final dartSdk = getDartSdkPathForPackage(root, resourceProvider);
    // print('DART SDK: $dartSdk');
    // final sdkSummaryPath =
    //     p.join(Directory.current.path, kDartTool, 'sidecar', 'sdk.dill');
    final collection = AnalysisContextCollectionImpl(
      includedPaths: [path],
      resourceProvider: resourceProvider,
      sdkPath: dartSdk,
      // sdkSummaryPath: sdkSummaryPath,
    );
    final rootContext = collection.contextFor(path);
    return getActivePackageFromContext(rootContext);
  }

  ActivePackage? getActivePackageFromContext(
    AnalysisContext context,
  ) {
    final root = context.contextRoot.root.toUri();
    final packageConfig = getPackageConfig(root);
    final pluginUri = getSidecarDependencyUri(packageConfig);
    final projectSidecarSpec = getSidecarOptions(root);
    final packageConfigJson = getPackageConfig(root);

    if (pluginUri == null || projectSidecarSpec == null) {
      // logger.info('context at ${root.path} is not an active sidecar context.');
      // logger.info(
      //     '${root.path} does not have sidecar enabled in analysis_options.yaml');
      return null;
    }
    return ActivePackage(root: root, packageConfig: packageConfigJson);
  }

  Future<void> createDefaultSidecarYaml(Uri root) async {
    final uri = Uri.file(p.join(root.toFilePath(), kSidecarYaml));
    final file = resourceProvider.getFile(uri.toFilePath());
    final config = getPackageConfig(root);
    final dependencies = getSidecarDependencies(config);
    final content = addRulesToSidecarSpecContents(
        file.readAsStringSync(), file.toUri(), dependencies);
    file.writeAsStringSync(content);
  }

  PackageConfig getPackageConfig(Uri root) {
    final uri =
        Uri.file(p.join(root.toFilePath(), kDartTool, kPackageConfigJson));
    final path = uri.toFilePath();
    final file = resourceProvider.getFile(path);
    assert(file.exists, 'config file does not exist at path $uri');
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
    final sidecarYamlUri = Uri.file(p.join(root.toFilePath(), kSidecarYaml));
    final sidecarYamlFile =
        resourceProvider.getFile(sidecarYamlUri.toFilePath());
    if (!sidecarYamlFile.exists) return null;
    return sidecarYamlFile.readAsStringSync();
  }

  SidecarSpec? getSidecarOptions(Uri root) {
    // logger.finer('getSidecarOptions started');
    try {
      final contents = _getSidecarFile(root);
      if (contents == null) return null;
      return parseSidecarSpec(
        contents,
        fileUri:
            Uri.file(p.canonicalize(p.join(root.toFilePath(), kSidecarYaml))),
      ).data;
    } catch (e) {
      // logger.shout('ISOLATE NON-FATAL: ', e, stackTrace);
      return null;
    }
  }
}

final activeProjectServiceProvider = Provider(
  (ref) {
    final resourceProvider = ref.watch(serverResourceProvider);
    return ActiveProjectService(resourceProvider: resourceProvider);
  },
  name: 'activeProjectServiceNewProvider',
  dependencies: [
    serverResourceProvider,
  ],
);
