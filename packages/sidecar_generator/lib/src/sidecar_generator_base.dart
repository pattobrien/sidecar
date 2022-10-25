// import 'package:analyzer_plugin/protocol/protocol_common.dart';
// import 'package:dartz/dartz.dart';
// import 'package:sidecar/sidecar.dart';
// import 'package:source_span/source_span.dart';
// import 'package:yaml/yaml.dart';

// class TestConfig {
//   const TestConfig({
//     required this.field,
//     required this.field2,
//   });

//   final String field;
//   final bool field2;

//   static String get packageName => '';

//   factory TestConfig.fromYamlMap(YamlMap yamlMap) {
//     final exceptions = <SidecarConfigException>[];
//     final fieldResult = computeField<String>(yamlMap, packageName, 'field')
//       ..fold((l) => exceptions.add(l), (r) => null);
//     final field2Result = computeField<bool>(yamlMap, packageName, 'field2')
//       ..fold((l) => exceptions.add(l), (r) => null);
//     try {
//       return TestConfig(
//         field: fieldResult.fold(
//             (l) => throw SidecarException(), (r) => r as String),
//         field2: field2Result.fold(
//             (l) => throw SidecarException(), (r) => r as bool),
//       );
//     } on SidecarAggregateException {
//       throw SidecarAggregateException(exceptions);
//     }
//   }
// }
