import 'dart:io' as io;
import 'package:path/path.dart' as p;

import 'package:sidecar/sidecar.dart';

const analysisOptionsFileName = 'analysis_options.yaml';

class ProjectUtilities {
  static Future<ProjectConfiguration> getSidecarConfiguration(
    Uri projectRootUri,
  ) async {
    final analysisOptions =
        io.File(p.join(projectRootUri.path, analysisOptionsFileName));
    if (analysisOptions.existsSync()) {
      try {
        final analysisOptionsContents = await analysisOptions.readAsString();
        return ProjectConfiguration.parse(analysisOptionsContents);
      } catch (e) {
        print(
            'SIDECAR: Sidecar is not configured in analysis_options.yaml file.');
        print(
            'SIDECAR: Please ensure the plugin is listed under "analyzer" > "plugins" and');
        print('SIDECAR: that a top-level sidecar configuration is given.');
        rethrow;
      }
    } else {
      throw UnimplementedError(
        'no analysis_options.yaml file found for sidecar configuration to be located.',
      );
    }
  }
}
