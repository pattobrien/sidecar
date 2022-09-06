// ignore_for_file: public_member_api_docs

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:collection/collection.dart';

import 'package:sidecar/sidecar.dart';

class RiverpodPreferConsumerWidget extends LintError {
  RiverpodPreferConsumerWidget(super.ref);

  @override
  String get code => 'riverpod_prefer_consumer_widget';

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
  Future<List<PrioritizedSourceChange>> computeFixes(
    ReportedLintError reportedLintError,
  ) async {
    final unit = reportedLintError.sourceUnit;
    final node = reportedLintError.sourceNode;

    final changeBuilder = ChangeBuilder(session: unit.session);
    await changeBuilder.addDartFileEdit(unit.path, (fileBuilder) {
      final flutterRiverpodUri = Uri(
        scheme: 'package',
        path: 'flutter_riverpod/flutter_riverpod.dart',
      );
      fileBuilder.importLibraryElement(flutterRiverpodUri);
      if (node is ClassDeclaration) {
        final superClass = node.extendsClause!.superclass;
        final superClassSource = superClass.toSourceSpan(unit);

        fileBuilder.addReplacement(
          superClassSource.toSourceRange(),
          (builder) => builder.write('ConsumerWidget'),
        );

        final methodMembers = node.members.whereType<MethodDeclaration>();
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
      lintRule.reportedAstNode(node);
    }

    return super.visitClassDeclaration(node);
  }
}
