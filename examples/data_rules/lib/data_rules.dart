import 'package:sidecar/sidecar.dart';
import 'package:analyzer/dart/ast/ast.dart';

class SomeDataRule extends DataRule {
  @override
  DataCode get code => const DataCode('some_data_rule', package: 'data_rules');

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addSimpleStringLiteral(this);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    reportData(MyData(node, node.stringValue));
    super.visitSimpleStringLiteral(node);
  }
}

class MyData {
  const MyData(
    this.node,
    this.total,
  );

  final AstNode node;
  final String? total;
}

class SomeLintRule extends LintRule with QuickFix {
  @override
  LintCode get code => const LintCode('some_lint_rule', package: 'data_rules');

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addSimpleStringLiteral(this);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    final data = context.data;
    reportAstNode(node, message: 'test lint: ${data.length}',
        editsComputer: () async {
      return [
        EditResult(message: 'test quick fix', sourceChanges: [
          SourceFileEdit(filePath: unit.path, edits: [
            SourceEdit(
                originalSourceSpan: node.toSourceSpan(unit),
                replacement: 'replacement')
          ])
        ])
      ];
    });
    // reportAstNode(node, message: 'test lint: ');
  }
}

class SomeAssistRule extends AssistRule {
  @override
  AssistCode get code =>
      const AssistCode('some_assist_rule', package: 'data_rules');

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addCompilationUnit(this);
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    reportAssistForNode(node, editsComputer: () async {
      return [
        EditResult(message: 'test quick assist', sourceChanges: [
          SourceFileEdit(
            filePath: unit.path,
            edits: [
              SourceEdit(
                  originalSourceSpan: node.toSourceSpan(unit),
                  replacement: 'replacement')
            ],
          )
        ])
      ];
    });
    // reportAstNode(node, message: 'test lint: ');
  }
}
