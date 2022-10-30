import '../../configurations/configurations.dart';

String createSidecarYamlContents(ProjectConfiguration configuration) {
  return '''
includes:
  - "bin/**"
  - "lib/**"
lints:
  l10n_lints:
    avoid_string_literals:
''';
}

const sidecarYamlPath = 'sidecar.yaml';
