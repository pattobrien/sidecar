// this is the initializer that should be programmatically filled
// with new lint classes based on the config file

import 'package:sidecar/sidecar.dart';

List<LintError> pluginBootstrapper(NodeLintRegistry registry) {
  // initialize all lints
  return [
    // AvoidStringLiteralsLintError()..registerNodeProcessors(registry),
    // AvoidStatelessWidgetLintError()..registerNodeProcessors(registry),
    // AvoidDeclaredInsetsLintError()..registerNodeProcessors(registry),
  ];
}
