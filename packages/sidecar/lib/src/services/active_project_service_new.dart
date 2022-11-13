import 'dart:io' as io;

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/context_locator.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:collection/collection.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../analyzer/context/active_package.dart';
import '../analyzer/context/context.dart';
import '../configurations/project/project_configuration.dart';
import '../protocol/constants/constants.dart';
import '../protocol/constants/default_sidecar_yaml.dart';
import '../protocol/protocol.dart';
import '../utils/logger/logger.dart';
import '../utils/utils.dart';

class ActiveProjectServiceNew {
  const ActiveProjectServiceNew();

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

  // ActiveContext? initActiveContextFromUri(
  //   Uri contextUri, {
  //   ResourceProvider? resourceProvider,
  // }) {
  //   try {
  //     if (!isContextActive(contextUri)) return null;

  //     final pluginUri = getSidecarPluginUriForPackage(contextUri);
  //     final packages = getSidecarDependencies(contextUri);
  //     final projectConfig = getSidecarOptions(contextUri);
  //     final packageConfigJson = getPackageConfig(contextUri);

  //     final allContexts = _createAnalysisContextsForUri(contextUri,
  //         resourceProvider: resourceProvider);

  //     final primaryContext = allContexts.contextForRoot(contextUri);

  //     return ActiveContext(
  //       context: primaryContext!,
  //       allRoots: _getDependencyContexts(allContexts, packageConfigJson),
  //       sidecarOptions: projectConfig!,
  //       sidecarPluginPackage: pluginUri!,
  //       sidecarPackages: packages,
  //       isExplicitlyEnabled: true,
  //       packageConfigJson: packageConfigJson,
  //     );
  //   } catch (e, stackTrace) {
  //     logger.severe('ActivePackageService initializeContext', e, stackTrace);
  //     rethrow;
  //   }
  // }

  // List<AnalysisContext> _getDependencyContexts(
  //   List<AnalysisContext> allContexts,
  //   PackageConfig packageConfigJson,
  // ) {
  //   return allContexts
  //       .where((context) => packageConfigJson.packages
  //           .any((package) => package.root == context.contextRoot.root.toUri()))
  //       .toList();
  // }

  // ActiveContext? getActiveContext(
  //   AnalysisContext context,
  //   List<AnalysisContext> allContexts,
  // ) {
  //   try {
  //     final contextUri = context.contextRoot.root.toUri();
  //     if (!isContextActive(contextUri)) return null;

  //     final pluginUri = getSidecarPluginUriForPackage(contextUri);
  //     final packages = getSidecarDependencies(contextUri);
  //     final projectConfig = getSidecarOptions(contextUri);
  //     final packageConfigJson = getPackageConfig(contextUri);
  //     final dependencyContexts =
  //         _getDependencyContexts(allContexts, packageConfigJson);

  //     return ActiveContext(
  //       context: context,
  //       allRoots: dependencyContexts,
  //       sidecarOptions: projectConfig!,
  //       sidecarPluginPackage: pluginUri!,
  //       sidecarPackages: packages,
  //       isExplicitlyEnabled: true,
  //       packageConfigJson: packageConfigJson,
  //     );
  //   } catch (e, stackTrace) {
  //     logger.severe('ActivePackageService initializeContext', e, stackTrace);
  //     rethrow;
  //     // return null;
  //   }
  // }

  // List<AnalysisContext> _createAnalysisContextsForUri(
  //   Uri root, {
  //   ResourceProvider? resourceProvider,
  // }) {
  //   var path = root.normalizePath().path;

  //   if (path.endsWith('/')) {
  //     path = path.substring(0, path.length - 1);
  //   }

  //   final collection = AnalysisContextCollection(
  //     includedPaths: [path],
  //     resourceProvider: resourceProvider,
  //   );
  //   return collection.contexts;
  // }

  // bool isContextActive(
  //   Uri root,
  // ) {
  //   final pluginUri = getSidecarPluginUriForPackage(root);
  //   final packages = getSidecarDependencies(root);
  //   final projectConfig = getSidecarOptions(root);

  //   if (projectConfig == null ||
  //       pluginUri == null ||
  //       //TODO: !root.isSidecarEnabled ||
  //       packages.isEmpty) {
  //     return false;
  //   }
  //   return true;
  // }

  // List<ContextDetails> createActiveContextDetails(
  //   Uri directory,
  //   ResourceProvider resourceProvider,
  // ) {
  //   final collection = AnalysisContextCollection(
  //       includedPaths: [directory.path], resourceProvider: resourceProvider);
  //   return collection.contexts
  //       .map(
  //         (e) => ContextDetails(
  //           includesPaths: e.contextRoot.includedPaths.map(Uri.parse).toList(),
  //           excludesPaths: e.contextRoot.excludedPaths.map(Uri.parse).toList(),
  //           optionsFile: e.contextRoot.optionsFile?.toUri(),
  //           packagesFile: e.contextRoot.packagesFile?.toUri(),
  //         ),
  //       )
  //       .toList();
  // }

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

final activeProjectServiceNewProvider = Provider(
  (ref) => const ActiveProjectServiceNew(),
  name: 'activeProjectServiceNewProvider',
  dependencies: const [],
);
