import 'package:dartz/dartz.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../../../sidecar.dart';

extension YamlMapEnabled on YamlMap {
  Either<bool?, List<YamlSourceError>> parseEnabled() {
    try {
      return left(containsKey('enabled') ? value['enabled'] as bool : null);
    } catch (e) {
      final errorSpan = nodes.keys
          .cast<YamlScalar>()
          .firstWhere((element) => element.value == 'enabled')
          .span;

      return right([
        YamlSourceError(
          sourceSpan: errorSpan,
          message: 'value should be true or false',
        )
      ]);
    }
  }
}
