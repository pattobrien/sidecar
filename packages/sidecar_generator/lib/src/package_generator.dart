import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:sidecar_generator/src/visitor.dart';
import 'package:source_gen/source_gen.dart';

import 'package:sidecar/sidecar.dart';

class SidecarPackageGenerator
    extends GeneratorForAnnotation<SidecarPackageConfiguration> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw UnimplementedError('expected a ClassElement');
    }
    final visitor = Visitor();
    element.accept(visitor);

    final className = 'SomethingGen';

    final classBuffer = StringBuffer();

    final beginning = '''
@freezed
class $className with _\$$className {
  const $className._();
  const factory $className({
''';

    final end = '''
  }) = _$className;
}

''';
    classBuffer.write(beginning);

    classBuffer.writeln("required String test,");
    for (final field in element.fields) {
      classBuffer.writeln("required ${field.type} ${field.name},");
      // classBuffer.writeln();
    }

    classBuffer.writeln(end);

    return classBuffer.toString();
  }
}
