// import 'dart:async';
// import 'dart:io';

// import 'package:args/command_runner.dart';

// import '../../project/project.dart';
// import '../../utilities/utilities.dart';
// import '../exit_codes.dart';

// class InitCommand extends Command<int> {
//   InitCommand();

//   @override
//   String get description => 'initialize a project with sidecar configuration';

//   @override
//   String get name => 'init';

//   @override
//   FutureOr<int> run() async {
//     try {
//       logger.stdout('\nSIDECAR: starting initialization processs');
//       final currentDirectory = Directory.current;
//       logger.trace('project directory: ${currentDirectory.path}');
//       final projectService = ProjectService(currentDirectory);

//       // insert any applicable version of sidecar_analyzer_plugin into project pubspec
//       // get that plugin's version number from the project package_config.json file and
//       // use it as the base of which to copy source code files into <project_root>/.sidecar/sidecar_analyzer_plugin
//       // and finally replace the hosted sidecar_analyzer_plugin dependency with the newly-copied dependency from path
//       await projectService.insertPluginIntoProjectPubspec();
//       await Future<void>.delayed(const Duration(seconds: 1));
//       final pluginUri = await projectService.getPluginVersion();
//       await Future<void>.delayed(const Duration(seconds: 1));
//       await projectService.copyBasePluginFromSource(pluginUri);
//       await Future<void>.delayed(const Duration(seconds: 1));
//       await projectService.insertProjectPluginIntoPubspec();
//       await Future<void>.delayed(const Duration(seconds: 1));

//       // check for a sidecar.yaml file or an analysis_options.yaml file with sidecar config
//       // and if one doesn't exist, create one
//       await projectService.setupAnalysisOptionsFile();
//       await Future<void>.delayed(const Duration(seconds: 1));

//       // insert a VSCode setting that watches analysis_options.yaml and/or sidecar.yaml for changes and triggers ```sidecar rebuild``` automatically
//       await projectService.insertVscodeTask();
//       await Future<void>.delayed(const Duration(seconds: 1));

//       logger.stdout('\nSIDECAR initialization completed.');
//       // await rebuildProcess();
//       return ExitCode.success;
//     } catch (e) {
//       logger.stderr('\nSIDECAR ERROR: $e');
//       rethrow;
//     }
//   }
// }
