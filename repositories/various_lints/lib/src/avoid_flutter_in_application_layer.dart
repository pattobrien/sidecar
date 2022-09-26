import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:sidecar/sidecar.dart';
import 'package:path/path.dart' as p;

import 'utils.dart';

class AvoidFlutterInApplicationLayer extends LintRule {
  @override
  String get code => 'avoid_flutter_in_application_layer';

  @override
  String get packageName => 'various_lints';

  @override
  LintRuleType get defaultType => LintRuleType.error;

  @override
  Future<List<DetectedLint>> computeGenericAnalysisError(
    AnalysisContext analysisContext,
    String path,
  ) async {
    final rootDirectory = analysisContext.contextRoot.root;
    final isApplicationLayer = isPathApplicationLayer(rootDirectory.path, path);
    if (isApplicationLayer) {
      final unit = await analysisContext.currentSession.getResolvedUnit(path);
      if (unit is! ResolvedUnitResult) return [];

      final importNodes = unit.unit.directives.whereType<ImportDirective>();

      // final visitor = _LibraryVisitor();
      // final flutterBasedImports =
      //     importNodes.where((e) => e.element2!.accept(visitor) == true);

      // TODO: proper way to find flutter imports
      final flutterBasedImports = importNodes.where(
          (element) => element.uri.stringValue?.contains('flutter') ?? false);
      return flutterBasedImports.toList().toDetectedLints(unit, this,
          message: 'Avoid using UI code in your application layer.');
    } else {
      return [];
    }
  }

  @override
  SourceSpan computeLintHighlight(DetectedLint lint) {
    final node = lint.sourceSpan.toAstNode(lint.unit);
    if (node is ImportDirective) {
      return node.uri.toSourceSpan(lint.unit);
    }
    return super.computeLintHighlight(lint);
  }
}

/// Checks if the given import directive imports flutter libraries
class _LibraryVisitor extends GeneralizingElementVisitor<bool> {
  final List<String> imports = [];
  @override
  bool? visitLibraryExportElement(LibraryExportElement element) {
    if (element.exportedLibrary?.isDartAsync != null) {
      if (element.exportedLibrary!.isDartAsync) {
        imports.add(element.library.name);
        return true;
      }
      if (element.exportedLibrary!.libraryImports
          .any((element) => element.importedLibrary?.isDartAsync ?? false)) {
        imports.add(element.library.name);
        return true;
      }
    }
    return super.visitLibraryExportElement(element);
  }

  @override
  bool? visitLibraryImportElement(LibraryImportElement element) {
    if (element.importedLibrary?.isDartAsync != null) {
      if (element.importedLibrary!.isDartAsync) {
        imports.add(element.library.name);
        return true;
      }
    }

    return super.visitLibraryImportElement(element);
  }

  @override
  bool? visitLibraryElement(LibraryElement element) {
    if (element.importedLibraries.any((library) => library.isDartAsync)) {
      imports.add(element.library.name);
      return true;
    }
    if (element.exportedLibraries.any((library) => library.isDartAsync)) {
      imports.add(element.library.name);
      return true;
    }
    return super.visitLibraryElement(element);
  }
}
