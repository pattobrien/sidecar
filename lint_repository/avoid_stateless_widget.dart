import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:collection/collection.dart';

import 'package:sidecar/sidecar.dart';

class AvoidStatelessWidget extends LintError {
  AvoidStatelessWidget(super.ref);

  @override
  String get code => 'avoid_stateless_widgets';

  @override
  LintErrorType get defaultType => LintErrorType.info;

  @override
  String get message => 'Prefer to use ConsumerWidget.';

  @override
  Map get yamlConfig => {};
  @override
  void registerNodeProcessors(NodeLintRegistry registry) {
    final visitor = _Visitor(this);
    registry.addClassDeclaration(this, visitor);
  }

  @override
  Future<List<PrioritizedSourceChange>> computeFixes(
    ReportedLintError reportedLintError,
  ) async {
    final unit = reportedLintError.sourceUnit;
    final sourceSpan = reportedLintError.sourceSpan;

    final classAstNode = sourceSpan.toAstNode(unit);
    final changeBuilder = ChangeBuilder(session: unit.session);
    await changeBuilder.addDartFileEdit(unit.path, (fileBuilder) {
      final flutterRiverpodUri = Uri(
        scheme: 'package',
        path: 'flutter_riverpod/flutter_riverpod.dart',
      );
      fileBuilder.importLibraryElement(flutterRiverpodUri);
      if (classAstNode is ClassDeclaration) {
        final superClass = classAstNode.extendsClause!.superclass;
        final superClassSource = superClass.toSourceSpan(unit);

        fileBuilder.addReplacement(
          superClassSource.toSourceRange(),
          (builder) => builder.write('ConsumerWidget'),
        );

        final methodMembers =
            classAstNode.members.whereType<MethodDeclaration>();
        // Logger.logLine('# O BUILD METHODS: ${methodMembers.length}');
        final buildFunction = methodMembers
            .firstWhereOrNull((element) => element.name.name == 'build');
        final paramOffset = buildFunction?.parameters?.rightParenthesis.offset;
        if (paramOffset != null) {
          fileBuilder.addInsertion(
            paramOffset,
            (builder) => builder.write(', WidgetRef ref'),
          );
        }
      }
      //
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
      lintRule.reportedAstNode(node.name);
    }

    return super.visitClassDeclaration(node);
  }
}
