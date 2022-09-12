// ignore_for_file: implementation_imports

import 'package:l10n_lints/src/constants.dart';
import 'package:sidecar/sidecar.dart';
import 'package:flutter_utilities/flutter_utilities.dart';
import 'package:intl_utilities/intl_utilities.dart';

class AvoidStringLiterals extends LintRule {
  AvoidStringLiterals(super.ref);

  @override
  String get code => 'avoid_string_literals';

  @override
  String get message => '\${STRING} should be extracted to an ARB or ENV file.';

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
  void registerNodeProcessors(NodeLintRegistry registry) {
    final visitor = _LiteralAstVisitor(this);
    registry.addSimpleStringLiteral(this, visitor);
  }

  @override
  Future<List<PrioritizedSourceChange>> computeCodeEdits(
    DetectedLint lint,
  ) async {
    final unit = lint.unit;
    final stringNode = lint.sourceSpan.toAstNode(unit);

    if (stringNode == null) return [];

    final changeBuilder = ChangeBuilder(session: unit.session);

    //TODO: dynamically compute value
    final computedStringId = 'string123';
    final prefix = configuration.prefix;

    final arbClassPrefix = '$prefix.$computedStringId';

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
        builder.addDeletion(
          expression!.toSourceSpan(unit).toSourceRange(),
        );
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
        PrioritizedSourceChange(
          0,
          changeBuilder.sourceChange..message = 'Extract string declaration',
        ),
      ];
      return errorFixes;
    } else {
      return [];
    }
  }
}

class _LiteralAstVisitor<R> extends GeneralizingAstVisitor<R> {
  _LiteralAstVisitor(this.lintRule);

  final LintRule lintRule;

  @override
  R? visitStringLiteral(StringLiteral node) {
    if (node.parent is! ImportDirective &&
        node is! PartDirective &&
        node is! PartOfDirective) {
      lintRule.reportAstNode(node);
    }

    return super.visitStringLiteral(node);
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
