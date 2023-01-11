//
// copied from dart-code-metrics package
//

import 'package:file/file.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

final globServiceProvider = Provider<GlobService>((ref) => GlobServiceImpl());

abstract class GlobService {
  bool isExcluded(String relativePath, Iterable<Glob> excludes);
  bool isIncluded(String relativePath, Iterable<Glob> includes);
  Set<String> extractDartFilesFromFolders(
    String rootFolder, {
    required FileSystem fileSystem,
    required Iterable<Glob> globalIncludes,
    required Iterable<Glob> globalExcludes,
  });
}

class GlobServiceImpl extends GlobService {
  @override
  bool isExcluded(String relativePath, Iterable<Glob> excludes) {
    final path = relativePath.replaceAll(r'\', '/');

    return excludes.any((exclude) => exclude.matches(path));
  }

  @override
  bool isIncluded(String relativePath, Iterable<Glob> includes) {
    final path = relativePath.replaceAll(r'\', '/');

    return includes.any((exclude) => exclude.matches(path));
  }

  // Iterable<Glob> prepareExcludes(
  //   Iterable<String> patterns,
  //   String root,
  // ) =>
  //     patterns
  //         .map((exclude) =>
  //             Glob(p.normalize(p.join(root, exclude)).replaceAll(r'\', '/')))
  //         .toList();

  @override
  Set<String> extractDartFilesFromFolders(
    String rootFolder, {
    required FileSystem fileSystem,
    required Iterable<Glob> globalIncludes,
    required Iterable<Glob> globalExcludes,
  }) =>
      Glob('**/*', context: p.Context(current: rootFolder))
          .listFileSystemSync(
            fileSystem,
            root: rootFolder,
            followLinks: false,
          )
          .whereType<File>()
          .where((entity) =>
              !isExcluded(
                p.relative(entity.path, from: rootFolder),
                globalExcludes,
              ) &&
              isIncluded(
                p.relative(entity.path, from: rootFolder),
                globalIncludes,
              ))
          .map((entity) {
        return p.normalize(entity.path);
      }).toSet();
}
