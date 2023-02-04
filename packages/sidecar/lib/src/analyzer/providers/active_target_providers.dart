import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_files.dart';
import '../../protocol/protocol.dart';
import '../../services/active_project_service.dart';
import '../../services/glob_service.dart';
import '../../utils/uri_ext.dart';
import 'resource_providers.dart';
import 'sidecar_spec_providers.dart';

/// The target of a particular Analyzer instance.
///
/// Provider is overridden with a URI argument passed during Isolate initialization.
final activeTargetRootProvider =
    Provider<Uri>((ref) => throw UnimplementedError());

final activePackageProvider = Provider<ActivePackage>((ref) {
  final root = ref.watch(activeTargetRootProvider);
  final scope = ref.watch(workspaceScopeProvider);
  final service = ref.watch(activeProjectServiceProvider);
  final activePackage = service.getActivePackageFromUri(root);
  assert(activePackage != null,
      "active package should never be null from the analyzer's perspective.");
  return scope.isNotEmpty
      ? activePackage!.copyWith(workspaceScope: scope)
      : activePackage!;
});

/// Roots of packages to be analyzed in this context.
///
/// Different implementations are made for:
/// - Plugin:
/// - CLI / Debugger:
final workspaceScopeProvider = StateProvider<List<Uri>>((ref) => []);

/// List of AnalysisContexts for the current Active Package scope.
///
/// Analysis scope is defined based on different Sidecar modes:
/// - Plugin mode: scope = all contexts within the IDE's open workspace
/// - CLI / Debugger mode: scope = single context at the ActivePackage root
final contextCollectionProvider = Provider<List<AnalysisContext>>((ref) {
  final activePackage = ref.watch(activePackageProvider);
  final byteStore = ref.watch(byteStoreProvider);
  final contentCache = ref.watch(fileContentCache);
  final resourceProvider = ref.watch(analyzerResourceProvider);

  final scope = activePackage.workspaceScope ?? [activePackage.root];

  final collection = runZonedGuarded(
    () => AnalysisContextCollectionImpl(
      includedPaths: scope.map((uri) => uri.pathNoTrailingSlash).toList(),
      byteStore: byteStore,
      resourceProvider: resourceProvider,
      fileContentCache: contentCache,
    ),
    (e, s) {},
    zoneSpecification: ZoneSpecification(print: (_, __, ___, line) {}),
  );

  if (collection == null) throw UnimplementedError();

  return collection.contexts.where((context) {
    return scope.any((uri) => context.contextRoot.root.toUri() == uri);
  }).toList();
});

/// Generates in-scope files based on sidecar.yaml top-level includes/excludes globs.
final activeProjectScopedFilesProvider = Provider<AnalyzedFiles>((ref) {
  final activeProjectIncludes = ref.watch(activeProjectIncludeGlobsProvider);
  final activeProjectExcludes = ref.watch(activeProjectExcludeGlobsProvider);
  final contexts = ref.watch(contextCollectionProvider);
  final fileSystem = ref.watch(fileSystemProvider);
  final globService = ref.watch(globServiceProvider);

  final allFiles = contexts
      .map((context) {
        final filesInScope = globService.extractDartFilesFromFolders(
            context.contextRoot.root.path,
            fileSystem: fileSystem,
            globalIncludes: activeProjectIncludes,
            globalExcludes: activeProjectExcludes);
        return filesInScope
            .map((e) => AnalyzedFile(Uri.file(e),
                contextRoot: context.contextRoot.root.toUri()))
            .toList();
      })
      .expand((e) => e)
      .toSet();
  return AnalyzedFiles(allFiles);
});
