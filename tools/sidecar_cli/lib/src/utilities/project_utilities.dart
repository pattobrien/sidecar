import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:checked_yaml/checked_yaml.dart';
import 'package:recase/recase.dart';
import 'package:sidecar/sidecar.dart';

const analysisOptionsFileName = 'analysis_options.yaml';

class ProjectUtilities {
  static Future<ProjectConfiguration> getSidecarConfiguration(
    Uri projectRootUri,
  ) async {
    final pubspecFile = io.File(p.join(projectRootUri.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      final contents = await pubspecFile.readAsString();
      try {
        return checkedYamlDecode(
          contents,
          (m) => ProjectConfiguration.fromJson(m!['sidecar']),
          sourceUrl: projectRootUri,
        );
      } catch (e) {
        print('no project configuration found for sidecar.');
        rethrow;
      }
    } else {
      throw UnimplementedError(
        'no pubspec file found; please make sure this is a dart directory.',
      );
    }
  }
}

extension LintConfigurationX on LintConfiguration {
  String get filePath => '$id.dart';
  String get className => ReCase(id).pascalCase;
}

extension EditConfigurationX on EditConfiguration {
  String get filePath => '$id.dart';
  String get className => ReCase(id).pascalCase;
}
