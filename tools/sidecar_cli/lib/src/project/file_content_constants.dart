final pluginImport = '''
// THIS IS A GENERATED FILE
// DO NOT MANUALLY MODIFY THIS FILE

import 'package:sidecar/sidecar.dart';
''';

final lintBootstrapHeader = '''

List<LintRuleConstructor> lintRuleConstructors = [
''';
final editBootstrapHeader = '''

List<CodeEditConstructor> codeEditConstructors = [
''';

final bootstrapFooter = '''
];

''';

final sidecarYamlDefaultContents = '''
sidecar:
  includes:
    - "bin/**"
    - "lib/**"
  lints:
    riverpod_lints:
      prefer_consumer_widget:
        configuration:
          some_property: abc
    l10n_lints:
      avoid_string_literals:
        configuration:
          prefix: "AppLocalizations.of(context)"
  edits:

    ''';

final analyzerPluginDefaultContents = '''
analyzer:
  plugins:
    - sidecar_analyzer_plugin
''';
