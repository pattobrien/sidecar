import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/channel/channel.dart';
import 'package:riverpod/riverpod.dart';

import '../protocol/active_package.dart';
import 'sidecar_server.dart';

final serverResourceProvider = Provider<ResourceProvider>(
  (ref) => PhysicalResourceProvider.INSTANCE,
  name: 'middlemanResourceProvider',
  dependencies: const [],
);

final runnerActiveContextProvider =
    StateProvider<List<ActivePackage>>((ref) => []);

final runnersProvider = Provider<List<SidecarServer>>((ref) {
  final activePrimaryContexts = ref.watch(runnerActiveContextProvider);
  return activePrimaryContexts.map((context) {
    return SidecarServer(ref, activePackage: context);
  }).toList();
});

// should be overriden before plugin startup
final analyzerPluginChannelProvider = Provider<PluginCommunicationChannel>(
  (ref) => throw UnimplementedError(),
  name: 'analyzerPluginChannelProvider',
  dependencies: const [],
);
