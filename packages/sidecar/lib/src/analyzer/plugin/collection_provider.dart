// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../handlers/byte_store.dart';
import '../handlers/file_content_cache.dart';
import '../plugin/analyzer_resource_provider.dart';

part 'collection_provider.g.dart';

@Riverpod(keepAlive: true)
class ContextCollection extends _$ContextCollection {
  @override
  List<AnalysisContext> build() {
    return [];
  }

  void setContextCollection(
    List<String> includes,
    List<String> excludes,
  ) {
    // print('setContextCollection - $includes');
    final byteStore = ref.watch(createByteStoreProvider);
    final contentCache = ref.watch(createFileContentCacheProvider);
    final resourceProvider = ref.watch(analyzerResourceProvider);

    final collection = runZonedGuarded(
      () => AnalysisContextCollectionImpl(
        includedPaths: includes,
        byteStore: byteStore,
        resourceProvider: resourceProvider,
        fileContentCache: contentCache,
        // sdkPath: sdkPath,
      ),
      (e, s) {},
      zoneSpecification: ZoneSpecification(print: (_, __, ___, line) {}),
    );

    // print(
    //     'collection complete: ${collection?.contexts.map((e) => e.contextRoot.root.path)}');

    if (collection == null) throw UnimplementedError();

    state = collection.contexts;
  }
}
