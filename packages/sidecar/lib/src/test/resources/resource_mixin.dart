import 'package:analyzer/file_system/file_system.dart';
import 'package:file/file.dart' hide File;
import 'package:path/path.dart' as p;

mixin ResourceMixin {
  ResourceProvider get resourceProvider;
  FileSystem get fileSystem;
  String get rootPath;

  File getFile(String path) => resourceProvider.getFile(p.join(rootPath, path));
  Folder getFolder(String path) =>
      resourceProvider.getFolder(p.join(rootPath, path));

  Folder newFolder(String path) {
    final folderPath = p.join(rootPath, path);
    fileSystem.directory(folderPath).createSync(recursive: true);
    return resourceProvider.getFolder(folderPath)..create();
  }

  File modifyFile(String relativePath, String content) {
    final filePath = p.join(rootPath, relativePath);
    final file = resourceProvider.getFile(filePath);
    if (!file.exists) {
      file.parent.create();
    }
    file.writeAsStringSync(content);
    fileSystem.file(file.path).createSync(recursive: true);
    return file;
  }
}
