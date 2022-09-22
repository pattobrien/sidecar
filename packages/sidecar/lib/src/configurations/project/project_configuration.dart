import 'package:checked_yaml/checked_yaml.dart';
import 'package:glob/glob.dart';
import '../configurations.dart';
import 'edit_package_configuration.dart';
import 'errors.dart';
import 'lint_package_configuration.dart';

class ProjectConfiguration {
  const ProjectConfiguration({
    this.lintPackages,
    this.editPackages,
    List<String>? includes = const ['lib/**', 'bin/**'],
  }) : _includes = includes ?? const ['lib/**', 'bin/**'];

  factory ProjectConfiguration.parse(String contents) {
    return checkedYamlDecode(
      contents,
      (m) {
        Map contentMap;
        try {
          contentMap = m!['sidecar'] as Map;
        } catch (e) {
          throw const MissingSidecarConfiguration();
        }
        return ProjectConfiguration(
          lintPackages: parseLintPackages(contentMap['lints'] as Map?),
          editPackages: parseEditPackages(contentMap['edits'] as Map?),
          includes: parseIncludes(contentMap['includes'] as List?),
        );
      },
    );
  }

  final Map<PackageName, LintPackageConfiguration>? lintPackages;
  final Map<PackageName, EditPackageConfiguration>? editPackages;
  final List<String> _includes;

  List<Glob> get includeGlobs => _includes.map<Glob>(Glob.new).toList();

  bool includes(String relativePath) {
    // final rootDirectory = analysisContext.contextRoot.root;
    // final relativePath = p.relative(path, from: rootDirectory.path);
    return includeGlobs.any((glob) => glob.matches(relativePath));
  }

  LintConfiguration? lintConfiguration(String packageId, String lintId) =>
      lintPackages?[packageId]?.lints[lintId];

  EditConfiguration? editConfiguration(String packageId, String editId) =>
      editPackages?[packageId]?.edits[editId];
}

typedef PackageName = String;

Map<PackageName, LintPackageConfiguration>? parseLintPackages(
  Map? map,
) {
  try {
    return map?.map((dynamic key, dynamic value) {
      if (value is Map) {
        final config = LintPackageConfiguration.fromJson(value,
            packageName: key as String);
        return MapEntry(key, config);
      } else {
        // we want to throw an error if the package doesnt have a single lint declared
        throw UnimplementedError(
            'expected one or more lints for package $key in analysis_options.yaml');
      }
    });
  } catch (e) {
    throw InvalidSidecarConfiguration();
  }
}

Map<PackageName, EditPackageConfiguration>? parseEditPackages(
  Map? map,
) {
  try {
    return map?.map((dynamic key, dynamic value) {
      if (value is Map) {
        final config = EditPackageConfiguration.fromJson(value,
            packageName: key as String);
        return MapEntry(key, config);
      } else {
        // we want to throw an error if the package doesnt have a single lint declared
        throw UnimplementedError(
            'expected one or more edits for package $key in analysis_options.yaml');
      }
    });
  } catch (e) {
    throw InvalidSidecarConfiguration();
  }
}

List<String>? parseIncludes(List? globs) {
  return globs?.map((dynamic value) {
    if (value is String) {
      return value;
    } else {
      throw UnimplementedError('expected one or more includes globs');
    }
  }).toList();
}
