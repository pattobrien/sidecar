import 'dart:async';

import 'package:collection/collection.dart';
import 'package:riverpod_utilities/riverpod_utilities.dart';
import 'package:sidecar/builder.dart';

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
  FutureOr<List<DartAnalysisResult>> computeDartAnalysisResults(
    ResolvedUnitResult unit,
  ) {
    final visitor = _Visitor(this, unit);
    unit.unit.accept(visitor);
    return visitor.results;
  }

  @override
  Future<List<EditResult>> computeSourceChanges(
    AnalysisResult result,
  ) async {
    final res = result as DartAnalysisResult;
    final unit = res.unit;
    final lintedNode = res.sourceSpan.toAstNode(unit);

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
      EditResult(
        message: 'Replace with ConsumerWidget',
        sourceChanges: changeBuilder.sourceChange.edits,
      ),
    ];
  }
}

class _Visitor extends GeneralizingAstVisitor<void> {
  _Visitor(this.sidecarBase, this.unit);

  final List<DartAnalysisResult> results = [];
  final SidecarBase sidecarBase;
  final ResolvedUnitResult unit;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final superclass = node.extendsClause?.superclass;

    if (superclass?.name.name == 'StatelessWidget') {
      final result = superclass!.toDartAnalysisResult(
        sidecarBase,
        unit: unit,
        message: 'Prefer to use ConsumerWidget over StatelessWidget',
      );

      results.add(result);
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
