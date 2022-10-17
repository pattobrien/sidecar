import 'package:dartz/dartz.dart';
import 'package:yaml/yaml.dart';

import '../builders/builders.dart';

extension YamlMapConfigurationParse on YamlMap {
  Either<YamlMap?, List<SidecarConfigException>> parseConfiguration() {
    try {
      return left(value.containsKey('configuration')
          ? value['configuration'] as YamlMap
          : null);
    } catch (e) {
      //TODO: how can we handle mis-matched configurations here?
      return right([
        SidecarLintException(nodes.keys
            .cast<YamlScalar>()
            .firstWhere((element) => element.value == 'configuration'))
      ]);
    }
  }
}
