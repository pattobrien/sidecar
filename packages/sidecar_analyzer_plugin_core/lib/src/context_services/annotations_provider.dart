// import 'package:analyzer/dart/analysis/analysis_context.dart';
// import 'package:analyzer/dart/ast/ast.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:sidecar_analyzer_plugin_core/src/states/file_annotations_state.dart';

// import 'analysis_errors.dart';

// final annotationsAggregateProvider =
//     Provider.family<List<AnnotatedNode>, AnalysisContext>((ref, context) {
//   List<AnnotatedNode> nodes = [];
//   for (final file in context.contextRoot.analyzedFiles()) {
//     final annotations = ref.watch(
//       annotationsStateNotifierProvider(AnalyzedFile(context.contextRoot, file)),
//     );
//     nodes.addAll(annotations.nodes);
//   }
//   return nodes;
// });
