// ignore_for_file: implementation_imports, overridden_fields

import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/test_utilities/mock_sdk.dart';
import 'package:analyzer/src/test_utilities/resource_provider_mixin.dart';

import '../../../sidecar.dart';

class PubCacheCreator with ResourceProviderMixin {
  PubCacheCreator({
    required this.resourceProvider,
    required this.physicalResourceProvider,
  }) {
    build();
  }

  @override
  final MemoryResourceProvider resourceProvider;
  final PhysicalResourceProvider physicalResourceProvider;

  Folder get pubCacheFolder =>
      resourceProvider.getFolder('/.pub-cache/hosted/pub.dartlang.org');
  String get directoryPath => pubCacheFolder.path;

  void build() {
    //
  }

  File newSidecarOptionsFile(String directoryPath, String content) {
    final path = join(directoryPath, kSidecarYaml);
    return newFile(path, content);
  }

  void addPackageFromDisk(Uri packageUri) {
    final folder = physicalResourceProvider.getFolder(packageUri.path);
    folder.getChildren();
  }

  @override
  Folder newFolder(String path) {
    return super.newFolder(join(directoryPath, path));
  }

  @override
  File newFile(String path, String content) {
    return super.newFile(join(directoryPath, path), content);
  }
}
