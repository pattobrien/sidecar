import 'package:pubspec_parse/pubspec_parse.dart';

extension PubspecUtilitiesX on Pubspec {
  String insertDevDependency(
      String originalSource, MapEntry<String, PathDependency> dependency) {
    //
    final depContent = '''
  ${dependency.key}:
    path: ${dependency.value.path} # code-generated''';
    final split = originalSource.split('dev_dependencies:');

    String newSource = '';
    if (split.length == 1) {
      // no dev depencies found
      newSource = originalSource;
      newSource += depContent;
    } else {
      // dev dependencies found
      newSource += split[0];
      newSource += 'dev_dependencies:\n';
      newSource += depContent;
      newSource += split[1];
    }
    return newSource;
  }
}
