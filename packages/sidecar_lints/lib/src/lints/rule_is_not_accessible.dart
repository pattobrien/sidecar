import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/resolver/scope.dart';
import 'package:path/path.dart';
import 'package:sidecar/sidecar.dart';

import '../constants.dart';
import '../utils.dart';

class RuleIsNotAccessible extends LintRule {
  static const _id = 'rule_is_not_accessible';

  @override
  LintCode get code => const LintCode(_id, package: kPackageName);

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;

  @override
  void initializeVisitor(NodeRegistry registry) {
    // registry.addCompilationUnit(this);
    registry.addClassDeclaration(this);
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    final root = unit.session.analysisContext.contextRoot.root;
    final packageName = root.shortName;
    final packageLibFile =
        root.toUri().resolve(join('lib', '$packageName.dart'));
    if (unit.path == packageLibFile.path) {
      final allDeclarations = <ClassDeclaration>[];
      final localDeclarations = node.declarations.whereType<ClassDeclaration>();
      allDeclarations.addAll(localDeclarations);

      final exports = node.directives.whereType<ExportDirective>();
      for (final export in exports) {
        final exportNamespace = NamespaceBuilder()
            .createExportNamespaceForDirective(export.element2!);
        exportNamespace.definedNames.values
            .whereType<ClassElement>()
            .map((e) => e.declaration);
        print('');
      }
    }
    super.visitCompilationUnit(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) async {
    if (!isSidecarRule(node)) return;
    final root = unit.session.analysisContext.contextRoot.root;
    final packageName = root.shortName;
    final packageLibFile =
        root.toUri().resolve(join('lib', '$packageName.dart'));

    final libUnit = await unit.session.getResolvedUnit(packageLibFile.path);
    if (libUnit is! ResolvedUnitResult) return;
    libUnit.libraryElement;
  }
}
