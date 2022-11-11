import 'package:riverpod/riverpod.dart';

import '../ast/ast.dart';
import '../context/analyzed_file.dart';

final nodeRegistryForFileProvider =
    Provider.family<NodeRegistry, AnalyzedFileWithContext>((ref, file) {
  return NodeRegistry();
});
