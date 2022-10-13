// // ignore_for_file: implementation_imports

// import 'dart:async';
// import 'dart:io' as io;

// import 'package:analyzer/dart/analysis/context_root.dart';
// import 'package:analyzer/instrumentation/noop_service.dart';
// import 'package:analyzer_plugin/src/channel/isolate_channel.dart' as plugin;
// import 'package:path/path.dart' as p;
// import 'package:riverpod/riverpod.dart';

// import '../../../sidecar_analyzer_plugin_core.dart';
// import '../../services/log_delegate/log_delegate.dart';
// import '../../services/plugin_generator/package_configuration_service.dart';
// import 'middleman.dart';

// final middlemanServerIsolateProvider =
//     Provider.family<MiddlemanServerIsolate, ContextRoot>(
//   (ref, root) => MiddlemanServerIsolate(ref, root: root),
//   dependencies: [
//     logDelegateProvider,
//     packageConfigServiceProvider,
//     middlemanCommunicationRouterProvider,
//   ],
// );

// class MiddlemanServerIsolate {
//   MiddlemanServerIsolate(this._ref, {required this.root});

//   final ContextRoot root;
//   final Ref _ref;

//   LogDelegateBase get delegate => _ref.read(logDelegateProvider);

//   PackageConfigurationService get rootPackageService =>
//       _ref.read(packageConfigServiceProvider(root.root.toUri()));

//   MiddlemanCommunicationRouter get middlemanRouter =>
//       _ref.read(middlemanCommunicationRouterProvider);

//   /// isolate running the sidecar plugin
//   late plugin.ServerIsolateChannel pluginIsolateChannel;

//   String get packagesPath =>
//       p.join(root.root.path, '.dart_tool', 'package_config.json');

//   String get pluginRoot =>
//       p.join(root.root.path, 'tool', 'sidecar_analyzer_plugin');

//   String get pluginExecutablePath => p.join(pluginRoot, 'sidecar.dart');

//   bool doesAlreadyExist() => io.Directory(pluginRoot).existsSync();

//   bool isRootValidProject() {
//     delegate.sidecarMessage('PROJECTSERVICE: root path ${root.root.path}');
//     final isValidProject = rootPackageService._isValidDartProject();
//     delegate.sidecarMessage('PROJECTSERVICE: is valid $isValidProject');
//     return isValidProject;
//   }

//   Future<void> initializeIsolate() async {
//     delegate.sidecarMessage('ISOLATE: init started...');

//     pluginIsolateChannel = plugin.ServerIsolateChannel.discovered(
//       Uri.file(pluginExecutablePath, windows: io.Platform.isWindows),
//       Uri.file(packagesPath, windows: io.Platform.isWindows),
//       NoopInstrumentationService(),
//     );

//     delegate.sidecarMessage('ISOLATE: server started, setting up listeners...');

//     await pluginIsolateChannel.listen(
//       (response) => middlemanRouter.handlePluginResponse(root, response),
//       (notif) => middlemanRouter.handlePluginNotification(root, notif),
//       onDone: () => middlemanRouter.handlePluginDone(root),
//       onError: (error) => middlemanRouter.handlePluginError(root, error),
//     );

//     delegate.sidecarMessage('ISOLATE: init completed.');
//   }

//   Future<void> setupPluginSourceFiles() async {
//     final sidecarDep = await rootPackageService.getSidecarPluginPackage();

//     if (sidecarDep == null) {
//       throw UnimplementedError('getSidecarPluginDependency returned null');
//     }

//     final pluginToolPath =
//         p.join(sidecarDep.path, 'tools', 'analyzer_plugin', 'bin');

//     final directory = io.Directory(p.join(pluginToolPath));
//     await directory.create(recursive: true);

//     final pluginFileEntities = directory.listSync(recursive: true);

//     String relativePluginFilePath(String path) {
//       return p.relative(path, from: pluginToolPath);
//     }

//     await Future.wait(
//         pluginFileEntities.whereType<io.Directory>().map((e) async {
//       final newPath = p.join(pluginRoot, relativePluginFilePath(e.path));
//       await io.Directory(newPath).create(recursive: true);
//     }));

//     await Future.wait(pluginFileEntities.whereType<io.File>().map((e) async {
//       final newPath = p.join(pluginRoot, relativePluginFilePath(e.path));

//       await e.copy(newPath);
//     }));

//     await _setupBootstrapper();
//   }

//   void shutdown() => pluginIsolateChannel.close();

//   Future<void> _setupBootstrapper() async {
//     final bootstrapperPath = p.join(pluginRoot, 'constructors.dart');
//     final importsBuffer = StringBuffer()..writeln(constructorFileHeader);
//     final listBuffer = StringBuffer()..writeln(constructorListBegin);

//     final config = await _ref.read(packageConfigurationProvider(root).future);
//     final sidecarDeps = await rootPackageService.findAllSidecarDeps(config);

//     for (final sidecarPackage in sidecarDeps.entries) {
//       final packageName = sidecarPackage.key;
//       importsBuffer.writeln(
//           "import 'package:$packageName/$packageName.dart' as $packageName;");
//       final rules = [
//         ...?sidecarPackage.value.lints,
//         ...?sidecarPackage.value.edits,
//       ];
//       for (final rule in rules) {
//         listBuffer.writeln('\t$packageName.${rule.className}.new,');
//       }
//     }

//     final fullContents = StringBuffer()
//       ..writeln(importsBuffer.toString())
//       ..writeln(listBuffer.toString())
//       ..writeln(constructorListEnd);

//     await io.File(bootstrapperPath).writeAsString(fullContents.toString());
//   }
// }
