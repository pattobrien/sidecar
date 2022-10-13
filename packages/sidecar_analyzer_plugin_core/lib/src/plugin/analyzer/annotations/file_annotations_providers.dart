// import 'package:analyzer/dart/analysis/context_root.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:sidecar/builder.dart';

// import '../analyzed_file/analyzed_file.dart';
// import '../utils/utils.dart';
// import 'annotation_visitor.dart';
// import 'resolved_unit_service.dart';

// final annotationsAggregateProvider =
//     FutureProvider.family<List<SidecarAnnotatedNode>, ContextRoot>(
//   (ref, contextRoot) async {
//     final result = await Future.wait(contextRoot
//         .typedAnalyzedFiles()
//         .map<Future<List<SidecarAnnotatedNode>>>((analyzedFile) {
//       return ref.watch(fileAnnotationProvider(analyzedFile).future);
//     }));
//     return result.expand((element) => element).toList();
//   },
//   dependencies: [
//     fileAnnotationProvider,
//   ],
// );

// final fileAnnotationProvider =
//     FutureProvider.family<List<SidecarAnnotatedNode>, AnalyzedFile>(
//   (ref, file) async {
//     final visitor = AnnotationVisitor();
//     // ref.listen(resolvedUnitProvider(file), (_, next) => ref.invalidateSelf());

//     final unitResult = await ref.watch(resolvedUnitProvider(file).future);
//     if (unitResult == null) return [];

//     unitResult.unit.accept(visitor);
//     return visitor.annotatedNodes;
//   },
//   dependencies: [
//     resolvedUnitProvider,
//   ],
// );

// final fileAnnotationReporter = Provider.family<void, AnalyzedFile>(
//   (ref, analyzedFile) {
//     final reporter = ref.watch(fileReportProvider(analyzedFile).notifier);
//     ref.listen<AsyncValue<List<SidecarAnnotatedNode>>>(
//         fileAnnotationProvider(analyzedFile), (previous, next) {
//       if (next.isLoading) {
//         reporter.recordAnnotationsStart();
//       } else if (previous?.isLoading == true && !next.isLoading) {
//         // done loading
//         reporter.recordAnnotationsCompleted();
//       }
//     });
//   },
//   dependencies: [
//     fileReportProvider,
//     fileAnnotationProvider,
//   ],
// );
