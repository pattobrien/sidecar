// ignore_for_file: overridden_fields, implementation_imports

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/test_utilities/resource_provider_mixin.dart';
import 'package:cli_util/cli_util.dart';
import 'package:package_config/package_config.dart';
import 'package:path/path.dart';
import 'package:riverpod/riverpod.dart';
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';

import '../../sidecar.dart';
import '../utils/logger/logger.dart';
import 'project.dart';
import 'project_notifier.dart';

// void main() async {
//   final cliOptions = CliOptions.fromArgs(['--cli'], isPlugin: false);

//   final logDelegate = DebuggerLogDelegate(cliOptions);
//   logger.onRecord.listen((event) {
//     logDelegate.sidecarMessage(event.message);
//   });

//   final resourceProvider = MemoryResourceProvider();
//   final testSuite = TestSuite(resourceProvider);

//   final dep = Uri.parse(join(testSuite.workspace.path, 'packages'));
//   final container = ProviderContainer(
//     overrides: [
//       ruleConstructorProvider.overrideWithValue(constructors ?? []),
//       cliOptionsProvider.overrideWithValue(cliOptions),
//       logDelegateProvider.overrideWithValue(logDelegate),
//     ],
//     observers: [CliObserver(cliOptions)],
//   );
//   final newProject =
//       container.read(projectNotifierProvider('my_app', testSuite.workspace));

//   final collection = AnalysisContextCollection(
//     includedPaths: [testSuite.workspace.path],
//     resourceProvider: testSuite.resourceProvider,
//     sdkPath: testSuite.sdk.path,
//   );
//   print(collection.contexts.length);
//   print(collection.contexts.first.contextRoot.root.path);

//   final runner = container.read(runnerProvider);
//   await runner.initialize();
// }

class TestSuite with ResourceProviderMixin {
  TestSuite(this.resourceProvider) {
    _init();
  }

  @override
  final MemoryResourceProvider resourceProvider;

  final physicalResourceProvider = PhysicalResourceProvider.INSTANCE;

  Folder get _physicalSdk => physicalResourceProvider.getFolder(getSdkPath());

  Folder get sdk => resourceProvider.getFolder('/sdk');
  Folder get workspace => resourceProvider.getFolder('/workspace');

  List<Folder> addPackagesToPubCache(List<Package> packages) {
    // final pubCache = Platform.environment['PUB_CACHE'];
    final packageUris = packages.map((e) => e.root);
    return packageUris.map((uri) {
      final oldFolder = physicalResourceProvider.getFolder(uri.path);
      final newFolder = resourceProvider.getFolder('pub/');
      return oldFolder.copyTo(newFolder);
    }).toList();
  }

  void copyFolderToMemory(Folder folder, Folder newPath) {
    final resources = folder.getChildren();
    // print('copying ${resources.length} resources');
    for (final resource in resources) {
      if (resource is File) {
        // print('copying: ${resource.path} to ${newPath.path}');
        final relativeFolderPath = relative(resource.path, from: folder.path);
        final absolutePath = absolute(newPath.path, relativeFolderPath);
        final contents = resource.readAsBytesSync();
        final newFile = resourceProvider.getFile(absolutePath);
        newFile.writeAsBytesSync(contents);
      } else if (resource is Folder) {
        final relativeFolderPath = relative(resource.path, from: folder.path);
        final absolutePath = absolute(newPath.path, relativeFolderPath);
        final relativeFolder = resourceProvider.getFolder(absolutePath);
        copyFolderToMemory(resource, relativeFolder);
      }
    }
  }

  void _createWorkspace() => workspace.create();
  void _copySdkToMemory() => copyFolderToMemory(_physicalSdk, sdk);

  void _init() {
    _copySdkToMemory();
    _createWorkspace();
  }
}
