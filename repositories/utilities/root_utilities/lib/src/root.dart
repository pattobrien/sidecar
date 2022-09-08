import 'dart:io';
import 'package:path/path.dart' as p;

import 'utils.dart';

abstract class Root {
  Root(this._root);

  final Directory _root;

  Directory get root => _root;
  LibDirectory get lib => LibDirectory(p.join(_root.path, 'lib'));
  TestDirectory get test => TestDirectory(p.join(_root.path, 'test'));

  File get analysisOptions => File(p.join(_root.path, 'analysis_options.yaml'));
  File get pubspecYaml => File(p.join(_root.path, 'pubspec.yaml'));
  File get pubspecLock => File(p.join(_root.path, 'pubspec.lock'));
  File get gitIgnore => File(p.join(_root.path, '.gitignore'));
  File get readme => File(p.join(_root.path, '.README.md'));
}

class TestDirectory extends ExtendedDirectory {
  TestDirectory(super.path);
}

class LibDirectory extends ExtendedDirectory {
  LibDirectory(super.path);

  FeatureDirectory get features => FeatureDirectory(p.join(path, 'features'));

  File get mainFile => File(p.join(path, 'main.dart'));
}

class FeatureDirectory extends ExtendedDirectory {
  FeatureDirectory(super.path);
}
