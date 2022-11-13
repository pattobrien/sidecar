// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../handlers/byte_store.dart';
import '../handlers/file_content_cache.dart';
import '../plugin/analyzer_resource_provider.dart';
import 'active_package_provider.dart';

// part 'collection_provider.g.dart';

// @Riverpod(keepAlive: true)
// class ContextCollection extends _$ContextCollection {
//   @override
//   List<AnalysisContext> build() {
//     return [];
//   }

//   void setContextCollection(
//     List<String> includes,
//     List<String> excludes,
//   ) {
//     // print('setContextCollection - $includes');
//     final byteStore = ref.watch(createByteStoreProvider);
//     final contentCache = ref.watch(createFileContentCacheProvider);
//     final resourceProvider = ref.watch(analyzerResourceProvider);
//     final includesPaths = includes.map((path) {
//       if (path.endsWith('/')) {
//         return path.substring(0, path.length - 1);
//       } else {
//         return path;
//       }
//     }).toList();
//     final excludesPaths = includes.map((path) {
//       if (path.endsWith('/')) {
//         return path.substring(0, path.length - 1);
//       } else {
//         return path;
//       }
//     }).toList();
//     final collection = runZonedGuarded(
//       () => AnalysisContextCollectionImpl(
//         includedPaths: includesPaths,
//         excludedPaths: excludesPaths,
//         byteStore: byteStore,
//         resourceProvider: resourceProvider,
//         fileContentCache: contentCache,
//         // sdkPath: sdkPath,
//       ),
//       (e, s) {
//         print('collection error: $e $s');
//       },
//       zoneSpecification: ZoneSpecification(print: (_, __, ___, line) {}),
//     );

//     print(
//         'collection complete: ${collection?.contexts.map((e) => e.contextRoot.root.path)}');

//     if (collection == null) throw UnimplementedError();

//     state = collection.contexts;
//   }
// }

final contextCollectionProvider = Provider((ref) {
  final activePackage = ref.watch(activePackageProvider).value!;
  final byteStore = ref.watch(createByteStoreProvider);
  final contentCache = ref.watch(createFileContentCacheProvider);
  final resourceProvider = ref.watch(analyzerResourceProvider);
  // final includes = [activePackage.root];
  final scope = activePackage.workspaceScope ?? [activePackage.root];
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
    return scope.any((uri) => context.contextRoot.root.toUri() == uri);
  }).toList();
  return contexts;
});
