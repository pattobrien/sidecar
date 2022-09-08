import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:checked_yaml/checked_yaml.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';
import 'package:sidecar/sidecar.dart';
import 'package:sidecar_cli/src/configurations/package/lint_declaration.dart';
import 'package:sidecar_cli/src/configurations/package/package_configuration.dart';

const analysisOptionsFileName = 'analysis_options.yaml';

class PackageParseUtils {
  static Future<PackageConfiguration> getPackageConfiguration(
    Uri projectRootUri,
  ) async {
    final pubspecFile = io.File(p.join(projectRootUri.path, 'pubspec.yaml'));
    if (pubspecFile.existsSync()) {
      final contents = await pubspecFile.readAsString();
      final pubspec = Pubspec.parse(contents, lenient: true);
      try {
        return PackageConfiguration.parse(
          contents,
          packageName: pubspec.name,
        );
      } catch (e) {
        print('no plugin configuration found for sidecar.');
        rethrow;
      }
    } else {
      throw UnimplementedError(
          'no pubspec file found; please make sure this is a dart directory.');
    }
  }
}

extension LintDeclarationX on LintDeclaration {
  // Uri get import =>
  //     this.import ?? Uri(scheme: 'package', path: '$package/$package.dart');
  // String get className => this.className ?? ReCase(id).pascalCase;

  // Uri get cacheUri =>
  //     Uri(scheme: 'file', path: p.join(userCachePath, filePath));
}

// extension EditConfigurationX on EditConfiguration {
//   String get filePath => '$id.dart';
//   String get className => ReCase(id).pascalCase;
// }
