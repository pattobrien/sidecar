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
