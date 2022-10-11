const kSidecarPluginName = 'sidecar_analyzer_plugin_core';

// this cannot be any random number for some reason
// ("Plugin is not compatible." error is thrown)
const pluginVersion = '1.0.0-alpha.0';

const pluginGlobs = <String>['**/*.dart', '**/*.arb', '**/*.yaml'];
