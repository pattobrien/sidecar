// this is the initializer that is programmatically created using
// lint classes based on the project's config file

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_analyzer_plugin/code_edits/declare_tec_provider.dart';

List<CodeEdit> pluginCodeFixBootstrapper(
  ProviderContainer ref,
) {
  // initialize all lints
  return [
    DeclareTecProvider(ref),
    // AvoidStringLiterals(ref)..registerNodeProcessors(registry),
  ];
}
