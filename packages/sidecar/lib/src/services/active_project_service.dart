import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/context.dart';
import '../analyzer/plugin/analyzer_plugin.dart';
import '../configurations/project/project_configuration.dart';
import '../protocol/constants/constants.dart';
import '../protocol/constants/default_sidecar_yaml.dart';
import '../protocol/protocol.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

class ActiveProjectService {
  const ActiveProjectService();

  ActiveContext? initializeContext(
    AnalysisContext analysisContext,
  ) {
    try {
      final contextUri = analysisContext.contextRoot.root.toUri();
      final pluginUri = getSidecarPluginUriForPackage(contextUri);
      final packages = getSidecarDependencies(contextUri);
      final projectConfig = getSidecarOptions(analysisContext.contextRoot);

      if (!isContextActive(analysisContext)) return null;

      return ActiveContext(
        analysisContext,
        sidecarOptions: projectConfig!,
        sidecarPluginPackage: pluginUri!,
        sidecarPackages: packages,
        isMainRoot: true,
      );
    } catch (e, stackTrace) {
      logger.severe('ActivePackageService initializeContext', e, stackTrace);
      return null;
    }
  }

  bool isContextActive(
    AnalysisContext analysisContext,
  ) {
    final contextUri = analysisContext.contextRoot.root.toUri();
    final pluginUri = getSidecarPluginUriForPackage(contextUri);
    final packages = getSidecarDependencies(contextUri);
    final projectConfig = getSidecarOptions(analysisContext.contextRoot);

    if (!analysisContext.isSidecarEnabled ||
        projectConfig == null ||
        pluginUri == null ||
        packages.isEmpty) {
      return false;
    }
    return true;
  }

  List<AnalysisContext> getAllContextsFromPath(List<String> paths) {
    final collection = AnalysisContextCollection(includedPaths: paths);
    return collection.contexts;
  }

  List<ActiveContext> getActiveContextsFromPath(List<String> paths) {
    final collection = AnalysisContextCollection(includedPaths: paths);
    return collection.contexts
        .map(initializeContext)
        .whereType<ActiveContext>()
        .toList();
  }

  /// Finds any contexts that
  List<ActiveContext> getActiveDependencies(
    ActiveContext mainContext,
    List<AnalysisContext> allContexts,
  ) {
    final config = _getPackageConfig(mainContext.activeRoot.root.toUri());
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
        final projectConfig = getSidecarOptions(root);
        return ActiveContext(
          analysisContext,
          sidecarOptions: projectConfig ?? mainContext.sidecarOptions,
          sidecarPluginPackage: pluginUri ?? mainContext.sidecarPluginPackage,
          //TODO: do we need to inherit packages of main root below?
          sidecarPackages: packages,
          isMainRoot: false,
        );
      },
    ).toList();
  }

  Future<bool> createDefaultSidecarYaml(Uri root) async {
    const contents = defaultSidecarContent;
    final file = File(p.join(root.path, kSidecarYaml));
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
    final file = File(path);
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
  Package? getSidecarPluginUriForPackage(Uri root) {
    return _getPackageConfig(root).packages.firstWhereOrNull((package) {
      return package.name == kSidecarPluginName;
    });
  }

  String? _getSidecarFile(ContextRoot contextRoot) {
    final sidecarYamlPath = p.join(contextRoot.root.path, kSidecarYaml);
    final sidecarYamlFile = File(sidecarYamlPath);
    if (!sidecarYamlFile.existsSync()) return null;
    return sidecarYamlFile.readAsStringSync();
  }

  ProjectConfiguration? getSidecarOptions(ContextRoot contextRoot) {
    logger.finer('getSidecarOptions started');
    try {
      final contents = _getSidecarFile(contextRoot);
      if (contents == null) return null;
      return ProjectConfiguration.fromYaml(
        contents,
        fileUri: Uri.parse(contextRoot.root.canonicalizePath(kSidecarYaml)),
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
