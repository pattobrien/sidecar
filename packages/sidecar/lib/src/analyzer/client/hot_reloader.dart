import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:hotreloader/hotreloader.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../../utils/utils.dart';
import 'client.dart';

final hotReloaderProvider = FutureProvider<HotReloader>((ref) async {
  hierarchicalLoggingEnabled = true;
  HotReloader.logLevel = Level.OFF;
  final hotreloadResourceProvider = PhysicalResourceProvider.INSTANCE;

  final client = ref.watch(analyzerClientProvider);

  return HotReloader.create(
    onAfterReload: (c) async {
      final files = c.events?.map((e) => e.path).toSet() ?? {};
      final fileContents = {
        for (final file in files)
          file: hotreloadResourceProvider.getFile(file).exists
              ? hotreloadResourceProvider.getFile(file).readAsStringSync()
              : null,
      };
      final watch = Stopwatch()..start();
      final timestamp = DateTime.now().toIso8601String();
      print('\u001b[31m\n$timestamp RELOADING...\n\u001b[0m');

      final rootPaths = client.roots.map((e) => e.path).toList();
      for (final event in fileContents.entries) {
        final filePath = event.key;
        final fileContents = event.value;
        if (rootPaths.any((root) => p.isWithin(root, filePath))) {
          if (fileContents == null) {
            client.handleDeletedFile(Uri.parse(filePath));
          } else {
            client.handleFileChange(Uri.parse(filePath), fileContents);
          }
          //   final pluginUri = runner.activePackage.sidecarPluginPackage;
          // } else if (p.isWithin(pluginUri.root.path, filePath)) {
          //   // TODO: refresh runner / analyzer
          //   // container.refresh(runnersProvider);
          //   // await runner.initialize();
        }
      }
      print('total time to reload: ${watch.elapsed.prettified()}');
    },
  );
});
