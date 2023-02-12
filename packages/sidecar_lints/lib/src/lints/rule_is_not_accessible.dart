import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as p;
import 'package:sidecar/sidecar.dart';

import '../constants.dart';
import '../utils.dart';

class RuleIsNotAccessible extends LintRule {
  static const id = 'rule_is_not_accessible';
  static const message = 'Rule is not accessible from public API';

  @override
  LintCode get code => const LintCode(id, package: kPackageName);

  @override
  LintSeverity get defaultSeverity => LintSeverity.warning;

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addCompilationUnit(this);
    registry.addClassDeclaration(this);
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    // check if this unit is <package>/<package>.dart
    final path = unit.path;
    final targetRoot = context.currentSession.analysisContext.contextRoot;
    final packageName = targetRoot.root.shortName;
    targetRoot.workspace;
    final expectedPath = p.join(
        targetRoot.root.toUri().toFilePath(), 'lib', '$packageName.dart');
    if (path == expectedPath) {
      // get all exported class names and save to variable declaredClasses
      final classes = unit.libraryElement.exportedLibraries
          .map((e) => e.topLevelElements)
          .expand((element) => element)
          .whereType<ClassElement>();

      declaredClasses = classes.map((e) => e.name).whereNotNull().toList();
      declaredClasses = declaredClasses;
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (!isSidecarRule(node)) return;

    final className = node.name.lexeme;

    // dont do anything if our declared classes have not been initiated yet
    // this is a bit hacky, but should work for most use cases
    if (declaredClasses == null) return;

    if (declaredClasses!.any((clazz) => clazz == className)) return;

    reportLint(node.name, message: message);
  }
}

List<String>? declaredClasses;
