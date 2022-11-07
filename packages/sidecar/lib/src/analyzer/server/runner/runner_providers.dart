import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../context/active_context.dart';
import 'context_providers.dart';
import 'sidecar_runner.dart';

part 'runner_providers.g.dart';

@Riverpod(keepAlive: true)
List<SidecarRunner> runners(
  RunnersRef ref,
  // Uri activeRoot,
) {
  // print('creating runners');
  final activePrimaryContexts = ref.watch(runnerActiveContextsProvider);
  final runners = activePrimaryContexts.map((context) {
    final runner = SidecarRunner(ref, context: context);
    // print('creating runners: init');
    // await runner.initialize();
    return runner;
  }).toList();
  return runners;
}

@Riverpod(keepAlive: true)
Future<void> runnersInitializer(RunnersInitializerRef ref) async {
  final runners = ref.watch(runnersProvider);
  await Future.wait(runners.map((runner) => runner.initialize()));
  await Future.wait(runners.map((runner) => runner.requestSetContext()));
}

@riverpod
SidecarRunner runnerForContext(
  RunnerForContextRef ref,
  ActiveContext context,
) {
  final runners = ref.watch(runnersProvider);
  return runners.firstWhere((element) => element.context == context);
}
