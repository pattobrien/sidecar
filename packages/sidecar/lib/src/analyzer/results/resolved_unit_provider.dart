import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../utils/logger/logger.dart';
import '../context/context.dart';
import '../plugin/plugin.dart';

final resolvedUnitProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>(
  (ref, file) async {
    final context = ref.watch(activeContextForRootProvider(file.root));
    final analysisSession = context.currentSession;
    final someUnitResult = await analysisSession.getResolvedUnit(file.path);
    ref.watch(logDelegateProvider).sidecarMessage(
        'resolvedUnitProvider ${file.relativePath} ${someUnitResult is ResolvedUnitResult}');
    return someUnitResult is ResolvedUnitResult ? someUnitResult : null;
  },
  name: 'resolvedUnitProvider',
  dependencies: [
    activeContextForRootProvider,
    logDelegateProvider,
  ],
);
