import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:checked_yaml/checked_yaml.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:recase/recase.dart';

import 'package:sidecar/sidecar.dart';

const analysisOptionsFileName = 'analysis_options.yaml';

class ProjectUtilities {
  static Future<ProjectConfiguration> getSidecarConfiguration(
    Uri projectRootUri,
  ) async {
    final analysisOptions =
        io.File(p.join(projectRootUri.path, 'analysis_options.yaml'));
    final pubspecFile = io.File(p.join(projectRootUri.path, 'pubspec.yaml'));
    if (analysisOptions.existsSync()) {
      try {
        final analysisOptionsContents = await analysisOptions.readAsString();
        // final pubspecContents = await pubspecFile.readAsString();
        // final pubspec = Pubspec.parse(pubspecContents);
        return ProjectConfiguration.parse(
          analysisOptionsContents,
          // packageName: pubspec.name,
        );
      } catch (e) {
        print(
            'error getting sidecar configuration from pubspec/analysis options. $e');
        rethrow;
      }
    } else {
      throw UnimplementedError(
        'no pubspec file found; please make sure this is a dart directory.',
      );
    }
  }
}
