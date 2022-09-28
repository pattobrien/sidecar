import 'dart:async';

import 'package:l10n_lints/src/constants.dart';
import 'package:sidecar/builder.dart';
import 'package:sidecar/sidecar.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:intl_utilities/intl_utilities.dart';

class AvoidStringLiterals extends LintRule {
  @override
  String get code => 'avoid_string_literals';

  @override
  String get packageName => l10nLintsPackageId;

  @override
  String? get url => l10nLintsUrl;

  @override
  AvoidStringLiteralsConfig get configuration =>
      super.configuration as AvoidStringLiteralsConfig;

  @override
  MapDecoder get jsonDecoder => AvoidStringLiteralsConfig.fromJson;

  @override
  FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _LiteralAstVisitor();
    visitor.initializeVisitor(this, unit);
    unit.unit.accept(visitor);
    return visitor.nodes;
  }

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisResult result,
  ) async {
    result as DartAnalysisResult;
    final unit = result.unit;

    final changeBuilder = ChangeBuilder(session: unit.session);

    final stringNode = result.sourceSpan.toAstNode(unit);

    if (stringNode == null) return [];

    //TODO: dynamically compute stringId value
    final computedStringId = 'string123';

    final arbClassPrefix = '${configuration.prefix}.$computedStringId';

    var references = <SourceSpan>[];
    final parentNode = stringNode.parent;

    if (parentNode is VariableDeclaration) {
      final element = parentNode.declaredElement2;
      if (element != null) {
        final analysisUtils = ref.read(analysisContextUtilitiesProvider);
        references = await analysisUtils.getReferences(unit, element);
      }
    }

    // we dont want to replace a string if not every variable reference
    // will have access to it
    final areAllReferencesWithinBuildMethods = references.every((reference) {
      final node = reference.toAstNode(unit);
      return node!.isInsideBuildMethod();
    });

    if (areAllReferencesWithinBuildMethods && references.isNotEmpty) {
      final expression = stringNode.parent?.parent?.parent;
      await changeBuilder.addDartFileEdit(unit.path, (builder) {
        builder.importFlutterGenAppLocalizations();
        builder.addDeletion(expression!.toSourceRange(unit));
      });

      await Future.wait(references.map((reference) async {
        final node = reference.toAstNode(unit);
        if (node!.isInsideBuildMethod()) {
          await changeBuilder.addDartFileEdit(
            reference.sourceUrl!.path,
            (fileBuilder) => fileBuilder.addReplacement(
              reference.toSourceRange(),
              (editBuilder) => editBuilder.write(arbClassPrefix),
            ),
          );
        }
      }));
    }

    if (parentNode is ArgumentList) {
      await changeBuilder.addDartFileEdit(unit.path, (builder) {
        if (stringNode.isInsideBuildMethod()) {
          builder.importFlutterGenAppLocalizations();
          builder.addReplacement(
            stringNode.toSourceRange(unit),
            (editBuilder) => editBuilder.write(arbClassPrefix),
          );
        }
      });
    }
    if (changeBuilder.sourceChange.edits.isNotEmpty) {
      final errorFixes = [
        EditResult(
          message: 'Extract string declaration',
          sourceChanges: changeBuilder.sourceChange.edits,
        ),
        // PrioritizedSourceChange(
        //   0,
        //   changeBuilder.sourceChange..message = 'Extract string declaration',
        // ),
      ];
      return errorFixes;
    } else {
      return [];
    }
  }
}

class _LiteralAstVisitor extends SidecarAstVisitor {
  @override
  void visitStringLiteral(StringLiteral node) {
    if (node.parent is! ImportDirective &&
        node is! PartDirective &&
        node is! PartOfDirective) {
      reportAstNode(node,
          message:
              '\${STRING_GOES_HERE} should be extracted to an ARB or ENV file.');
    }

    super.visitStringLiteral(node);
  }
}

class AvoidStringLiteralsConfig {
  const AvoidStringLiteralsConfig({
    required this.prefix,
  });

  final String prefix;

  factory AvoidStringLiteralsConfig.fromJson(Map json) {
    return AvoidStringLiteralsConfig(prefix: json['prefix']);
  }
}
