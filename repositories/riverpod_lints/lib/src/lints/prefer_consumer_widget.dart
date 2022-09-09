// ignore_for_file: public_member_api_docs

import 'package:collection/collection.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';
import 'package:sidecar/sidecar.dart';

class PreferConsumerWidget extends LintError {
  PreferConsumerWidget(super.ref);

  @override
  String get code => 'prefer_consumer_widget';

  @override
  LintErrorType get defaultType => LintErrorType.info;

  @override
  String get message => 'Prefer to use ConsumerWidget.';

  @override
  Map get yamlConfig => <dynamic, dynamic>{};

  @override
  void registerNodeProcessors(NodeLintRegistry registry) {
    final visitor = _Visitor<dynamic>(this);
    registry.addClassDeclaration(this, visitor);
  }

  @override
  ReportedLintError computeLintHighlight(
    ReportedLintError reportedLintError,
  ) {
    final node = reportedLintError.reportedNode;
    if (node is ClassDeclaration) {
      final superclass = node.extendsClause?.superclass;
      return reportedLintError.copyWith(highlightedNode: superclass);
    }
    return reportedLintError;
  }

  @override
  Future<List<PrioritizedSourceChange>> computeFixes(
    ReportedLintError reportedLintError,
  ) async {
    final unit = reportedLintError.sourceUnit;
    final lintedNode = reportedLintError.reportedNode;

    final context = unit.session.analysisContext;
    final config = context.sidecarOptions.lintPackages?['riverpod_lints']
        ?.lints[code]?.configuration;

    final changeBuilder = ChangeBuilder(session: unit.session);
    await changeBuilder.addDartFileEdit(unit.path, (fileBuilder) {
      fileBuilder.importLibraryElement(uriFlutterRiverpod);
      if (lintedNode is ClassDeclaration) {
        final superClass = lintedNode.extendsClause!.superclass;

        fileBuilder.addReplacement(
          superClass.toSourceRange(unit),
          (builder) => builder.write('ConsumerWidget'),
        );

        final buildFunction = lintedNode.members
            .whereType<MethodDeclaration>()
            .firstWhereOrNull((method) => method.name.name == 'build');

        final paramOffset = buildFunction?.parameters?.rightParenthesis.offset;
        if (paramOffset != null) {
          fileBuilder.addInsertion(
            paramOffset,
            (builder) => builder.write(', WidgetRef ref'),
          );
        }
        fileBuilder.addInsertion(
          0,
          (builder) => builder.write('// config: $config'),
        );
      }
    });

    return [
      PrioritizedSourceChange(
        0,
        changeBuilder.sourceChange..message = 'Replace with ConsumerWidget',
      ),
    ];
  }
}

class _Visitor<R> extends GeneralizingAstVisitor<R> {
  _Visitor(this.lintRule);

  final LintError lintRule;

  @override
  R? visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause?.superclass.name;

    if (superclass?.name == 'StatelessWidget') {
      // lintRule.reportedAstNode(node.extendsClause?.superclass);
      lintRule.reportedAstNode(node);
    }

    return super.visitClassDeclaration(node);
  }
}
