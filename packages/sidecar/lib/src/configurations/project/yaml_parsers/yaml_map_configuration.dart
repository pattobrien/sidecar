import 'package:dartz/dartz.dart';
import 'package:yaml/yaml.dart';

import '../errors.dart';

extension YamlMapConfigurationParse on YamlMap {
  Either<YamlMap?, List<YamlSourceError>> parseConfiguration() {
    try {
      return left(value.containsKey('configuration')
          ? value['configuration'] as YamlMap
          : null);
    } catch (e) {
      //TODO: how can we handle mis-matched configurations here?
      final errorSpan = nodes.keys
          .cast<YamlScalar>()
          .firstWhere((element) => element.value == 'configuration')
          .span;

      return right([
        YamlSourceError(
          sourceSpan: errorSpan,
          message: 'Configuration is invalid',
        )
      ]);
    }
  }
}
