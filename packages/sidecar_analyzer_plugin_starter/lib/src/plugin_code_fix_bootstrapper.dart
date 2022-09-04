// this is the initializer that is programmatically created using
// lint classes based on the project's config file

import 'package:sidecar/sidecar.dart';
import 'package:riverpod/riverpod.dart';

List<CodeEdit> pluginCodeFixBootstrapper(
  ProviderContainer ref,
) {
  // initialize all lints
  return [
    // DeclareTecProvider(ref),
  ];
}
