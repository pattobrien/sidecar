// ignore_for_file: implementation_imports
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer/src/dart/micro/utils.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:source_span/source_span.dart';

import 'ast_utilities.dart';

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
      .where((pluginName) => pluginName == 'sidecar_analyzer_plugin_core')
      .toList()
      .isNotEmpty;
}
