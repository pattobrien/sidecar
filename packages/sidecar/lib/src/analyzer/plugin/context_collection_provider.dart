import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/logger/logger.dart';
import '../../utils/uri_ext.dart';
import '../handlers/byte_store.dart';
import '../handlers/file_content_cache.dart';
import '../plugin/analyzer_resource_provider.dart';
import 'active_package_provider.dart';

/// List of AnalysisContexts for the current Active Package scope.
///
/// Analysis scope is defined based on different Sidecar modes:
/// - Plugin mode: scope = all contexts within the IDE's open workspace
/// - CLI / Debugger mode: scope = single context at the ActivePackage root
final contextCollectionProvider = Provider<List<AnalysisContext>>((ref) {
  final activePackage = ref.watch(activePackageProvider);
  final byteStore = ref.watch(createByteStoreProvider);
  final contentCache = ref.watch(createFileContentCacheProvider);
  final resourceProvider = ref.watch(analyzerResourceProvider);

  final scope =
      activePackage.workspaceScope ?? [activePackage.packageRoot.root];

  final collection = runZonedGuarded(
    () => AnalysisContextCollectionImpl(
      includedPaths: scope.map((uri) => uri.pathNoTrailingSlash).toList(),
      byteStore: byteStore,
      resourceProvider: resourceProvider,
      fileContentCache: contentCache,
      // sdkPath: sdkPath,
    ),
    (e, s) => logger.severe('collection error: $e $s'),
    zoneSpecification: ZoneSpecification(print: (_, __, ___, line) {}),
  );

  print('collection: ${collection?.contexts.map((e) => e.contextRoot.root)}');

  if (collection == null) throw UnimplementedError();

  return collection.contexts.where((context) {
    return scope.any((uri) => context.contextRoot.root.toUri() == uri);
  }).toList();
});
