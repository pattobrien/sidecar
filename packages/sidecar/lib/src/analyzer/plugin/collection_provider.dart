import 'dart:async';

// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../utils/logger/logger.dart';
import '../handlers/byte_store.dart';
import '../handlers/file_content_cache.dart';
import '../plugin/analyzer_resource_provider.dart';
import 'active_package_provider.dart';

final contextCollectionProvider = Provider((ref) {
  final activePackage = ref.watch(activePackageProvider);
  final byteStore = ref.watch(createByteStoreProvider);
  final contentCache = ref.watch(createFileContentCacheProvider);
  final resourceProvider = ref.watch(analyzerResourceProvider);

  final scope =
      activePackage.workspaceScope ?? [activePackage.packageRoot.root];
  final includesPaths = scope.map((uri) {
    if (uri.path.endsWith('/')) {
      return uri.path.substring(0, uri.path.length - 1);
    } else {
      return uri.path;
    }
  }).toList();

  final collection = runZonedGuarded(
    () => AnalysisContextCollectionImpl(
      includedPaths: includesPaths,
      byteStore: byteStore,
      resourceProvider: resourceProvider,
      fileContentCache: contentCache,
      // sdkPath: sdkPath,
    ),
    (e, s) => logger.severe('collection error: $e $s'),
    zoneSpecification: ZoneSpecification(print: (_, __, ___, line) {}),
  );

  print(
      'collection complete: ${collection?.contexts.map((e) => e.contextRoot.root.path)}');

  if (collection == null) throw UnimplementedError();

  final contexts = collection.contexts.where((context) {
    return scope.any((uri) => context.contextRoot.root.toUri() == uri);
  }).toList();
  return contexts;
});
