import 'package:checked_yaml/checked_yaml.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaml/yaml.dart';

part 'lint_configuration.freezed.dart';
part 'lint_configuration.g.dart';

@freezed
class LintConfiguration with _$LintConfiguration {
  const LintConfiguration._();
  const factory LintConfiguration({
    required String id,
    required bool enabled,
    required Map<dynamic, dynamic>? configuration,
  }) = _LintConfiguration;

  factory LintConfiguration.fromJson(Map json) =>
      _$LintConfigurationFromJson(json as Map<String, dynamic>);

  // factory LintConfiguration.fromYaml(Map yamlMap) {
  //   if (yamlMap.keys.every((element) => element is String)) {
  //     return LintConfiguration(id: yamlMap['id'], enabled: yamlMap.containsKey('enabled') ? yamlMap['enabled'] : false, configuration: configuration)
  //   }
  // }
}
