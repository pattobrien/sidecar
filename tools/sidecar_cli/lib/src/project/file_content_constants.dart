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

final analysisDefaultContents = '''
analyzer:
  plugins:
    - sidecar_analyzer_plugin

sidecar_analyzer_plugin:
  includes:
    - "bin/**"
    - "lib/**"
  rules:
    - id: riverpod_prefer_consumer_widget
    # - id: l10n_avoid_string_literals
    ''';
