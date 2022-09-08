import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';

import 'lint_declaration.dart';

part 'plugin_configuration.g.dart';

@JsonSerializable(
  anyMap: true,
)
class PluginConfiguration {
  const PluginConfiguration({
    this.lints,
    // this.edits,
  });
  @JsonKey(fromJson: lintConfigFromJson)
  final Map<LintName, LintDeclaration>? lints;

  // @JsonKey(fromJson: editConfigFromJson)
  // final Map<EditName, EditConfiguration>? edits;

  factory PluginConfiguration.fromJson(Map<dynamic, dynamic> json) =>
      _$PluginConfigurationFromJson(json);

  factory PluginConfiguration.fromYaml(String contents) {
    return checkedYamlDecode(
      contents,
      (m) => PluginConfiguration.fromJson(m!['sidecar']),
    );
  }
}

typedef LintName = dynamic;
typedef EditName = dynamic;

Map<LintName, LintDeclaration>? lintConfigFromJson(Map? json) {
  final map = json?.map<String, dynamic>((dynamic key, dynamic value) {
    if (key is String) {
      return MapEntry<String, dynamic>(key, value);
    } else {
      throw UnimplementedError('lintConfigFromJson: expected String');
    }
  });
  return map?.map<LintName, LintDeclaration>((key, dynamic value) {
    if (value == null) {
      return MapEntry<LintName, LintDeclaration>(
        key,
        LintDeclaration(
          id: key,
          import: null,
          className: null,
          package: null,
        ),
      );
    }
    if (value is Map<dynamic, dynamic>) {
      return MapEntry<LintName, LintDeclaration>(
        key,
        LintDeclaration(
          id: key,
          import: value.containsKey('import')
              ? Uri(scheme: 'package', path: value['import'])
              : null,
          className: value.containsKey('class') ? value['class'] : null,
          package: null,
        ),
      );
    }
    throw UnimplementedError(
        'lint declaration is not correct: type is ${value.toString()}');
  });
}
