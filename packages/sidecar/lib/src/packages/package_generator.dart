import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

import 'package:path/path.dart' as p;

import '../../sidecar.dart';
import 'sidecar_type.dart';

class PackageGenerator {
  PackageGenerator();

  Future<void> generateForPubPackage(String path) async {
    final buffer = StringBuffer();
    final collection = AnalysisContextCollection(
      includedPaths: [path],
      resourceProvider: PhysicalResourceProvider.INSTANCE,
    );
    // final context = collection.contexts.first;
    // print('$path // contexts = ${collection.contexts.length}');

    final types = <SidecarType>{};
    for (final context in collection.contexts) {
      final uri = Uri.parse('$path/lib/riverpod.dart');
      final file = File(uri.path);

      if (!file.existsSync()) throw StateError('file doesnt exist');

      final lib = await context.currentSession.getResolvedUnit(uri.path);
      if (lib is! ResolvedUnitResult) throw UnimplementedError('error');

      // print(
      //     'got lib: ${lib.path} w ${lib.libraryElement.exportedLibraries.length} elements');
      final packageName = lib.libraryElement.name;
      print(
          'got lib: $packageName w ${lib.libraryElement.context.declaredVariables.variableNames.length} vars');

      for (final topLevelElement in lib.libraryElement.exportedLibraries) {
        print('elements = ${topLevelElement.topLevelElements.length}');
        for (final x in topLevelElement.topLevelElements
            .where((element) => element.isPublic)) {
          // final extendedName = topLevelElement.getExtendedDisplayName(null);
          final name = x.name!;
          final package = packageName;
          // final str = generateTypeChecker(name, package);
          types.add(SidecarType(typeName: name, packageName: package));
          // buffer.writeln(str);
        }
      }
    }
    buffer.writeln(generatedHeader);
    for (final t in types) {
      buffer.writeln(generateTypeChecker(t.typeName, t.packageName));
    }
    final contents = buffer.toString();
    final packageRoot = Directory.current;
    final generatedPackagePath = p.join(packageRoot.path, 'tool', 'test.dart');
    final file = File(generatedPackagePath);
    await file.create(recursive: true);
    await file.writeAsString(contents);
  }
}

String generatedHeader = '''
import 'package:sidecar/sidecar.dart';

''';

String generateTypeChecker(String name, String packageName) {
  return '''
const ${name}TypeChecker =
    TypeChecker.fromName('$name', packageName: '$packageName');
''';
}
