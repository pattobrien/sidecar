import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../context/context.dart';
import '../plugin/plugin.dart';
import '../server/log_delegate.dart';

final resolvedUnitProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>(
  (ref, file) async {
    final watch = Stopwatch()..start();
    final context = ref.watch(activeContextForRootProvider(file.root));
    final analysisSession = context.currentSession;
    final someUnitResult = await analysisSession.getResolvedUnit(file.path);
    final countS = '${watch.elapsed.inSeconds.remainder(60)}';
    final countMs =
        watch.elapsed.inMilliseconds.remainder(1000).toString().padLeft(3, '0');
    ref.watch(logDelegateProvider).sidecarVerboseMessage(
        'resolvedUnitProvider completed in $countS.${countMs}s - ${file.relativePath}');
    watch.stop();
    return someUnitResult is ResolvedUnitResult ? someUnitResult : null;
  },
  name: 'resolvedUnitProvider',
  dependencies: [
    activeContextForRootProvider,
    logDelegateProvider,
  ],
);
