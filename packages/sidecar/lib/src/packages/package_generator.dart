import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_style/dart_style.dart';
import 'package:package_config/package_config_types.dart';

import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';

import '../../sidecar.dart';
import 'sidecar_type.dart';

class PackageGenerator {
  PackageGenerator();

  Future<void> generate(Directory projectDirectory) async {
    // get the package we want to create a utility package from
    final package = await getPackage(projectDirectory.path);
    // create the utility package
    await generateForPubPackage(projectDirectory.uri, package);
  }

  Future<Package> getPackage(String rootPath) async {
    final uri = p.join(rootPath, 'pubspec.yaml');
    final pubspecFile = File(uri);
    final pubspecContents = await pubspecFile.readAsString();
    final yaml = loadYaml(pubspecContents) as YamlMap;
    final packageName = yaml['sidecar_package'] as String;

    // check if dependency is version locked
    // final rootPackage =
    //     Pubspec.parse(pubspecContents, sourceUrl: pubspecFile.uri);
    // rootPackage.dependencies.entries.where((entry) {
    //   final dependency = entry.value;
    //   if (dependency is! HostedDependency) return false;
    //   return true;
    //   //TODO: how can we check that the dependency is locked?
    // });
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

  Future<void> generateForPubPackage(Uri projectUri, Package package) async {
    // print('generated for project: ${projectUri.path}');
    final buffer = StringBuffer();
    var packagePath = package.root.normalizePath().path;
    if (packagePath.endsWith('/')) {
      packagePath = packagePath.substring(0, packagePath.length - 1);
    }

    // print(packagePath);

    final collection = AnalysisContextCollection(
      includedPaths: [packagePath],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );

    final pubspecFile = File(p.join(package.root.path, 'pubspec.yaml'));
    final pubspecContents = await pubspecFile.readAsString();
    final rootPackage =
        Pubspec.parse(pubspecContents, sourceUrl: pubspecFile.uri);

    final types = <SidecarType>{};

    for (final context in collection.contexts) {
      final packageSrcPath = p.join(package.root.path, 'lib', 'src');
      final packageLibPath = p.join(package.root.path, 'lib');
      final filePaths = context.contextRoot.analyzedFiles().where((filePath) {
        final isWithinSrc = p.isWithin(packageSrcPath, filePath);
        final isWithinLib = p.isWithin(packageLibPath, filePath);
        return isWithinLib && !isWithinSrc;
      });

      // print(packageSrcPath);
      // print('# = ${filePaths.length}');

      for (final filePath in filePaths) {
        final contentBuffer = StringBuffer()..writeln(generatedHeader);
        final unit = await context.currentSession.getResolvedUnit(filePath);
        if (unit is! ResolvedUnitResult) throw UnimplementedError('error');

        final exports = unit.libraryElement.exportNamespace.definedNames;

        for (final exportEntry in exports.entries) {
          final library = await context.currentSession
              .getResolvedLibraryByElement(exportEntry.value.library!);

          if (library is! ResolvedLibraryResult) throw UnimplementedError();

          final name = exportEntry.key;

          final relativeFilePath =
              p.relative(filePath, from: package.root.path);
          final sidecarType = SidecarType(
            typeName: name,
            packageName: rootPackage.name,
            packagePath: relativeFilePath,
          );
          types.add(sidecarType);
        }

        final buffer = StringBuffer();
        for (final t in types) {
          print('generating checker for type: ${t.typeName}');
          buffer.writeln(generateTypeChecker(t.typeName, t.packagePath));
        }
        final generatedTypeCheckerClass =
            generateTypeCheckerClass(rootPackage.name, buffer.toString());
        contentBuffer.write(generatedTypeCheckerClass);
        final contents = contentBuffer.toString();
        final formatter = DartFormatter();
        // print('generating for: ${projectUri.path}');
        // print('generating for: $filePath');
        final relativeFilePath = p.relative(filePath, from: package.root.path);
        final generatedProjectPath = p.join(projectUri.path, relativeFilePath);
        // print('generating for: $generatedProjectPath');
        final formattedContents =
            formatter.format(contents, uri: generatedProjectPath);
        final generatedFile = File(generatedProjectPath);
        await generatedFile.create(recursive: true);
        await generatedFile.writeAsString(formattedContents);
        // create file

      }

      // print(
      //     'got lib: ${lib.path} w ${lib.libraryElement.exportedLibraries.length} elements');

    }
    // buffer.writeln(generatedHeader);
    // final contentBuffer = StringBuffer();
    // for (final t in types) {
    //   contentBuffer.writeln(generateTypeChecker(t.typeName, t.packageName));
    // }

    // buffer.write(generatedTypeCheckerClass);
    // final contents = buffer.toString();
    // final packageRoot = Directory.current;
    // final generatedPackagePath = p.join(packageRoot.path, 'tool', 'test.dart');
    // final file = File(generatedPackagePath);
    // await file.create(recursive: true);
    // await file.writeAsString(contents);
  }
}

// String generateTypeCheckerClass(String name, String content) {
//   final packageName = ReCase(name).pascalCase;
//   return '''

// class ${packageName}TypeCheckers {

//   $content

// }

// ''';
// }

String generatedHeader = '''
//
// THIS IS A GENERATED FILE
//

import 'package:sidecar_package_utilities/sidecar_package_utilities.dart';

''';

// String generateTypeChecker(String typeName, String packageName) {
//   final recasedName = ReCase(typeName).camelCase;
//   return '''
//   static const ${recasedName}TypeChecker =
//       TypeChecker.fromName('$typeName', packageName: '$packageName');
// ''';
// }

String generateTypeCheckerClass(String name, String content) {
  final packageName = ReCase(name).pascalCase;
  return '''

class ${packageName}Types {
  $content

}

''';
}

String generateTypeChecker(String typeName, String filePath) {
  final recasedName = ReCase(typeName).camelCase;
  return '''
  static const $recasedName = SidecarType('$typeName', '$filePath');
''';
}
