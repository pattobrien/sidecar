import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:package_config/package_config_types.dart';

import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';

import '../../sidecar.dart';
import 'sidecar_type.dart';

class PackageGenerator {
  PackageGenerator();

  Future<void> generate(Directory projectDirectory) async {
    final package = await getPackage(projectDirectory.path);
    // await generateForPubPackage(package.root.normalizePath());
  }

  Future<Package> getPackage(String rootPath) async {
    final uri = p.join(rootPath, 'pubspec.yaml');
    final pubspecFile = File(uri);
    final pubspecContents = await pubspecFile.readAsString();
    final rootPackage =
        Pubspec.parse(pubspecContents, sourceUrl: pubspecFile.uri);
    final yaml = loadYaml(pubspecContents) as YamlMap;
    final packageName = yaml['sidecar_package'] as String;

    // check if dependency is version locked
    rootPackage.dependencies.entries.where((entry) {
      final dependency = entry.value;
      if (dependency is! HostedDependency) return false;
      return true;
      //TODO: how can we check that the dependency is locked?
    });

    // get the package
    final packageConfigFile =
        File(p.join(rootPath, '.dart_tool', 'package_config.json'));
    final packageConfigContents = await packageConfigFile.readAsString();
    final packageConfig =
        PackageConfig.parseString(packageConfigContents, packageConfigFile.uri);

    final package = packageConfig.packages
        .firstWhere((element) => element.name == packageName);
    print(package.name);
    return package;
  }

  Future<void> generateForPubPackage(Uri packageUri) async {
    final buffer = StringBuffer();
    final packageDirectory = Directory.fromUri(packageUri);
    assert(packageDirectory.existsSync(), 'package doesnt exist');
    final collection = AnalysisContextCollection(
      includedPaths: [packageUri.path],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );
    final pubspecFile = File(p.join(packageDirectory.path, 'pubspec.yaml'));
    final pubspecContents = await pubspecFile.readAsString();
    final rootPackage =
        Pubspec.parse(pubspecContents, sourceUrl: pubspecFile.uri);
    final libName = rootPackage.name;
    // final context = collection.contexts.first;
    // print('$path // contexts = ${collection.contexts.length}');

    final types = <SidecarType>{};
    for (final context in collection.contexts) {
      // final uri = Uri.parse('$path/lib/riverpod.dart');
      final file = File('${packageUri.path}/lib/riverpod.dart');

      if (!file.existsSync()) {
        throw StateError('file doesnt exist - ${file.path}');
      }

      final unit = await context.currentSession.getResolvedUnit(file.path);
      if (unit is! ResolvedUnitResult) throw UnimplementedError('error');

      // print(
      //     'got lib: ${lib.path} w ${lib.libraryElement.exportedLibraries.length} elements');
      final exports = unit.libraryElement.exportNamespace.definedNames;

      for (final exportEntry in exports.entries) {
        // final extendedName = topLevelElement.getExtendedDisplayName(null);
        final library = await context.currentSession
            .getResolvedLibraryByElement(exportEntry.value.library!);
        if (library is! ResolvedLibraryResult) {
          throw UnimplementedError('lib resolve error');
        }

        final name = exportEntry.key;

        final absoluteUri =
            Uri.file(library.element.identifier, windows: Platform.isWindows);
        final fp = absoluteUri.toFilePath(windows: Platform.isWindows);
        final fpfile = File(fp);

        if (!file.existsSync()) {
          throw StateError('no file @ ${fpfile.path} // $fp');
        }

        final relativeRootPath = p.relative(fpfile.path, from: packageUri.path);
        types.add(SidecarType(
          typeName: name,
          packageName: libName,
          packagePath: relativeRootPath,
        ));
      }
    }
    buffer.writeln(generatedHeader);
    final contentBuffer = StringBuffer();
    for (final t in types) {
      contentBuffer.writeln(generateTypeChecker(t.typeName, t.packageName));
    }
    final generatedTypeCheckerClass =
        generateTypeCheckerClass(libName, contentBuffer.toString());

    buffer.write(generatedTypeCheckerClass);
    final contents = buffer.toString();
    final packageRoot = Directory.current;
    final generatedPackagePath = p.join(packageRoot.path, 'tool', 'test.dart');
    final file = File(generatedPackagePath);
    await file.create(recursive: true);
    await file.writeAsString(contents);
  }
}

String generateTypeCheckerClass(String name, String content) {
  final packageName = ReCase(name).pascalCase;
  return '''

class ${packageName}TypeCheckers {

  $content

}

''';
}

String generatedHeader = '''
//
// THIS IS A GENERATED FILE
//

import 'package:sidecar_package_utilities/sidecar_package_utilities.dart';

''';

String generateTypeChecker(String typeName, String packageName) {
  final recasedName = ReCase(typeName).camelCase;
  return '''
  static const ${recasedName}TypeChecker =
      TypeChecker.fromName('$typeName', packageName: '$packageName');
''';
}
