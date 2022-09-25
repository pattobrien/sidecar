import 'dart:io' as io;
import 'package:path/path.dart' as p;

import 'package:sidecar/sidecar.dart';

const analysisOptionsFileName = 'analysis_options.yaml';
const sidecarOptionsFileName = 'sidecar.yaml';

class ProjectUtilities {
  static Future<ProjectConfiguration> getSidecarConfiguration(
    Uri projectRootUri,
  ) async {
    final analysisOptions =
        io.File(p.join(projectRootUri.path, analysisOptionsFileName));
    final sidecarOptions =
        io.File(p.join(projectRootUri.path, sidecarOptionsFileName));
    if (await sidecarOptions.exists()) {
      try {
        final sidecarOptionsContents = await sidecarOptions.readAsString();
        return ProjectConfiguration.parse(
          sidecarOptionsContents,
          sourceUrl: sidecarOptions.uri,
        );
      } catch (e) {
        print(
            'SIDECAR: Sidecar is not properly configured in sidecar.yaml file.');
        print(
            'SIDECAR: Please ensure the plugin is listed under analyzer_options.yaml > "analyzer" > "plugins" and');
        print(
            'SIDECAR: that a top-level sidecar configuration is given in sidecar.yaml.');
        rethrow;
      }
    }
    if (await analysisOptions.exists()) {
      try {
        final analysisOptionsContents = await analysisOptions.readAsString();
        final config = ProjectConfiguration.parse(
          analysisOptionsContents,
          sourceUrl: sidecarOptions.uri,
        );

        if (sidecarOptions.existsSync()) {
          throw UnimplementedError(
              'Both sidecar.yaml and analysis_options.yaml are available. Please configure sidecar in one or the other.');
        }
        return config;
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
