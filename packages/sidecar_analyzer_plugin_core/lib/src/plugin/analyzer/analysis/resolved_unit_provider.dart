import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../protocol/protocol.dart';
import '../active_project/active_project.dart';

final resolvedUnitProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>(
  (ref, file) async {
    final context = ref.watch(activeContextsProvider.select((value) => value
        .firstWhere((element) => element.contextRoot.isAnalyzed(file.path))));

    final analysisSession = context.currentSession;
    final someUnitResult = await analysisSession.getResolvedUnit(file.path);
    return someUnitResult is ResolvedUnitResult ? someUnitResult : null;
  },
  name: 'resolvedUnitProvider',
  dependencies: [
    activeContextsProvider,
  ],
);
