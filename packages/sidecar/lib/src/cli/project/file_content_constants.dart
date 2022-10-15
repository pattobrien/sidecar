const pluginImport = '''
// THIS IS A GENERATED FILE
// DO NOT MANUALLY MODIFY THIS FILE

import 'package:sidecar/sidecar.dart';
''';

const lintBootstrapHeader = '''

Map<Id, LintRuleConstructor> lintRuleConstructors = {
''';

const editBootstrapHeader = '''

Map<Id, CodeEditConstructor> codeEditConstructors = {
''';

const bootstrapFooter = '''
};

''';

const sidecarYamlDefaultContents = '''
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
          prefix: AppLocalizations.of(context)
  edits:

    ''';

const analyzerPluginDefaultContents = '''
analyzer:
  plugins:
    - sidecar
''';
