import 'package:riverpod/riverpod.dart';
import 'package:collection/collection.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';
import '../active_contexts/active_contexts.dart';
import 'isolates.dart';

final isolateDetailsProvider = Provider<List<IsolateDetails>>(
  (ref) {
    ref.watch(_isolateUpdateProvider);
    final isolateService = ref.watch(isolateBuilderServiceProvider);
    final isolateCommunication = ref.watch(isolateCommunicationServiceProvider);
    ref.listenSelf((previous, next) {
      final changedIsolates = next.where(
          (isolate) => previous?.any((element) => isolate != element) ?? true);
      changedIsolates.forEach(isolateCommunication.addIsolateListener);
    });
    final activeContexts = ref.watch(activeContextsProvider);
    final isolates = activeContexts.map(isolateService.startIsolate).toList();
    return isolates;
  },
  name: 'isolateDetailsProvider',
  dependencies: [
    activeContextRootsProvider,
    isolateBuilderServiceProvider,
    activeContextForContextRootProvider,
  ],
);

final _isolateUpdateProvider = Provider<void>(
  (ref) {
    void _log(String msg) => ref.watch(logDelegateProvider).sidecarMessage(msg);
    ref.listen<List<ActiveContext>>(activeContextsProvider,
        (oldContexts, newContexts) {
      _log(
          'LINT EQUALITY CHECK ||  ${oldContexts?.length ?? 0} old context || ${newContexts.length} new contexts');
      // for all new contexts
      if (oldContexts == null) {
        // definitely rebuild
      } else {
        for (final newContext in newContexts) {
          final oldContext = oldContexts.firstWhereOrNull(
              (oldContext) => oldContext.activeRoot == newContext.activeRoot);

          if (oldContext == null) {
            //definitely rebuild
            return;
          }
          // did packages change
          final oldLints = oldContext.sidecarOptions.lintPackages;
          final newLints = newContext.sidecarOptions.lintPackages;
          final areLintsEqual =
              const DeepCollectionEquality().equals(oldLints, newLints);
          _log('LINT EQUALITY: $areLintsEqual');
        }
      }
    }, fireImmediately: true);
  },
  name: '_isolateUpdateProvider',
  dependencies: [
    logDelegateProvider,
    activeContextsProvider,
  ],
);
