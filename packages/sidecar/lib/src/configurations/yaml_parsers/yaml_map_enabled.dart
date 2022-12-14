import 'package:yaml/yaml.dart';

import '../exceptions/exceptions.dart';
import '../sidecar_spec/errors.dart';

extension YamlMapEnabled on YamlMap {
  SidecarExceptionTuple<bool?> parseEnabled() {
    const key = 'enabled';
    try {
      final enabledValue = containsKey(key) ? value[key] as bool : null;
      return SidecarExceptionTuple<bool?>(enabledValue, []);
    } catch (e) {
      return SidecarExceptionTuple<bool?>(null, [
        SidecarNewException.lintField(
          sourceSpan: nodes.keys
              .cast<YamlScalar>()
              .firstWhere((element) => element.value == key)
              .span,
          correction: '',
          message: "Invalid value. Must be 'true' or 'false'",
        )
      ]);
    }
  }
}
