import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../../sidecar.dart';
import 'lint_configuration.dart';

import 'yaml_parsers/yaml_parsers.dart';

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
        if (value is YamlMap) {
          final lintConfigurationErrors = <YamlSourceError>[];

          final configuration = value.parseConfiguration().fold((l) => l, (r) {
            lintConfigurationErrors.addAll(r);
            return null;
          });

          final severity = value.parseSeverity().fold((l) => l, (r) {
            lintConfigurationErrors.addAll(r);
            return null;
          });

          final includes = value.parseGlobIncludes().fold((l) => l, (r) {
            lintConfigurationErrors.addAll(r);
            return null;
          });

          final enabled = value.parseEnabled().fold((l) => l, (r) {
            lintConfigurationErrors.addAll(r);
            return null;
          });

          return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              id: key,
              includes: includes,
              severity: severity,
              enabled: enabled,
              configuration: configuration ?? <dynamic, dynamic>{},
              sourceErrors: lintConfigurationErrors,
            ),
          );
        } else if (value is bool) {
          return MapEntry(
            key as String,
            LintConfiguration(
              packageName: packageName,
              id: key,
              configuration: <dynamic, dynamic>{},
              enabled: value,
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
