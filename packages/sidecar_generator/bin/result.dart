import 'package:sidecar/sidecar.dart';

class $TestConfig {
  const $TestConfig(
    this.field,
    this.field2,
  );

  factory $TestConfig.fromYamlMap(YamlMap yamlMap) {
    final exceptions = <SidecarConfigException>[];
    final $fieldResult = computeField<String>(yamlMap, packageName, 'field')
      ..fold((l) => exceptions.add(l), (r) => null);
    final $field2Result = computeField<bool>(yamlMap, packageName, 'field2')
      ..fold((l) => exceptions.add(l), (r) => null);
    try {
      return $TestConfig(
        $fieldResult.fold((l) => throw SidecarException(), (r) => r as String),
        $field2Result.fold((l) => throw SidecarException(), (r) => r as bool),
      );
    } on SidecarAggregateException {
      throw SidecarAggregateException(exceptions);
    }
    ;
  }

  final String field;

  final bool field2;

  static String get packageName {
    return 'design_system_lints';
  }
}
