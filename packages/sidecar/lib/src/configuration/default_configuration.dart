import 'package:sidecar/sidecar.dart';

final defaultPluginConfiguration = ProjectConfiguration(
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
