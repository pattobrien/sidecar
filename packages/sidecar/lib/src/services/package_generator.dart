import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_style/dart_style.dart';
import 'package:package_config/package_config_types.dart';

import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaml/yaml.dart';

import '../protocol/sidecar_type.dart';

final packageGeneratorProvider = Provider((ref) => const PackageGenerator());

class PackageGenerator {
  const PackageGenerator();

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

    final packageConfigFile =
        File(p.join(rootPath, '.dart_tool', 'package_config.json'));
    final packageConfigContents = await packageConfigFile.readAsString();
    final packageConfig =
        PackageConfig.parseString(packageConfigContents, packageConfigFile.uri);

    final package = packageConfig.packages
        .firstWhere((element) => element.name == packageName);
    // print(
    //     '${package.name} // ${package.root} // ${package.packageUriRoot} //  ${package.relativeRoot} //  ');
    return package;
  }

  Future<void> generateForPubPackage(Uri projectUri, Package package) async {
    var packagePath = package.root.normalizePath().path;
    if (packagePath.endsWith('/')) {
      packagePath = packagePath.substring(0, packagePath.length - 1);
    }

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

      for (final filePath in filePaths) {
        if (p.extension(filePath) != '.dart') continue;

        final contentBuffer = StringBuffer()
          ..writeln(generatedHeader(
            'src/${rootPackage.name}.dart',
          ));
        final unit = await context.currentSession.getResolvedUnit(filePath);
        if (unit is! ResolvedUnitResult) throw UnimplementedError('error');

        final exports = unit.libraryElement.exportNamespace.definedNames;

        for (final exportEntry in exports.entries.where((element) {
          if (element.value is VariableElement) return false;
          if (element.value is TopLevelVariableElement) return false;
          if (element.value is! InterfaceElement) return false;
          return true;
        })) {
          // final packageTypeUri = exportEntry.value.librarySource!.uri.resolve(reference);
          final relativeUri = p.relative(
              exportEntry.value.librarySource!.uri.path,
              from: package.packageUriRoot.path);
          final packageUri = 'package:${package.name}/$relativeUri';
          final sidecarType = SidecarType(
            typeName: exportEntry.key,
            packageName: rootPackage.name,
            packagePath: packageUri,
          );
          types.add(sidecarType);
        }

        final buffer = StringBuffer();

        for (final t in types) {
          // print('generating checker for type: ${t.typeName}');
          buffer.writeln(generateTypeChecker(t.typeName, t.packagePath));
        }

        contentBuffer.write(buffer.toString());
        final contents = contentBuffer.toString();
        final formatter = DartFormatter();

        final relativeFilePath = p.relative(filePath, from: package.root.path);
        final generatedProjectPath = p.join(projectUri.path, relativeFilePath);

        var formattedContents = '';
        try {
          formattedContents =
              formatter.format(contents, uri: generatedProjectPath);
        } catch (e) {
          formattedContents = contents;
        }

        final generatedFile = File(generatedProjectPath);
        await generatedFile.create(recursive: true);
        await generatedFile.writeAsString(formattedContents);
      }
    }
  }
}

String generatedHeader(String baseClassPath) => '''
//
// THIS IS A GENERATED FILE
//

import 'package:sidecar_package_utilities/sidecar_package_utilities.dart';

''';

String generateTypeChecker(String typeName, String filePath) {
  final recasedName = ReCase(typeName).camelCase;
  final url = '$filePath#$typeName';
  return '''
const ${recasedName}Type = TypeChecker.fromUrl('$url');
''';
}
