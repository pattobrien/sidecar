import 'dart:async';

import 'package:riverpod/riverpod.dart';

import '../../context/active_context.dart';
import 'context_providers.dart';
import 'sidecar_runner.dart';

final newRunnerProvider = FutureProvider<List<SidecarRunner>>(
  (ref) async {
    final activePrimaryContexts =
        ref.watch(activePrimaryContextsForRunnerProvider);
    final runners =
        await Future.wait(activePrimaryContexts.map((context) async {
      final runner = SidecarRunner(ref, context: context, contextRoots: []);
      await runner.initialize();
      return runner;
    }));
    return runners;
  },
  name: 'newRunnerProvider',
);

final newRunnerForContextProvider =
    FutureProvider.family<SidecarRunner, ActiveContext>(
  (ref, context) async {
    final runners = await ref.watch(newRunnerProvider.future);
    return runners.firstWhere((element) => element.context == context);
  },
  name: 'newRunnerProvider',
);
