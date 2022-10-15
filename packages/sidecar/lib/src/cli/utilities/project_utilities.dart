import 'dart:io' as io;
import 'package:path/path.dart' as p;

import '../../configurations/configurations.dart';

const analysisOptionsFileName = 'analysis_options.yaml';
const sidecarOptionsFileName = 'sidecar.yaml';

Future<ProjectConfiguration> getSidecarConfiguration(
  Uri projectRootUri,
) async {
  final analysisOptions =
      io.File(p.join(projectRootUri.path, analysisOptionsFileName));
  final sidecarOptions =
      io.File(p.join(projectRootUri.path, sidecarOptionsFileName));
  if (sidecarOptions.existsSync()) {
    try {
      final sidecarOptionsContents = await sidecarOptions.readAsString();
      return ProjectConfiguration.parseFromSidecarYaml(
        sidecarOptionsContents,
        sourceUrl: sidecarOptions.uri,
      );
    } catch (e) {
      io.stdout.writeln(
          'SIDECAR: Sidecar is not properly configured in sidecar.yaml file.');
      io.stdout.writeln(
          'SIDECAR: Please ensure the plugin is listed under analyzer_options.yaml > "analyzer" > "plugins" and');
      io.stdout.writeln(
          'SIDECAR: that a top-level sidecar configuration is given in sidecar.yaml.');
      rethrow;
    }
  }
  if (analysisOptions.existsSync()) {
    try {
      final analysisOptionsContents = await analysisOptions.readAsString();
      final config = ProjectConfiguration.parseFromAnalysisOptions(
        analysisOptionsContents,
        sourceUrl: sidecarOptions.uri,
      );

      if (sidecarOptions.existsSync()) {
        throw UnimplementedError(
            'Both sidecar.yaml and analysis_options.yaml are available. Please configure sidecar in one or the other.');
      }
      return config;
    } catch (e) {
      io.stdout.writeln(
          'SIDECAR: Sidecar is not configured in analysis_options.yaml file.');
      io.stdout.writeln(
          'SIDECAR: Please ensure the plugin is listed under "analyzer" > "plugins" and');
      io.stdout
          .writeln('SIDECAR: that a top-level sidecar configuration is given.');
      rethrow;
    }
  } else {
    throw UnimplementedError(
      'no analysis_options.yaml file found for sidecar configuration to be located.',
    );
  }
}
