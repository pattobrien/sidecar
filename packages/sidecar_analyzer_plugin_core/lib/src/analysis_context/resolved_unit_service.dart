import 'dart:async';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../analyzed_file/analyzed_file.dart';
import '../utils/utils.dart';

class ResolvedUnitService {
  const ResolvedUnitService(
    this.ref, {
    required this.context,
  });

  final Ref ref;
  final AnalysisContext context;

  Future<ResolvedUnitResult?> getResolvedUnit(AnalyzedFile file) async {
    final unitResult = await context.currentSession.getResolvedUnit(file.path);

    if (unitResult is! ResolvedUnitResult) {
      return null;
    } else {
      return unitResult;
    }
  }
}

final resolvedUnitContextProvider = FutureProvider.family<
    Map<AnalyzedFile, ResolvedUnitResult?>, AnalysisContext>(
  (ref, context) async {
    final service = ref.watch(resolvedUnitServiceProvider(context));
    final results = <AnalyzedFile, ResolvedUnitResult?>{};
    await Future.wait(context.contextRoot.typedAnalyzedFiles().map((e) async {
      return results[e] = await service.getResolvedUnit(e);
    }));
    return results;
  },
  dependencies: [resolvedUnitServiceProvider],
);

final resolvedUnitServiceProvider =
    Provider.family<ResolvedUnitService, AnalysisContext>(
  (ref, context) {
    return ResolvedUnitService(ref, context: context);
  },
  dependencies: [],
);
