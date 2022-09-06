import 'package:pubspec/pubspec.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

extension PubspecUtilitiesX on String {
  // String removeDependency(String name) {
  //   //
  // }
  String insertDependency(MapEntry<String, Dependency> dependency) {
    return _insertDependency(dependency, 'dependencies');
  }

  String insertDependencyOverride(MapEntry<String, Dependency> dependency) {
    return _insertDependency(dependency, 'dependency_overrides');
  }

  String insertDevDependency(MapEntry<String, Dependency> dependency) {
    return _insertDependency(dependency, 'dev_dependencies');
  }

  // String _removeDependency(String name, String dependencyType) {

  // }

  // String _removeDependencyOverride(
  //   String name,
  //   // String dependencyType,
  // ) {
  //   // sudo code
  //   // find expected dependency type start
  //   //
  //   // final splitContent = split('\n$dependencyType:');

  //   final pubspec = Pubspec.parse(this);
  //   final yaml = loadYaml(this);
  //   final pubSpec = PubSpec.fromYamlString(yaml);
  //   pubSpec.copy();
  //   final splitter = LineSplitter();
  //   splitter.convert(this);

  //   final dep = pubspec.dependencyOverrides[name];
  //   if (dep != null) {
  //     if (dep is HostedDependency) {
  //       final x = dep.version;
  //     }
  //   } else {
  //     throw UnimplementedError('Could not remove dependency $name');
  //   }
  //   //
  // }

  String _insertDependency(
    MapEntry<String, Dependency> dependency,
    String dependencyType,
  ) {
    //
    final depValue = dependency.value;
    String depContent = '';
    if (depValue is PathDependency) {
      depContent = '''
  ${dependency.key}:
    path: ${depValue.path}''';
    } else if (depValue is HostedDependency) {
      final versionInfoComment =
          '# version constraint can be explicitly specified';
      depContent = '''
  ${dependency.key}:
    hosted: ${depValue.hosted?.url}
    version: ${depValue.version} ${depValue.version.isAny ? versionInfoComment : ''}''';
    }
    // final regexp = RegExp('^($dependencyType:)');
    final splitContent = split('\n$dependencyType:');

    String newSource = '';
    newSource = splitContent[0];
    newSource += '\n$dependencyType:\n';
    newSource += depContent;

    // if split() didnt find the dependencyType, then there's nothing else
    // to add to the end of the string
    splitContent.length != 1 ? newSource += splitContent[1] : null;

    return newSource;
  }
}
