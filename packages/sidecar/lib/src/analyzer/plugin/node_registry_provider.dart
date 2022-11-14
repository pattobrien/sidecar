import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../ast/ast.dart';

final nodeRegistryForFileProvider =
    Provider.family<NodeRegistry, AnalyzedFileWithContext>((ref, file) {
  return NodeRegistry();
});
