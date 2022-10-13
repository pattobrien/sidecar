import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../active_project/active_project.dart';

final resolvedUnitProvider =
    FutureProvider.family<ResolvedUnitResult?, String>((ref, path) async {
  final context = ref.watch(activeContextsProvider.select((value) =>
      value.firstWhere((element) => element.contextRoot.isAnalyzed(path))));

  final analysisSession = context.currentSession;
  final someUnitResult = await analysisSession.getResolvedUnit(path);
  return someUnitResult is ResolvedUnitResult ? someUnitResult : null;
});
