// ignore_for_file: implementation_imports
import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:analyzer/src/dart/ast/utilities.dart';
import 'package:analyzer/src/dart/micro/utils.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod/riverpod.dart';
import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../configurations/project/errors.dart';
import '../configurations/project/project_configuration.dart';
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
  SourceSpan sidecarPackageSourceSpan(String packageId) {
    final optionsFile = contextRoot.optionsFile;
    if (optionsFile != null) {
      final contents = optionsFile.readAsStringSync();
      try {
        final uri = optionsFile.toUri();
        final doc = loadYamlNode(contents, sourceUrl: uri) as YamlMap;

        final sidecar = doc.nodes['sidecar']! as YamlMap;

        final lints = sidecar.nodes['lints']! as YamlMap;

        final myPackage = lints.nodes.entries
            .firstWhere((entry) => entry.key.toString() == packageId)
            .key as YamlScalar;

        final packageSource = myPackage.span;
        final startOffset = packageSource.start.offset;
        final endOffset = packageSource.end.offset;

        final lineInfo = LineInfo.fromContent(contents);
        final startLocation = lineInfo.getLocation(startOffset);
        final endLocation = lineInfo.getLocation(endOffset);
        final sourceSpan = SourceSpan(
          SourceLocation(
            startOffset,
            column: startLocation.columnNumber,
            line: startLocation.lineNumber,
            sourceUrl: uri,
          ),
          SourceLocation(
            endOffset,
            column: endLocation.columnNumber,
            line: endLocation.lineNumber,
            sourceUrl: uri,
          ),
          contents.substring(startOffset, endOffset),
        );

        return sourceSpan;
      } catch (e) {
        throw UnimplementedError('cannot parse sidecar options: $e');
      }
    } else {
      throw UnimplementedError('yaml options file doesnt exist');
    }
  }

  SourceSpan sidecarLintSourceSpan(String packageId, String lintId) {
    final optionsFile = contextRoot.optionsFile;
    if (optionsFile != null) {
      final contents = optionsFile.readAsStringSync();
      try {
        final uri = optionsFile.toUri();
        final doc = loadYamlNode(contents, sourceUrl: uri) as YamlMap;

        final sidecar = doc.nodes['sidecar']! as YamlMap;

        final packages = sidecar.nodes['lints']! as YamlMap;

        final lints = packages.nodes[packageId]! as YamlMap;

        final myLintKey = lints.nodes.entries
            .firstWhere((entry) => entry.key.toString() == lintId)
            .key as YamlScalar;

        final startOffset = myLintKey.span.start.offset;
        final endOffset = myLintKey.span.end.offset;

        final lineInfo = LineInfo.fromContent(contents);
        final startLocation = lineInfo.getLocation(startOffset);
        final endLocation = lineInfo.getLocation(endOffset);
        final sourceSpan = SourceSpan(
          SourceLocation(
            startOffset,
            column: startLocation.columnNumber,
            line: startLocation.lineNumber,
            sourceUrl: uri,
          ),
          SourceLocation(
            endOffset,
            column: endLocation.columnNumber,
            line: endLocation.lineNumber,
            sourceUrl: uri,
          ),
          contents.substring(startOffset, endOffset),
        );
        return sourceSpan;
      } catch (e) {
        throw UnimplementedError('cannot parse sidecar options: $e');
      }
    } else {
      throw UnimplementedError('yaml options file doesnt exist');
    }
  }

  // ProjectConfiguration get sidecarOptions {
  //   final optionsFile = contextRoot.optionsFile;
  //   if (optionsFile != null) {
  //     final contents = optionsFile.readAsStringSync();
  //     try {
  //       return ProjectConfiguration.parse(contents);
  //       // } on MissingSidecarConfiguration catch (e) {
  //       //   print(e.toString());
  //     } catch (e) {
  //       throw UnimplementedError('cannot parse sidecar options: $e');
  //     }
  //   } else {
  //     return const ProjectConfiguration();
  //   }
  // }

  bool get isSidecarEnabled => analysisOptions.enabledPluginNames
      .where((pluginName) => pluginName == 'sidecar_analyzer_plugin')
      .toList()
      .isNotEmpty;
}
