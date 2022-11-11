// ignore_for_file: implementation_imports

import 'package:analyzer/src/dart/analysis/byte_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../protocol/constants/constants.dart';
import '../../utils/byte_store_ext.dart';
import '../plugin/analyzer_resource_provider.dart';

part 'byte_store.g.dart';

@Riverpod(keepAlive: true)
ByteStore createByteStore(CreateByteStoreRef ref) {
  final resourceProvider = ref.watch(analyzerResourceProvider);
  return resourceProvider.createByteStore(kSidecarPluginName);
}
