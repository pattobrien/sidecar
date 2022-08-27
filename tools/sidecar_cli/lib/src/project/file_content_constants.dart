final pluginImport = '''
// THIS IS A GENERATED FILE
// DO NOT MANUALLY MODIFY THIS FILE

import 'package:sidecar/sidecar.dart';
import 'package:riverpod/riverpod.dart';
''';

final bootstrapHeader = '''

List<LintError> pluginBootstrapper(
  NodeLintRegistry registry,
  ProviderContainer ref,
) {
  return [
''';

final bootstrapFooter = '''
  ];
}
''';
