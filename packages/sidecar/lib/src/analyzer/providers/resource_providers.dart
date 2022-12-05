// ignore_for_file: implementation_imports

import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:analyzer/src/dart/analysis/file_content_cache.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/constants/constants.dart';
import '../../utils/byte_store_ext.dart';

final analyzerResourceProvider = Provider<OverlayResourceProvider>(
  (ref) => OverlayResourceProvider(PhysicalResourceProvider.INSTANCE),
  name: 'analyzerResourceProvider',
  dependencies: const [],
);

final fileSystemProvider =
    Provider<FileSystem>((ref) => const LocalFileSystem());

final byteStoreProvider = Provider<ByteStore>((ref) {
  final resourceProvider = ref.watch(analyzerResourceProvider);
  return resourceProvider.createByteStore(kSidecarPluginName);
});

final fileContentCache = Provider<FileContentCache>((ref) {
  final provider = ref.watch(analyzerResourceProvider);
  return FileContentCache(provider);
});
