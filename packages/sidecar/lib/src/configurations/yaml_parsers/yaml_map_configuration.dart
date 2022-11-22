import 'package:yaml/yaml.dart';

import '../configurations.dart';
import '../exceptions/exceptions.dart';

extension YamlMapConfigurationParse on YamlMap {
  SidecarExceptionTuple<YamlMap?> parseConfiguration() {
    const key = 'configuration';
    try {
      final configuration =
          value.containsKey(key) ? value[key] as YamlMap : null;
      return SidecarExceptionTuple<YamlMap?>(configuration, []);
    } catch (e) {
      //TODO: how can we handle mis-matched configurations here?
      return SidecarExceptionTuple<YamlMap?>(null, [
        SidecarNewException.lintField(
          sourceSpan: nodes.keys
              .cast<YamlScalar>()
              .firstWhere((element) => element.value == key)
              .span,
          message: 'Invalid configuration',
          correction: '',
        ),
      ]);
    }
  }
}
