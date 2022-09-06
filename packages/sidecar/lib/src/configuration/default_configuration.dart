import 'package:sidecar/sidecar.dart';

final defaultPluginConfiguration = PluginConfiguration(
  rules: [],
  includes: [
    'lib/**',
    'bin/**'
    // Glob('lib/**'),
    // Glob('bin/**'),
    // Glob('test/**'),
  ],
  // excludes: [],
);
