import 'package:analyzer/file_system/file_system.dart';
import 'package:file/file.dart' hide File;
import 'package:path/path.dart' as p;

import '../../protocol/constants/constants.dart';
import 'hybrid_resource_provider.dart';

mixin ResourceMixin {
  ResourceProvider get resourceProvider;
  FileSystem get fileSystem;
  String get rootPath;

  File getFile(String path) => resourceProvider.getFile(path);
  Folder getFolder(String path) => resourceProvider.getFolder(path);

  Folder newFolder(String path) {
    final folderPath = p.join(rootPath, path);
    fileSystem.directory(folderPath).createSync(recursive: true);
    return resourceProvider.getFolder(folderPath)..create();
  }

  File newFile(String relativePath, String content) {
    final filePath = p.join(rootPath, relativePath);
    final file = resourceProvider.getFile(filePath);
    file.parent.create();
    file.exists;
    file.writeAsStringSync(content);
    fileSystem.file(file.path).createSync(recursive: true);
    return file;
  }
}
