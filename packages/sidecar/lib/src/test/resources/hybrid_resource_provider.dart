import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
// ignore: implementation_imports
import 'package:path/src/context.dart';

class HybridResourceProvider extends ResourceProvider {
  HybridResourceProvider({
    required this.physical,
    required this.memory,
  });

  final PhysicalResourceProvider physical;
  final MemoryResourceProvider memory;

  @override
  File getFile(String path) {
    return memory.getFile(path);
  }

  @override
  Folder getFolder(String path) {
    if (memory.getFolder(path).exists) return memory.getFolder(path);
    return copyFolderToMemory(path);
    // return memory.getFolder(path);
  }

  @override
  Resource getResource(String path) {
    // if (memory.getResource(path).exists) return memory.getResource(path);
    // return copyResourceToMemory(path);
    return memory.getResource(path);
  }

  @override
  Folder? getStateLocation(String pluginId) {
    final stateFolder = memory.getStateLocation(pluginId);
    if (stateFolder.exists) return stateFolder;
    return copyFolderToMemory(stateFolder.path);
  }

  Resource copyResourceToMemory(String path) {
    final physicalResource = physical.getResource(path);
    if (!physicalResource.exists) throw UnimplementedError();
    final memoryResource = memory.getResource(path);
    return physicalResource.copyTo(memoryResource.parent);
  }

  void modifyFile(String path, String content) =>
      memory.modifyFile(path, content);

  File newFile(String path, String content) => memory.newFile(path, content);

  File newFileWithBytes(String path, List<int> bytes) =>
      memory.newFileWithBytes(path, bytes);

  Folder newFolder(String path) => memory.newFolder(path);

  /// Create a link from the [path] to the [target].
  void newLink(String path, String target) => memory.newLink(path, target);

  File copyFileToMemory(String path) {
    final resource = copyResourceToMemory(path);
    return resource as File;
  }

  Folder copyFolderToMemory(String path) {
    final resource = copyResourceToMemory(path);
    return resource as Folder;
  }

  @override
  Context get pathContext => memory.pathContext;
  //
}
