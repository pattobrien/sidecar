import 'package:analyzer/dart/analysis/results.dart';
import 'package:riverpod/riverpod.dart';

import '../../../services/services.dart';
import '../../protocol/protocol.dart';
import '../active_project/active_project.dart';

final resolvedUnitProvider =
    FutureProvider.family<ResolvedUnitResult?, AnalyzedFile>(
  (ref, file) async {
    final context = ref.watch(activeContextsProvider.select((value) =>
        value.firstWhere((element) => element.contextRoot
            .analyzedFiles()
            .any((element) => element == file.path))));

    final analysisSession = context.currentSession;
    final someUnitResult = await analysisSession.getResolvedUnit(file.path);
    ref.watch(logDelegateProvider).sidecarMessage(
        '${file.path} resolved unit = ${someUnitResult is ResolvedUnitResult}');
    return someUnitResult is ResolvedUnitResult ? someUnitResult : null;
  },
  name: 'resolvedUnitProvider',
  dependencies: [
    activeContextsProvider,
    logDelegateProvider,
  ],
);
