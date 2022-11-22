String createAnalysisOptionsContents({
  bool isPluginEnabled = true,
}) =>
    '''
analyzer:
  plugins:
    ${isPluginEnabled ? '- sidecar' : ''}
''';
