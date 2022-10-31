String createAnalysisOptionsContents({
  bool isSidecarPluginEnabled = true,
}) =>
    '''
analyzer:
  plugins:
    ${isSidecarPluginEnabled ? '- sidecar' : ''}
''';
