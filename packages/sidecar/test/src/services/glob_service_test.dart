import 'package:file/memory.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart';
import 'package:sidecar/src/services/glob_service.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final globService = GlobServiceImpl();

  group('Glob Service', () {
    final libGlob = [Glob('lib/**')];
    final libMainFilePath = join('lib', 'main.dart');
    final binMainFilePath = join('bin', 'main.dart');

    test('File is included', () {
      final result = globService.isIncluded(libMainFilePath, libGlob);
      expect(result, true);
    });

    test('File is not included', () {
      final result = globService.isIncluded(binMainFilePath, libGlob);
      expect(result, false);
    });

    test('File is excluded', () {
      final result = globService.isExcluded(libMainFilePath, libGlob);
      expect(result, true);
    });

    test('File is not excluded', () {
      final result = globService.isExcluded(binMainFilePath, libGlob);
      expect(result, false);
    });
  });

  group('Glob Service - combining globs', () {
    final fileSystem = MemoryFileSystem();
    final packageRoot = join('dev', 'packages', 'my_package');
    final packageLib = join(packageRoot, 'lib');

    final mdFile = join(packageLib, 'test.md');
    final dartFile = join(packageLib, 'test.dart');
    final yamlFile = join(packageLib, 'test.yaml');

    setUp(() {
      fileSystem.directory(packageLib).createSync(recursive: true);
      fileSystem.file(yamlFile).writeAsStringSync('');
      fileSystem.file(dartFile).writeAsStringSync('');
      fileSystem.file(mdFile).writeAsStringSync('');
    });

    // test('description', () {
    //   final files = globService.extractDartFilesFromFolders(
    //     packageRoot,
    //     fileSystem: fileSystem,
    //     globalIncludes: [
    //       Glob('lib/*.dart', context: Context(current: packageRoot)),
    //     ],
    //     globalExcludes: [
    //       //
    //     ],
    //   );
    //   expect(files, {mdFile, dartFile, yamlFile});
    // });
  });
}
