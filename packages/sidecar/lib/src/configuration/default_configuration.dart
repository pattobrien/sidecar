import 'package:sidecar/sidecar.dart';

const defaultPluginConfiguration = ProjectConfiguration(
  includes: [
    'lib/**',
    'bin/**'
    // Glob('lib/**'),
    // Glob('bin/**'),
    // Glob('test/**'),
  ],
  // excludes: [],
);
