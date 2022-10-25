import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';

AnalysisContext createTestContextForPath(
  Directory root, {
  ResourceProvider? resourceProvider,
}) {
  final collection = AnalysisContextCollection(
    includedPaths: [root.path],
    resourceProvider: resourceProvider ??= PhysicalResourceProvider.INSTANCE,
  );
  return collection.contexts.single;
}
