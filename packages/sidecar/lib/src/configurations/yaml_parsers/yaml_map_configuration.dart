import 'package:yaml/yaml.dart';

import '../builders/builders.dart';
import '../configurations.dart';

extension YamlMapConfigurationParse on YamlMap {
  SidecarExceptionTuple<YamlMap?> parseConfiguration() {
    try {
      final configurationValue = value.containsKey('configuration')
          ? value['configuration'] as YamlMap
          : null;
      return SidecarExceptionTuple<YamlMap?>(configurationValue, []);
    } catch (e) {
      //TODO: how can we handle mis-matched configurations here?
      return SidecarExceptionTuple<YamlMap?>(null, [
        SidecarLintException(
          nodes.keys
              .cast<YamlScalar>()
              .firstWhere((element) => element.value == 'configuration'),
          message: 'Invalid configuration',
        )
      ]);
    }
  }
}
