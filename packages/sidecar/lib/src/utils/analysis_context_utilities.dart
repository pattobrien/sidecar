// ignore_for_file: implementation_imports
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer/src/dart/micro/utils.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:source_span/source_span.dart';

import '../protocol/constants/constants.dart';
import 'syntactix_entity_utilities.dart';

class AnalysisContextUtilities {
  const AnalysisContextUtilities();

  Future<List<SourceSpan>> getReferences(
    ResolvedUnitResult unit,
    Element element,
  ) async {
    //TODO performance: only visit units that have our element's library as an import
    final context = unit.session.analysisContext;
    final session = context.currentSession;
    final libResources = session.analysisContext.contextRoot.analyzedFiles();
    final filesToVisit =
        libResources.where((element) => p.extension(element) == '.dart');
    final visitor = ReferencesCollector(element);
    final spans = <SourceSpan>[];

    for (final filePath in filesToVisit) {
      final unit = await session.getResolvedUnit(filePath);
      if (unit is ResolvedUnitResult) {
        unit.unit.accept(visitor);
        final unfilteredMatches = visitor.references;
        // final x = ElementLocator();
        final nodeMatches = unfilteredMatches
            .map((e) => NodeLocator(e.offset, e.offset + e.length)
                .searchWithin(unit.unit))
            .whereType<AstNode>();

        final sourceSpans = nodeMatches.map((e) => e.toSourceSpan(unit));

        spans.addAll(sourceSpans);
      } else {}
    }
    return spans;
  }
}

final analysisContextUtilitiesProvider = Provider<AnalysisContextUtilities>(
  (ref) => const AnalysisContextUtilities(),
);

extension AnalysisContextX on AnalysisContext {
  bool get isSidecarEnabled => analysisOptions.enabledPluginNames
      .where((pluginName) => pluginName == kSidecarPluginName)
      .toList()
      .isNotEmpty;
}

extension AnalysisContextsX on List<AnalysisContext> {
  AnalysisContext? contextForPath(String path) {
    return firstWhereOrNull((context) => context.contextRoot
        .analyzedFiles()
        .any((filePath) => filePath == path));
  }

  AnalysisContext? contextForRoot(Uri root) {
    return firstWhereOrNull((context) {
      final contextRoot = context.contextRoot.root.toUri();
      return contextRoot == root;
    });
  }

  // Context? contextRootForPath(String path) {
  //   final analysisContext = firstWhereOrNull((context) => context.contextRoot
  //       .analyzedFiles()
  //       .any((filePath) => filePath == path));
  //   if (analysisContext == null) return null;
  //   return Context(root: analysisContext.contextRoot.root.toUri());
  // }
}
