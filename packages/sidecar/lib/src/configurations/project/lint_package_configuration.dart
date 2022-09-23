import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../models/lint_rule.dart';
import 'lint_configuration.dart';

class LintPackageConfiguration {
  const LintPackageConfiguration({
    required this.packageName,
    required this.lints,
    this.includes,
  });

  factory LintPackageConfiguration.fromJson(
    Map json, {
    required String packageName,
  }) {
    return LintPackageConfiguration(
      packageName: packageName,
      lints: json.map<String, LintConfiguration>((dynamic key, dynamic value) {
        if (value is Map) {
          final configuration = value.containsKey('configuration')
              ? value['configuration'] as Map
              : <dynamic, dynamic>{};

          final severity = value.containsKey('severity')
              ? LintRuleTypeX.fromString(value['severity'] as String)
              : null;

          final includes = value.containsKey('includes')
              ? ((value['includes'] as YamlList).nodes)
                  .map<Glob>((e) => Glob(e.value as String))
                  .toList()
              : null;

          final enabled =
              value.containsKey('enabled') ? value['enabled'] as bool : null;

          return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              id: key,
              includes: includes,
              severity: severity,
              enabled: enabled,
              configuration: configuration,
            ),
          );
        } else if (value == null) {
          return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              id: key,
              configuration: <dynamic, dynamic>{},
            ),
          );
        } else {
          throw UnimplementedError(
            'could not parse package lints; expected Map was of type ${value.runtimeType}',
          );
        }
      }),
    );
  }
  final String packageName;
  final Map<String, LintConfiguration> lints;
  final List<Glob>? includes;
}
