import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

import '../analysis_context_collection/enabled_contexts_provider.dart';
import '../analyzed_file/analyzed_file.dart';

final analyzedFilesProvider = Provider.family<List<AnalyzedFile>, ContextRoot>(
  (ref, arg) {
    final root = ref
        .watch(contextRootsProvider)
        .firstWhere((contextRoot) => contextRoot == arg);
    return root.analyzedFiles().map((e) => AnalyzedFile(arg, e)).toList();
  },
  dependencies: [contextRootsProvider],
);
