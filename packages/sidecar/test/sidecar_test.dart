import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/memory_file_system.dart';

void main() {
  final resourceProvider = MemoryResourceProvider(
    delayWatcherInitialization: const Duration(milliseconds: 100),
  );
  resourceProvider.newFile(path, content);
  final includedPaths = <String>[];
  final collection = AnalysisContextCollection(
    includedPaths: includedPaths,
    resourceProvider: resourceProvider,
  );
  collection.contexts;
}
