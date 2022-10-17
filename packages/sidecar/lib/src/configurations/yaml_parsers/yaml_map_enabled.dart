import 'package:dartz/dartz.dart';
import 'package:yaml/yaml.dart';

import '../builders/builders.dart';

extension YamlMapEnabled on YamlMap {
  Either<bool?, List<SidecarLintException>> parseEnabled() {
    const key = 'enabled';
    try {
      return left(containsKey(key) ? value[key] as bool : null);
    } catch (e) {
      return right([
        SidecarLintException(nodes.keys
            .cast<YamlScalar>()
            .firstWhere((element) => element.value == key))
      ]);
    }
  }
}
