// import 'package:analyzer/dart/analysis/context_root.dart';
// import 'package:riverpod/riverpod.dart';

// import '../analysis_context_collection/enabled_contexts_provider.dart';
// import '../context_services/context_services.dart';

// final analyzedFilesProvider =
//     Provider.family<List<AnalyzedFile>, ContextRoot>((ref, arg) {
//   final root = ref
//       .watch(contextRootsProvider)
//       .firstWhere((contextRoot) => contextRoot == arg);
//   return root.analyzedFiles().map((e) => AnalyzedFile(arg, e)).toList();
// });
