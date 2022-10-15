import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;

void main() {
  final sidecarImport = 'import \'package:sidecar/sidecar.dart\';\n';

  // inputs
  final className = 'TestConfig';
  final fieldMap = <String, String>{'field': 'String', 'field2': 'bool'};
  final packageName = 'design_system_lints';

  String foldedResult(String resultName, String type) =>
      '$resultName.fold((l) => throw SidecarException(), (r) => r as $type)';
  String computedResult(String field, String type) =>
      'final \$${field}Result = computeField<$type>(yamlMap, packageName, \'$field\')..fold((l) => exceptions.add(l), (r) => null)';

  // computation
  final configurationClass = Class(
    (b) => b
      ..name = '\$$className'
      ..constructors.add(Constructor(
        (builder) {
          builder.constant = true;
          builder.requiredParameters.addAll(fieldMap.entries.map((entry) {
            return Parameter((builder) {
              builder.name = entry.key;
              builder.toThis = true;
              builder.named = true;
            });
          }));
        },
      ))
      ..fields.addAll(
        fieldMap.entries.map((entry) => Field(
              (builder) {
                builder.name = entry.key;
                builder.type = Reference(entry.value);
                builder.modifier = FieldModifier.final$;
              },
            )),
      )
      ..methods.add(
        Method((p0) {
          p0.static = true;
          p0.name = 'packageName';
          p0.type = MethodType.getter;
          p0.returns = Reference('String');
          p0.body = Code('return \'$packageName\';');
        }),
      )
      ..constructors.add(
        Constructor((p0) {
          p0.factory = true;
          p0.name = 'fromYamlMap';
          p0.requiredParameters.add(Parameter(
            (p1) {
              p1.name = 'yamlMap';
              p1.type = Reference('YamlMap', 'package:yaml/yaml.dart');
            },
          ));

          p0.body = Block((b) {
            b.addExpression(
              CodeExpression(
                  Code('final exceptions = <SidecarConfigException>[]')),
            );
            String foldString = '';
            for (final fieldMapEntry in fieldMap.entries) {
              final resultVariableName = '\$${fieldMapEntry.key}Result';
              final fieldType = fieldMapEntry.value;
              final fieldVariableName = fieldMapEntry.key;
              b.addExpression(CodeExpression(
                  Code(computedResult(fieldVariableName, fieldType))));
              foldString += '${foldedResult(resultVariableName, fieldType)}, ';
            }
            b.addExpression(
              CodeExpression(Code(
                  'try { return \$TestConfig($foldString); } on SidecarAggregateException { throw SidecarAggregateException(exceptions); }')),
            );
          });
        }),
      ),
  );

  final emitter = DartEmitter();
  final contents = DartFormatter(lineEnding: '\n', fixes: StyleFix.all)
      .format('$sidecarImport${configurationClass.accept(emitter)}');
  final path = p.join(Directory.current.path, 'bin', 'result.dart');
  File(path).writeAsStringSync(contents);
}
