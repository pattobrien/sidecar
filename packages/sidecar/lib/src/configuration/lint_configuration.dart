import 'package:freezed_annotation/freezed_annotation.dart';

part 'lint_configuration.freezed.dart';
part 'lint_configuration.g.dart';

@freezed
class LintConfiguration with _$LintConfiguration {
  const factory LintConfiguration({
    required String id,
    required bool enabled,
    required Map<dynamic, dynamic>? configuration,
  }) = _LintConfiguration;
  const LintConfiguration._();

  factory LintConfiguration.fromJson(Map json) =>
      _$LintConfigurationFromJson(json as Map<String, dynamic>);

  // factory LintConfiguration.fromYaml(Map yaml) {
  //   LintConfiguration(configuration: );
  // }
}


// Map<PackageName, LintConfiguration>? lintConfigFromJson(Map? json) {
//   final map = json?.map<String, dynamic>((dynamic key, dynamic value) {
//     if (key is String) {
//       return MapEntry<String, dynamic>(key, value);
//     } else {
//       throw UnimplementedError('lintConfigFromJson: expected String');
//     }
//   });
//   return map?.map<PackageName, LintConfiguration>((key, dynamic value) {
//     if (value == null) {
//       return MapEntry<PackageName, LintConfiguration>(
//         key,
//         LintConfiguration(
//           id: key,
//           configuration: null,
//           enabled: true,
//         ),
//       );
//     }
//     if (value is bool) {
//       return MapEntry<PackageName, LintConfiguration>(
//         key,
//         LintConfiguration(
//           id: key,
//           configuration: null,
//           enabled: value,
//         ),
//       );
//     }
//     if (value is Map<dynamic, dynamic>) {
//       final dynamic enabledValue = value['enabled'];
//       if (enabledValue is bool) {
//         return MapEntry<PackageName, LintConfiguration>(
//           key,
//           LintConfiguration(
//             id: key,
//             configuration: value,
//             enabled: enabledValue,
//           ),
//         );
//       } else {
//         return MapEntry<PackageName, LintConfiguration>(
//           key,
//           LintConfiguration(
//             id: key,
//             configuration: value,
//             enabled: true,
//             parentPackage: 
//           ),
//         );
//       }
//     }
//     throw UnimplementedError(
//         'lint configuration is not correct: type is ${value.runtimeType}');
//   });
// }