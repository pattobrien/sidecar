import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../context/active_context.dart';
import 'context_providers.dart';
import 'sidecar_runner.dart';

part 'runner_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<SidecarRunner>> getRunners(
  GetRunnersRef ref,
  // Uri activeRoot,
) async {
  // print('creating runners');
  final activePrimaryContexts = ref.watch(runnerActiveContextsProvider);
  final runners = await Future.wait(activePrimaryContexts.map((context) async {
    final runner = SidecarRunner(ref, context: context, contextRoots: []);
    // print('creating runners: init');
    await runner.initialize();
    return runner;
  }));
  return runners;
}

@riverpod
Future<SidecarRunner> runnerForContext(
  RunnerForContextRef ref,
  ActiveContext context,
) async {
  final runners = await ref.watch(getRunnersProvider.future);
  return runners.firstWhere((element) => element.context == context);
}
