// this is the initializer that should be programmatically filled
// with new lint classes based on the config file

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

List<LintError> pluginBootstrapper(
  NodeLintRegistry registry,
  ProviderContainer ref,
) {
  // initialize all lints
  return [
    // AvoidStringLiteralsLintError(ref)..registerNodeProcessors(registry),
    // AvoidStatelessWidgetLintError(ref)..registerNodeProcessors(registry),
    // AvoidDeclaredInsetsLintError(ref)..registerNodeProcessors(registry),
  ];
}
