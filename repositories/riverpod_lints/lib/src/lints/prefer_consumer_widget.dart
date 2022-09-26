import 'dart:async';

import 'package:collection/collection.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';
import 'package:sidecar/sidecar.dart';

class PreferConsumerWidget extends LintRule {
  @override
  String get code => 'prefer_consumer_widget';

  @override
  String get packageName => 'riverpod_lints';

  @override
  TestConfig get configuration => super.configuration as TestConfig;

  @override
  MapDecoder? get jsonDecoder => TestConfig.fromJson;

  @override
  FutureOr<List<DetectedLint>> computeDartAnalysisError(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor<dynamic>();
    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(unit, this,
        message: 'Prefer to use ConsumerWidget over StatelessWidget.');
  }

  @override
  SourceSpan computeLintHighlight(DetectedLint lint) {
    final node = lint.sourceSpan.toAstNode(lint.unit);

    if (node is! ClassDeclaration) {
      return lint.sourceSpan;
    } else {
      final superclass = node.extendsClause?.superclass;

      if (superclass == null) return lint.sourceSpan;

      return superclass.toSourceSpan(lint.unit);
    }
  }

  @override
  Future<List<PrioritizedSourceChange>> computeCodeEdits(
    DetectedLint lint,
  ) async {
    final unit = lint.unit;
    final lintedNode = lint.sourceSpan.toAstNode(unit);

    final changeBuilder = ChangeBuilder(session: unit.session);
    await changeBuilder.addDartFileEdit(unit.path, (fileBuilder) {
      fileBuilder.importFlutterRiverpod();
      if (lintedNode is ClassDeclaration) {
        final superClass = lintedNode.extendsClause!.superclass;

        fileBuilder.addReplacement(
          superClass.toSourceRange(unit),
          (builder) => builder.write('ConsumerWidget'),
        );

        final buildFunction = lintedNode.members
            .whereType<MethodDeclaration>()
            .firstWhereOrNull((method) => method.name2.lexeme == 'build');

        final paramOffset = buildFunction?.parameters?.rightParenthesis.offset;
        if (paramOffset != null) {
          fileBuilder.addInsertion(
            paramOffset,
            (builder) => builder.write(', WidgetRef ref'),
          );
        }
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
  _Visitor();

  final List<AstNode> nodes = [];

  @override
  R? visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause?.superclass.name;

    if (superclass?.name == 'StatelessWidget') {
      // lintRule.reportedAstNode(node.extendsClause?.superclass);
      nodes.add(node.extendsClause!.superclass);
    }

    return super.visitClassDeclaration(node);
  }
}

class TestConfig {
  const TestConfig({required this.someProperty});

  final String someProperty;

  factory TestConfig.fromJson(Map map) {
    // try {
    return TestConfig(someProperty: map['some_property']);
    // } catch(e) {
    //  throw StateError('invalid configuration');
    // }
  }
}
