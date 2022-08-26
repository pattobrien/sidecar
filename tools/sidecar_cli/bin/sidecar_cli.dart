import 'dart:io';

import 'package:riverpod/riverpod.dart';

import 'package:sidecar_cli/sidecar_cli.dart';

void main(List<String> arguments) async {
  final ref = ProviderContainer(overrides: [
    sidecarPubServiceProvider.overrideWithValue(SidecarPubServiceImpl())
  ]);

  final currentDirectory = Directory.current;
  final projectService = ref.read(projectServiceProvider(currentDirectory));

  final lints = await ConfigParseUtilities.parseConfig(currentDirectory.uri);
  await projectService.copyBasePluginFromSource();
  await projectService.importLints(lints);
  await projectService.generateLintBootstrapFunction(lints);
  await projectService.insertPluginIntoProjectPubspec();
  await projectService.createProjectPluginSymlink();
  await projectService.insertVscodeTask();
  await projectService.restartAnalyzerPlugin();
}
