import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:l10n_lints/src/constants.dart';
import 'package:sidecar/sidecar.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:source_span/source_span.dart';

class AvoidStringLiterals extends LintRule with LintVisitor, QuickFix {
  @override
  String get code => 'avoid_string_literals';

  @override
  String get packageName => l10nLintsPackageId;

  @override
  String? get url => l10nLintsUrl;

  @override
  SidecarAstVisitor Function() get visitorCreator => _Visitor.new;

  @override
  Future<List<EditResult>> computeQuickFixes(AnalysisSourceSpan source) async {
    final session = context.currentSession;
    final changeBuilder = ChangeBuilder(session: session);
    final unit =
        await session.getResolvedUnit(source.path) as ResolvedUnitResult;

    final stringNode = source.source.toAstNode(unit);

    if (stringNode == null) return [];

    //TODO: dynamically compute stringId value
    final computedStringId = 'string123';

    // final arbClassPrefix = '${configuration.prefix}.$computedStringId';
    final arbClassPrefix = 'examplePrefix';

    var references = <SourceSpan>[];
    final parentNode = stringNode.parent;

    // if (parentNode is VariableDeclaration) {
    //   final element = parentNode.declaredElement2;
    //   if (element != null) {
    //     final analysisUtils = _ref.read(analysisContextUtilitiesProvider);
    //     references = await analysisUtils.getReferences(unit, element);
    //   }
    // }

    // we dont want to replace a string if not every variable reference
    // will have access to it
    // final areAllReferencesWithinBuildMethods = references.every((reference) {
    //   final node = reference.toAstNode(unit);
    //   return node!.isInsideBuildMethod();
    // });

    // if (areAllReferencesWithinBuildMethods && references.isNotEmpty) {
    //   final expression = stringNode.parent?.parent?.parent;
    //   await changeBuilder.addDartFileEdit(unit.path, (builder) {
    //     builder.importFlutterGenAppLocalizations();
    //     builder.addDeletion(expression!.toSourceRange(unit));
    //   });

    //   await Future.wait(references.map((reference) async {
    //     final node = reference.toAstNode(unit);
    //     if (node!.isInsideBuildMethod()) {
    //       await changeBuilder.addDartFileEdit(
    //         reference.sourceUrl!.path,
    //         (fileBuilder) => fileBuilder.addReplacement(
    //           reference.toSourceRange(),
    //           (editBuilder) => editBuilder.write(arbClassPrefix),
    //         ),
    //       );
    //     }
    //   }));
    // }

    // if (parentNode is ArgumentList) {
    await changeBuilder.addDartFileEdit(unit.path, (builder) {
      // if (stringNode.isInsideBuildMethod()) {
      //   builder.importFlutterGenAppLocalizations();
      builder.addReplacement(
        stringNode.toSourceRange(unit),
        (editBuilder) => editBuilder.write(arbClassPrefix),
      );
      // }
    });
    // }
    // if (changeBuilder.sourceChange.edits.isNotEmpty) {
    final errorFixes = [
      EditResult(
        message: 'Extract string declaration',
        sourceChanges: changeBuilder.sourceChange.edits,
      ),
    ];
    return errorFixes;
    // } else {
    //   return [];
    // }
  }

  // @override
  // AvoidStringLiteralsConfig get configuration =>
  //     super.configuration as AvoidStringLiteralsConfig;

  // @override
  // MapDecoder get jsonDecoder => AvoidStringLiteralsConfig.fromJson;

  // @override
  // Future<List<EditResult>> computeSourceChanges(
  //   AnalysisSession session,
  //   AnalysisSource source,
  // ) async {

  // }
}

class _Visitor extends SidecarAstVisitor {
  @override
  void visitStringLiteral(StringLiteral node) {
    if (node.parent is! ImportDirective &&
        node is! PartDirective &&
        node is! PartOfDirective) {
      reportAstNode(
        node,
        message: 'Avoid hardcoding strings.',
        correction: 'Extract string into an .arb file instead.',
      );
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
