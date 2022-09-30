import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';

final queuedFilesProvider =
    Provider.family<QueuedFiles, ContextRoot>((ref, root) => QueuedFiles(root));

class QueuedFiles {
  QueuedFiles(this.contextRoot);

  final ContextRoot contextRoot;

  List<String> _paths = [];
  List<String> get paths => _paths;

  void addPaths(Iterable<String> paths) => _paths.addAll(paths);
  void removePath(String path) => _paths.remove(path);
  void clearPaths() => _paths.clear();
}
