import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:hotreloader/hotreloader.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';

import '../reports/stdout_reporter.dart';
import 'client.dart';

final hotReloaderProvider = FutureProvider<HotReloader>((ref) async {
  hierarchicalLoggingEnabled = true;
  HotReloader.logLevel = Level.OFF;
  return HotReloader.create(
    onAfterReload: ref.read(hotReloadNotifierProvider.notifier).onAfterReload,
  );
});

final hotReloadNotifierProvider = StateNotifierProvider(HotReloadNotifier.new);

class HotReloadNotifier extends StateNotifier<AsyncValue<void>> {
  HotReloadNotifier(this._ref) : super(const AsyncValue.data(null));

  final Ref _ref;

  final hotreloadResourceProvider = PhysicalResourceProvider.INSTANCE;

  Future<void> onAfterReload(AfterReloadContext c) async {
    state = const AsyncValue<void>.loading();
    final client = _ref.watch(analyzerClientProvider);
    final reporter = _ref.watch(stdoutReportProvider);
    reporter.refresh();
    final files = c.events?.map((e) => e.path).toSet() ?? {};
    final fileContents = {
      for (final file in files)
        file: hotreloadResourceProvider.getFile(file).exists
            ? hotreloadResourceProvider.getFile(file).readAsStringSync()
            : null,
    };
    final timestamp = DateTime.now().toIso8601String();
    print('\u001b[31m\n$timestamp RELOADING...\n\u001b[0m');

    final rootPaths = client.roots.map((e) => e.toFilePath()).toList();
    for (final event in fileContents.entries) {
      final filePath = event.key;
      final fileContents = event.value;
      if (rootPaths.any((root) => p.isWithin(root, filePath))) {
        if (fileContents == null) {
          client.handleDeletedFile(Uri.file(filePath));
        } else {
          await client.handleFileChange(Uri.file(filePath), fileContents);
        }
        //   final pluginUri = runner.activePackage.sidecarPluginPackage;
        // } else if (p.isWithin(pluginUri.root.path, filePath)) {
        //   // TODO: refresh runner / analyzer
        //   // container.refresh(runnersProvider);
        //   // await runner.initialize();
      }
    }
    // print('total time to reload: ${watch.elapsed.prettified()}');
    state = const AsyncValue.data(null);
  }
}
