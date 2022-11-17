// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    (e, s) {
      print('collection error: $e $s');
    },
    zoneSpecification: ZoneSpecification(print: (_, __, ___, line) {}),
  );

  print(
      'collection complete: ${collection?.contexts.map((e) => e.contextRoot.root.path)}');

  if (collection == null) throw UnimplementedError();

  final contexts = collection.contexts.where((context) {
    return scope.any((uri) {
      final contextUri = context.contextRoot.root.toUri();
      return contextUri == uri;
    });
  }).toList();
  return contexts;
});
