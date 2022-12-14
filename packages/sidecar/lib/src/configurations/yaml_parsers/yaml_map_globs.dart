import 'package:glob/glob.dart';
import 'package:yaml/yaml.dart';

import '../exceptions/exceptions.dart';
import '../sidecar_spec/errors.dart';

extension YamlMapIncludeGlobs on YamlMap {
  SidecarExceptionTuple<List<Glob>?> parseGlobIncludes() =>
      _parseGlobs('includes');

  SidecarExceptionTuple<List<Glob>?> parseGlobExcludes() =>
      _parseGlobs('excludes');

  SidecarExceptionTuple<List<Glob>?> _parseGlobs(String key) {
    YamlList? yamlList;
    try {
      yamlList = containsKey(key) ? (value[key] as YamlList) : null;
    } catch (e) {
      return SidecarExceptionTuple<List<Glob>?>(null, [
        SidecarNewException(
          sourceSpan: nodes.keys
              .cast<YamlScalar>()
              .firstWhere((element) => element.value == key)
              .span,
          code: invalidFieldCode,
          message: 'Includes requires a list',
        )
      ]);
    }
    if (yamlList != null) {
      final nodes = yamlList.nodes;
      final includes = <Glob>[];
      final lintConfigurationErrors = <SidecarNewException>[];
      for (final node in nodes) {
        try {
          includes.add(Glob(node.value as String));
        } catch (e) {
          // some value is not valid
          lintConfigurationErrors.add(
            SidecarNewException.lintField(
              sourceSpan: (node as YamlScalar).span,
              message: 'Invalid glob.',
              correction: '',
            ),
          );
        }
      }
      return SidecarExceptionTuple<List<Glob>>(
          includes, lintConfigurationErrors);
    } else {
      return const SidecarExceptionTuple<List<Glob>?>(null, []);
    }
  }
}
