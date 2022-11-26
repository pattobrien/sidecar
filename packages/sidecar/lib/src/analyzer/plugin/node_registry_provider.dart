import 'package:riverpod/riverpod.dart';

import '../../protocol/analyzed_file.dart';
import '../ast/ast.dart';

final nodeRegistryForFileLintsProvider =
    Provider.family<NodeRegistry, AnalyzedFile>((ref, file) {
  return NodeRegistry();
});

final nodeRegistryForFileAssistsProvider =
    Provider.family<NodeRegistry, AnalyzedFile>((ref, file) {
  return NodeRegistry();
});
