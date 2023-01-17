/* SNIPPET START */
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:glob/glob.dart';
import 'package:sidecar/sidecar.dart';

class BlocOutsideControllerLayer extends LintRule {
  // we can use variables for better code legibility
  static const _id = 'bloc_outside_controller_layer';
  static const _package = 'bloc_feature_structure';
  static const _message = 'Logic should be created in application folders.';

  @override
  LintCode get code => const LintCode(_id, package: _package);

  @override
  void visitCompilationUnit(CompilationUnit node) {
    if (applicationFolderGlob.matches(unit.path)) return;

    unitHasBlocImport = doesHaveBlocImport(node);
  }

  bool doesHaveBlocImport(CompilationUnit node) {
    final blocImports = node.directives
        .whereType<ImportDirective>()
        .map((i) => i.element2?.uri)
        .whereType<DirectiveUriWithSource>()
        .where((e) => e.relativeUri.pathSegments.first == 'bloc');
    if (blocImports.isNotEmpty) unitHasBlocImport = true;
    return false;
  }

  late bool unitHasBlocImport;

  @override
  void initializeVisitor(NodeRegistry registry) =>
      registry.addCompilationUnit(this);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (!unitHasBlocImport) return;

    final classType = node.declaredElement2?.thisType;
    if (!blocBase.isAssignableFromType(classType)) return;

    reportAstNode(node.name, message: _message);
  }
}

final applicationFolderGlob = Glob('**/features/**/application/**');
final blocBase =
    TypeChecker.fromName('BlocBase', packageName: 'bloc');
/* SNIPPET END */