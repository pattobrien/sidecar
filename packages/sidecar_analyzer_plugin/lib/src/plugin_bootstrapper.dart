// this is the initializer that is programmatically created using
// lint classes based on the project's config file

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';

List<LintError> pluginBootstrapper(
  NodeLintRegistry registry,
  ProviderContainer ref,
) {
  // initialize all lints
  return [
    // AvoidStringLiterals(ref)..registerNodeProcessors(registry),
  ];
}
