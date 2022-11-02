// ignore_for_file: implementation_imports

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/memory_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/src/test_utilities/resource_provider_mixin.dart';
import 'package:path/path.dart';

AnalysisContextCollection createTestContextForPath(
  String root, {
  required MemoryResourceProvider resourceProvider,
  required String sdkPath,
}) {
  // MemoryResourceProvider();
  final collection = AnalysisContextCollection(
    includedPaths: [root],
    resourceProvider: resourceProvider,
    sdkPath: sdkPath,
  );
  return collection;
}

// class LinterTestSuite {
//   void doSomething() {
//     var memoryResourceProvider = MemoryResourceProvider(
//         context: PhysicalResourceProvider.INSTANCE.pathContext);
//     var resourceProvider = TestResourceProvider(memoryResourceProvider);

//     var sdkRoot = memoryResourceProvider.getFolder(
//       memoryResourceProvider.convertPath('/sdk'),
//     );
//     createMockSdk(
//       resourceProvider: memoryResourceProvider,
//       root: sdkRoot,
//     );

//     var options = LinterOptions([rule], analysisOptions)
//       ..dartSdkPath = sdkRoot.path
//       ..resourceProvider = resourceProvider;

//     return DartLinter(options);
//   }
// }

// /// A resource provider that accesses entities in a MemoryResourceProvider,
// /// falling back to the PhysicalResourceProvider when they don't exist.
class TestResourceProvider extends ResourceProvider {
  TestResourceProvider(this.memoryResourceProvider);

  static final PhysicalResourceProvider physicalResourceProvider =
      PhysicalResourceProvider.INSTANCE;

  final MemoryResourceProvider memoryResourceProvider;

  @override
  Context get pathContext => physicalResourceProvider.pathContext;

  @override
  File getFile(String path) {
    final file = memoryResourceProvider.getFile(path);
    return file.exists ? file : physicalResourceProvider.getFile(path);
  }

  @override
  Folder getFolder(String path) {
    final folder = memoryResourceProvider.getFolder(path);
    return folder.exists ? folder : physicalResourceProvider.getFolder(path);
  }

  @override
  Resource getResource(String path) {
    final resource = memoryResourceProvider.getResource(path);
    return resource.exists
        ? resource
        : physicalResourceProvider.getResource(path);
  }

  @override
  Folder? getStateLocation(String pluginId) =>
      physicalResourceProvider.getStateLocation(pluginId);
}
