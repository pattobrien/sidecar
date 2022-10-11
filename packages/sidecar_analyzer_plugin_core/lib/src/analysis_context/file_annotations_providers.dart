import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../analysis_context_collection/analysis_context_collection.dart';
import '../analyzed_file/analyzed_file.dart';
import '../application/analysis_results/file_report_provider.dart';
import '../utils/utils.dart';
import 'annotation_visitor.dart';
import 'resolved_unit_service.dart';

final annotationsAggregateProvider =
    FutureProvider.family<List<SidecarAnnotatedNode>, ContextRoot>(
  (ref, contextRoot) async {
    final result = await Future.wait(contextRoot
        .typedAnalyzedFiles()
        .map<Future<List<SidecarAnnotatedNode>>>((analyzedFile) {
      return ref.watch(fileAnnotationProvider(analyzedFile).future);
    }));
    return result.expand((element) => element).toList();
  },
  dependencies: [
    fileAnnotationProvider,
  ],
);

final fileAnnotationProvider =
    FutureProvider.family<List<SidecarAnnotatedNode>, AnalyzedFile>(
  (ref, analyzedFile) async {
    final visitor = AnnotationVisitor();

    final context =
        await ref.watch(enabledContextProvider(analyzedFile).future);
    final unitResult =
        await ref.watch(resolvedUnitContextProvider(context).future);

    if (unitResult[analyzedFile] == null) return [];

    unitResult[analyzedFile]!.unit.accept(visitor);
    return visitor.annotatedNodes;
  },
  dependencies: [
    enabledContextProvider,
    resolvedUnitContextProvider,
  ],
);

final fileAnnotationReporter = Provider.family<void, AnalyzedFile>(
  (ref, analyzedFile) {
    final reporter = ref.watch(fileReportProvider(analyzedFile).notifier);
    ref.listen<AsyncValue<List<SidecarAnnotatedNode>>>(
        fileAnnotationProvider(analyzedFile), (previous, next) {
      if (next.isLoading) {
        reporter.recordAnnotationsStart();
      } else if (previous?.isLoading == true && !next.isLoading) {
        // done loading
        reporter.recordAnnotationsCompleted();
      }
    });
  },
  dependencies: [
    fileReportProvider,
    fileAnnotationProvider,
  ],
);
