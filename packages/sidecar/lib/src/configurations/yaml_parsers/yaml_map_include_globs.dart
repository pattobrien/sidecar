import 'package:dartz/dartz.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../../sidecar.dart';
import 'yaml_source_error.dart';

extension YamlMapIncludeGlobs on YamlMap {
  Either<List<Glob>?, List<SidecarConfigException>> parseGlobIncludes() {
    YamlList? yamlList;
    const key = 'includes';
    try {
      yamlList = containsKey(key) ? (value[key] as YamlList) : null;
    } catch (e) {
      return right([
        SidecarLintException(nodes.keys
            .cast<YamlScalar>()
            .firstWhere((element) => element.value == key)),
      ]);
    }
    if (yamlList != null) {
      final nodes = yamlList.nodes;
      final includes = <Glob>[];
      final lintConfigurationErrors = <SidecarConfigException>[];
      for (final node in nodes) {
        try {
          includes.add(Glob(node.value as String));
        } catch (e) {
          // some value is not valid
          lintConfigurationErrors
              .add(SidecarFieldException(node.value as YamlScalar));
        }
      }
      if (lintConfigurationErrors.isNotEmpty) {
        return right(lintConfigurationErrors);
      } else {
        return left(includes);
      }
    } else {
      return left(null);
    }
  }
}
