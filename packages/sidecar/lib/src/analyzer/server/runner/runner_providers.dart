import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'context_providers.dart';
import 'sidecar_runner.dart';

part 'runner_providers.g.dart';

@Riverpod(keepAlive: true)
List<SidecarRunner> runners(
  RunnersRef ref,
) {
  final activePrimaryContexts = ref.watch(runnerActiveContextsProvider);
  final runners = activePrimaryContexts.map((context) {
    return SidecarRunner(ref, activePackage: context);
  }).toList();
  return runners;
}
