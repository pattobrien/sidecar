final pluginImport = '''
// THIS IS A GENERATED FILE
// DO NOT MANUALLY MODIFY THIS FILE

import 'package:sidecar/sidecar.dart';
import 'package:riverpod/riverpod.dart';
''';

final lintBootstrapHeader = '''

List<LintRule> pluginBootstrapper(
  NodeLintRegistry registry,
  ProviderContainer ref,
) {
  return [
''';
final editBootstrapHeader = '''

List<CodeEdit> pluginCodeFixBootstrapper(
  ProviderContainer ref,
) {
  return [
''';

final bootstrapFooter = '''
  ];
}
''';
