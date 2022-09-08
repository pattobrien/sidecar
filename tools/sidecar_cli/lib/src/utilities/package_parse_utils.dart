import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:checked_yaml/checked_yaml.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';
import 'package:sidecar/sidecar.dart';

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
