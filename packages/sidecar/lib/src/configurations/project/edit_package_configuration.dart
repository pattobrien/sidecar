import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import 'edit_configuration.dart';

import 'errors.dart';
import 'yaml_parsers/yaml_parsers.dart';

class EditPackageConfiguration {
  const EditPackageConfiguration({
    required this.packageName,
    required this.edits,
    this.includes,
    this.sourceErrors = const <YamlSourceError>[],
  });

  factory EditPackageConfiguration.fromYamlMap(
    YamlMap yamlMap, {
    required String packageName,
  }) {
    return EditPackageConfiguration(
      packageName: packageName,
      edits: yamlMap.nodes.map<String, EditConfiguration>((dynamic key, node) {
        final yamlKey = key as YamlScalar;
        if (node is YamlMap) {
          final editConfigurationErrors = <YamlSourceError>[];
          final configuration =
              node.parseConfiguration().fold((map) => map, (errors) {
            editConfigurationErrors.addAll(errors);
            return null;
          });

          final includes =
              node.parseGlobIncludes().fold((map) => map, (errors) {
            editConfigurationErrors.addAll(errors);
            return null;
          });

          final enabled = node.parseEnabled().fold((map) => map, (errors) {
            editConfigurationErrors.addAll(errors);
            return null;
          });

          return MapEntry(
            yamlKey.value as String,
            EditConfiguration(
              packageName: packageName,
              id: yamlKey.value as String,
              configuration: configuration,
              enabled: enabled,
              includes: includes,
              sourceErrors: editConfigurationErrors,
            ),
          );
        } else if (node is YamlScalar) {
          final dynamic scalarValue = node.value;
          if (scalarValue is bool) {
            return MapEntry(
              yamlKey.value as String,
              EditConfiguration(
                packageName: packageName,
                id: yamlKey.value as String,
                enabled: scalarValue,
              ),
            );
          }
          if (scalarValue == null) {
            return MapEntry(
              yamlKey.value as String,
              EditConfiguration(
                packageName: packageName,
                id: yamlKey.value as String,
              ),
            );
          }
        }
        return MapEntry(
          yamlKey.value as String,
          EditConfiguration(
            packageName: packageName,
            id: yamlKey.value as String,
            sourceErrors: [
              YamlSourceError(
                  sourceSpan: yamlKey.span,
                  message:
                      'CodeEdit definition should be of type null, bool, or map')
            ],
          ),
        );
      }),
    );
  }
  final String packageName;
  final Map<String, EditConfiguration> edits;
  final List<Glob>? includes;

  final List<YamlSourceError> sourceErrors;
}
