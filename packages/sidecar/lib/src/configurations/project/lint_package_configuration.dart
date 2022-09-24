import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import 'errors.dart';
import 'lint_configuration.dart';
import 'yaml_parsers/yaml_parsers.dart';

class LintPackageConfiguration {
  const LintPackageConfiguration({
    required this.packageName,
    required this.lints,
    this.includes,
  });

  factory LintPackageConfiguration.fromYamlMap(
    YamlMap yamlMap, {
    required String packageName,
  }) {
    return LintPackageConfiguration(
      packageName: packageName,
      lints: yamlMap.nodes.map<String, LintConfiguration>((dynamic key, value) {
        // final dynamic extractedValue = value.value;
        final yamlKey = key as YamlScalar;
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
            yamlKey.value as String,
            LintConfiguration(
              packageName: packageName,
              id: yamlKey.value as String,
              includes: includes,
              severity: severity,
              enabled: enabled,
              configuration: configuration,
              sourceErrors: lintConfigurationErrors,
            ),
          );
        } else if (value is YamlScalar) {
          final dynamic scalarValue = value.value;
          if (scalarValue is bool) {
            return MapEntry(
              yamlKey.value as String,
              LintConfiguration(
                packageName: packageName,
                id: yamlKey.value as String,
                enabled: scalarValue,
              ),
            );
          }
          if (scalarValue == null) {
            return MapEntry(
              yamlKey.value as String,
              LintConfiguration(
                packageName: packageName,
                id: yamlKey.value as String,
              ),
            );
          }
        }
        return MapEntry(
          yamlKey.value as String,
          LintConfiguration(
            packageName: packageName,
            id: yamlKey.value as String,
            sourceErrors: [
              YamlSourceError(
                  sourceSpan: yamlKey.span,
                  message:
                      'Lint definition should be of type null, bool, or map')
            ],
          ),
        );
      }),
    );
  }
  final String packageName;
  final Map<String, LintConfiguration> lints;
  final List<Glob>? includes;
}
