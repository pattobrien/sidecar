String createSidecarYamlContents() => '''
includes:
  - "bin/**"
  - "lib/**"
lints:
  l10n_lints:
    avoid_string_literals:
''';

const sidecarYamlPath = 'sidecar.yaml';
