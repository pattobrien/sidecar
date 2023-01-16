/* SNIPPET START */
import 'package:analyzer/dart/element/element.dart';
import 'package:glob/glob.dart';
import 'package:sidecar/sidecar.dart';
import 'package:analyzer/dart/ast/ast.dart';

class BlocOutsideControllerLayer extends LintRule {
  static const _id = 'bloc_outside_controller_layer';
  static const _package = 'bloc_feature_structure';
  static const _message = 'Logic should only be created in application folders';

  @override
  LintCode get code => const LintCode(_id, package: _package);
  /* SKIP */

  @override
  void initializeVisitor(NodeRegistry registry) => registry
    ..addCompilationUnit(this)
    ..addClassDeclaration(this);
  /* SKIP END */

  @override
  void visitCompilationUnit(CompilationUnit node) {
    if (applicationFolderGlob.matches(unit.path)) return;
    final imports = node.directives.whereType<ImportDirective>();
    final uris =
        imports.map((i) => i.element2?.uri).whereType<DirectiveUriWithSource>();
    final blocUris = uris
        .where((element) => element.relativeUri.pathSegments.first == 'bloc');
    if (blocUris.isNotEmpty) hasBlocImport = true;
  }

  bool hasBlocImport = false;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (!hasBlocImport) return;
    if (!blocBase.isAssignableFromType(node.declaredElement2?.thisType)) return;

    reportAstNode(node.name, message: _message);
  }
}

/* SNIPPET END */

final blocBase = TypeChecker.fromName('BlocBase', packageName: 'bloc');
final applicationFolderGlob = Glob('**/features/**/application/**');
