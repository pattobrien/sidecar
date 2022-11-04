import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../context/active_context.dart';

part 'context_providers.g.dart';

@Riverpod(keepAlive: true)
class RunnerActiveContexts extends _$RunnerActiveContexts {
  @override
  List<ActiveContext> build() {
    return [];
  }

  set update(List<ActiveContext> contexts) => state = contexts;

  // void removeDirectory(Directory directory) {
  //   state = state
  //       .where((element) => element.activeRoot.root.path != directory.path)
  //       .toList();
  // }
}

// @riverpod
// List<ContextDetails> allContextsForRunner(
//     AllContextsForRunnerRef ref, Directory directory) {
//   final service = ref.watch(activeProjectServiceProvider);
//   final resourceProvider = ref.watch(runnerResourceProvider);
//   return service.createActiveContextDetails(directory.uri, resourceProvider);
// }

// @riverpod
// List<ActiveContext> activeContextsForRunner(
//   ActiveContextsForRunnerRef ref,
//   Directory directory,
// ) {
//   final directories = ref.watch(allContextsForRunnerProvider(directory));
//   final service = ref.watch(activeProjectServiceProvider);
//   return service.getActiveContextsFromPath(directory.path);
// }

final runnerResourceProvider = Provider(
  (ref) => PhysicalResourceProvider.INSTANCE,
  name: 'runnerResourceProviderProvider',
);
