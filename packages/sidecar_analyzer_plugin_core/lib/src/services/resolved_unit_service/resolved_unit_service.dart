import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../../context_services/analysis_errors.dart';
import '../analysis_context_collection_service/analysis_context_collection_service.dart';

class ResolvedUnitService {
  ResolvedUnitService(
    this.ref, {
    required this.analyzedFile,
  });
  // }) : assert(analyzedFile.isDartFile,
  //           '${analyzedFile.path}: ResolvedUnitService can only be used by Dart files');

  final Ref ref;
  final AnalyzedFile analyzedFile;

  final _controller = StreamController<ResolvedUnitResult>();
  Stream<ResolvedUnitResult> get stream => _controller.stream;

  Future<ResolvedUnitResult?> getResolvedUnit() async {
    final context = ref
        .read(analysisContextCollectionServiceProvider)
        .getContextFromRoot(analyzedFile.contextRoot);

    final unitResult =
        await context.currentSession.getResolvedUnit(analyzedFile.path);

    if (unitResult is! ResolvedUnitResult) {
      _controller.addError(unitResult);
      return null;
      // throw UnimplementedError();
    }
    _controller.add(unitResult);
    return unitResult;
  }
}

final resolvedUnitProvider =
    StreamProvider.family<ResolvedUnitResult, AnalyzedFile>(
        (ref, analyzedFile) {
  return ref.watch(resolvedUnitServiceProvider(analyzedFile)).stream;
});

final resolvedUnitServiceProvider =
    Provider.family<ResolvedUnitService, AnalyzedFile>((ref, analyzedFile) {
  return ResolvedUnitService(ref, analyzedFile: analyzedFile);
});
