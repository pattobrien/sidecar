//
// copied from dart-code-metrics package
//

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:file/file.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as p;

bool isExcluded(String absolutePath, Iterable<Glob> excludes) {
  final path = absolutePath.replaceAll(r'\', '/');

  return excludes.any((exclude) => exclude.matches(path));
}

bool isIncluded(String absolutePath, Iterable<Glob> includes) {
  final path = absolutePath.replaceAll(r'\', '/');

  return includes.any((exclude) => exclude.matches(path));
}

Iterable<Glob> prepareExcludes(
  Iterable<String> patterns,
  String root,
) =>
    patterns
        .map((exclude) =>
            Glob(p.normalize(p.join(root, exclude)).replaceAll(r'\', '/')))
        .toList();

Set<String> getFilePaths(
  Iterable<String> folders,
  AnalysisContext context,
  String rootFolder, {
  required FileSystem fileSystem,
  required Iterable<Glob> includes,
  required Iterable<Glob> excludes,
}) {
  final rootPath = context.contextRoot.root.path;

  final contextFolders = folders.where((path) {
    final folderPath = normalize(join(rootFolder, path));

    return folderPath == rootPath || folderPath.startsWith('$rootPath/');
  }).toList();

  return extractDartFilesFromFolders(contextFolders, rootFolder,
      fileSystem: fileSystem,
      globalIncludes: includes,
      globalExcludes: excludes);
}

Set<String> extractDartFilesFromFolders(
  Iterable<String> folders,
  String rootFolder, {
  required FileSystem fileSystem,
  required Iterable<Glob> globalIncludes,
  required Iterable<Glob> globalExcludes,
}) =>
    folders
        .expand((directory) => Glob('$directory/**.dart')
            .listFileSystemSync(
              fileSystem,
              root: rootFolder,
              followLinks: false,
            )
            .whereType<File>()
            .where((entity) =>
                !isExcluded(
                  relative(entity.path, from: rootFolder),
                  globalExcludes,
                ) &&
                isIncluded(
                  relative(entity.path, from: rootFolder),
                  globalIncludes,
                ))
            .map((entity) => normalize(entity.path)))
        .toSet();
