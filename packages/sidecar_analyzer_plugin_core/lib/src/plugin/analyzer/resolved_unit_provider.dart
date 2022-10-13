import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import 'active_context_provider.dart';

final resolvedUnitProvider =
    FutureProvider.family<ResolvedUnitResult?, String>((ref, path) async {
  final contexts = ref.watch(activePluginContextsProvider);
  final analysisSession = contexts
      .firstWhere((element) => element.contextRoot.isAnalyzed(path))
      .currentSession;
  final someUnitResult = await analysisSession.getResolvedUnit(path);
  return someUnitResult is ResolvedUnitResult ? someUnitResult : null;
});
