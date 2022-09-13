import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:sidecar/sidecar.dart';
import 'package:path/path.dart' as p;

import 'utils/utils.dart';

const _desc =
    r'Prefer an 8-digit hexadecimal integer(0xFFFFFFFF) to instantiate Color.';

class UseFullHexValuesForFlutterColors extends LintRule {
  UseFullHexValuesForFlutterColors(super.ref);

  @override
  String get code => 'use_full_hex_values_for_flutter_colors';

  @override
  String get packageName => 'flutter_lints';

  @override
  String get message => _desc;

  @override
  String? get url =>
      'https://dart-lang.github.io/linter/lints/use_full_hex_values_for_flutter_colors.html';

  @override
  Future<List<DetectedLint>> computeAnalysisError(
    AnalysisContext analysisContext,
    String path,
  ) async {
    final visitor = _Visitor();
    final rootDirectory = analysisContext.contextRoot.root;
    final relativePath = p.relative(path, from: rootDirectory.path);
    final isIncluded = analysisContext.sidecarOptions.includes(relativePath);

    if (!isIncluded) return [];

    final unit = await analysisContext.currentSession.getResolvedUnit(path);
    if (unit is! ResolvedUnitResult) return [];

    unit.unit.accept(visitor);
    return visitor.nodes.toDetectedLints(unit, this);
  }

  @override
  SourceSpan computeLintHighlight(DetectedLint lint) {
    return lint.sourceSpan;
  }

  @override
  Future<List<PrioritizedSourceChange>> computeCodeEdits(
      DetectedLint lint) async {
    // TODO: implement computeCodeEdits
    final changeBuilder = ChangeBuilder(session: lint.unit.session);
    await changeBuilder.addDartFileEdit(lint.unit.path, (builder) {
      builder.addInsertion(lint.unit.unit.length, (builder) {
        builder.writeln('// test');
      });
    });
    return <PrioritizedSourceChange>[
      PrioritizedSourceChange(0, changeBuilder.sourceChange..message = 'test'),
    ];
  }
  // @override
  // void registerNodeProcessors(NodeLintRegistry registry) {
  //   final visitor = _Visitor(this);
  //   registry.addInstanceCreationExpression(this, visitor);
  // }
}

class _Visitor extends GeneralizingAstVisitor {
  final List<AstNode> nodes = [];

  _Visitor();

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    var element = node.constructorName.staticElement;
    if (element != null &&
        element.isSameAs(
            uri: 'dart.ui', className: 'Color', constructorName: '')) {
      var arguments = node.argumentList.arguments;
      if (arguments.isNotEmpty) {
        var argument = arguments.first;
        if (argument is IntegerLiteral) {
          var value = argument.literal.lexeme.toLowerCase();
          if (!value.startsWith('0x') || value.length != 10) {
            // rule.reportAstNode(argument);
            nodes.add(argument);
          }
        }
      }
    }
    super.visitInstanceCreationExpression(node);
  }
}
