// ignore_for_file: implementation_imports

import 'package:analyzer/src/dart/analysis/file_content_cache.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../plugin/analyzer_resource_provider.dart';

part 'file_content_cache.g.dart';

@Riverpod(keepAlive: true)
FileContentCache createFileContentCache(CreateFileContentCacheRef ref) {
  final provider = ref.watch(analyzerResourceProvider);
  return FileContentCache(provider);
}
