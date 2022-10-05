import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:rxdart/subjects.dart';
import 'package:sidecar/builder.dart';

import '../../context_services/analyzed_file.dart';
import '../analysis_context_collection_service/analysis_context_collection_service.dart';
import '../log_delegate/log_delegate_base.dart';

class ResolvedUnitService {
  ResolvedUnitService(
    this.ref, {
    required this.analyzedFile,
  });
  final Ref ref;
  final AnalyzedFile analyzedFile;

  final _controller = BehaviorSubject<ResolvedUnitResult>();
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
