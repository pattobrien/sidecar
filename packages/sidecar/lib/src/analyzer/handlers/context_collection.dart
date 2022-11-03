// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../plugin/analyzer_plugin_old.dart';
import '../plugin/plugin_resource_provider.dart';
import 'byte_store.dart';
import 'file_content_cache.dart';

part 'context_collection.g.dart';

@riverpod
AnalysisContextCollection contextCollection(
  ContextCollectionRef ref,
  List<String> roots,
) {
  final byteStore = ref.watch(createByteStoreProvider);
  final contentCache = ref.watch(createFileContentCacheProvider);
  final resourceProvider = ref.watch(analyzerResourceProvider);

  return runZonedGuarded(
    () => AnalysisContextCollectionImpl(
      includedPaths: roots,
      byteStore: byteStore,
      resourceProvider: resourceProvider,
      fileContentCache: contentCache,
      // sdkPath: sdkPath,
    ),
    (e, s) {},
    zoneSpecification: ZoneSpecification(print: (_, __, ___, line) {}),
  )!;
}
