import 'package:dartz/dartz.dart';
import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../../../../sidecar.dart';

extension YamlMapIncludeGlobs on YamlMap {
  Either<List<Glob>?, List<YamlSourceError>> parseGlobIncludes() {
    YamlList? yamlList;
    try {
      yamlList =
          containsKey('includes') ? (value['includes'] as YamlList) : null;
    } catch (e) {
      final errorSpan = nodes.keys
          .cast<YamlScalar>()
          .firstWhere((element) => element.value == 'includes')
          .span;

      return right([
        YamlSourceError(
          sourceSpan: errorSpan,
          message: 'value should be a list of strings',
        )
      ]);
    }
    if (yamlList != null) {
      final nodes = yamlList.nodes;
      final includes = <Glob>[];
      final lintConfigurationErrors = <YamlSourceError>[];
      for (final node in nodes) {
        try {
          includes.add(Glob(node.value as String));
        } catch (e) {
          // some value is not valid
          final errorSpan = node.span;
          lintConfigurationErrors.add(YamlSourceError(
            sourceSpan: errorSpan,
            message: 'Not a valid glob pattern',
          ));
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
