import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../configurations/project/project_configuration.dart';
import '../protocol/constants/constants.dart';
import '../protocol/constants/default_sidecar_yaml.dart';
import '../protocol/models/context_details.dart';
import '../protocol/protocol.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

class ActiveProjectService {
  const ActiveProjectService();

  ActiveContext? initActiveContextFromUri(
    Uri contextUri, {
    ResourceProvider? resourceProvider,
  }) {
    try {
      if (!isContextActive(contextUri)) return null;

      final pluginUri = getSidecarPluginUriForPackage(contextUri);
      final packages = getSidecarDependencies(contextUri);
      final projectConfig = getSidecarOptions(contextUri);
      final packageConfigJson = getPackageConfig(contextUri);
      final context = _createAnalysisContextForUri(contextUri,
          resourceProvider: resourceProvider);

      return ActiveContext(
        context: context,
        sidecarOptions: projectConfig!,
        sidecarPluginPackage: pluginUri!,
        sidecarPackages: packages,
        isExplicitlyEnabled: true,
        packageConfigJson: packageConfigJson,
      );
    } catch (e, stackTrace) {
      logger.severe('ActivePackageService initializeContext', e, stackTrace);
      rethrow;
      // return null;
    }
  }

  ActiveContext? getActiveContext(
    AnalysisContext context,
  ) {
    try {
      final contextUri = context.contextRoot.root.toUri();
      if (!isContextActive(contextUri)) return null;

      final pluginUri = getSidecarPluginUriForPackage(contextUri);
      final packages = getSidecarDependencies(contextUri);
      final projectConfig = getSidecarOptions(contextUri);
      final packageConfigJson = getPackageConfig(contextUri);

      return ActiveContext(
        context: context,
        sidecarOptions: projectConfig!,
        sidecarPluginPackage: pluginUri!,
        sidecarPackages: packages,
        isExplicitlyEnabled: true,
        packageConfigJson: packageConfigJson,
      );
    } catch (e, stackTrace) {
      logger.severe('ActivePackageService initializeContext', e, stackTrace);
      rethrow;
      // return null;
    }
  }

  AnalysisContext _createAnalysisContextForUri(
    Uri root, {
    ResourceProvider? resourceProvider,
  }) {
    var path = root.normalizePath().path;

    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }

    final collection = AnalysisContextCollection(
      includedPaths: [path],
      resourceProvider: resourceProvider,
    );
    return collection.contextFor(path);
  }

  bool isContextActive(
    Uri root,
  ) {
    final pluginUri = getSidecarPluginUriForPackage(root);
    final packages = getSidecarDependencies(root);
    final projectConfig = getSidecarOptions(root);

    if (projectConfig == null ||
        pluginUri == null ||
        //TODO: !root.isSidecarEnabled ||
        packages.isEmpty) {
      return false;
    }
    return true;
  }

  /// Finds any contexts that
  List<ActiveContext> getActiveDependencies(
    ActiveContext mainContext,
    List<AnalysisContext> allContexts,
  ) {
    final config = getPackageConfig(mainContext.activeRoot.root.toUri());
    // get all contexts that are within the working directory and
    // are dependencies of the main active root
    final contexts = allContexts
        .where((context) => config.packages
            .where((pkg) => pkg.root != mainContext.activeRoot.root.toUri())
            .any(
              (package) =>
                  package.root.normalizePath().path ==
                  context.contextRoot.root.toUri().normalizePath().path,
            ))
        .toList();

    // check for any options files, etc. if none are available,
    // inherit the details from main root
    return contexts.map(
      (analysisContext) {
        final root = analysisContext.contextRoot;
        final contextUri = root.root.toUri();
        final pluginUri = getSidecarPluginUriForPackage(contextUri);
        if (pluginUri != null) {
          assert(pluginUri != mainContext.sidecarPluginPackage,
              'plugin package must be identical between any active roots within the same isolate.');
        }
        final packages = getSidecarDependencies(contextUri);
        final projectConfig = getSidecarOptions(contextUri);
        final packageConfigJson = getPackageConfig(contextUri);

        return ActiveContext(
          context: analysisContext,
          sidecarOptions: projectConfig ?? mainContext.sidecarOptions,
          sidecarPluginPackage: pluginUri ?? mainContext.sidecarPluginPackage,
          //TODO: do we need to inherit packages of main root below?
          sidecarPackages: packages,
          isExplicitlyEnabled: false,
          packageConfigJson: packageConfigJson,
        );
      },
    ).toList();
  }

  List<ContextDetails> createActiveContextDetails(
    Uri directory,
    ResourceProvider resourceProvider,
  ) {
    final collection = AnalysisContextCollection(
        includedPaths: [directory.path], resourceProvider: resourceProvider);
    return collection.contexts
        .map(
          (e) => ContextDetails(
            includesPaths: e.contextRoot.includedPaths.map(Uri.parse).toList(),
            excludesPaths: e.contextRoot.excludedPaths.map(Uri.parse).toList(),
            optionsFile: e.contextRoot.optionsFile?.toUri(),
            packagesFile: e.contextRoot.packagesFile?.toUri(),
          ),
        )
        .toList();
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
  PackageConfig getPackageConfig(Uri root) {
    final path = p.join(root.toFilePath(), '.dart_tool', 'package_config.json');
    final file = io.File(path);
    final contents = file.readAsBytesSync();
    return PackageConfig.parseBytes(contents, file.uri);
  }

  List<RulePackageConfiguration> getSidecarDependencies(Uri root) {
    return getPackageConfig(root)
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
  Package? getSidecarPluginUriForPackage(Uri root) {
    return getPackageConfig(root).packages.firstWhereOrNull((package) {
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
  name: 'activePackageServiceProvider',
  dependencies: const [],
);
