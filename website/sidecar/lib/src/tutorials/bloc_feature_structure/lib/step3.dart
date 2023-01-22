/* SNIPPET START */
import 'package:analyzer/dart/ast/ast.dart';
import 'package:glob/glob.dart';
import 'package:sidecar/sidecar.dart';

class BlocOutsideControllerLayer extends LintRule {
  /* SKIP */
  // we can use variables for better code legibility
  static const _id = 'bloc_outside_controller_layer';
  static const _package = 'bloc_feature_structure';
  static const _message = 'Logic should be created in application folders.';

  @override
  LintCode get code => const LintCode(_id, package: _package);

  @override
  void visitCompilationUnit(CompilationUnit node) {
    final applicationFolderGlob = Glob('**/features/**/application/**');
    isApplicationFile = applicationFolderGlob.matches(unit.path);
  }

  late final bool isApplicationFile;

  @override
  void initializeVisitor(NodeRegistry registry) =>
      registry.addCompilationUnit(this);

  /* SKIP END */
  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // skip any files within an `application` folder
    if (isApplicationFile) return;

    final blocBase = TypeChecker.fromPackage('BlocBase', package: 'bloc');
    final classType = node.declaredElement2?.thisType;
    if (!blocBase.isAssignableFromType(classType)) return;

    reportAstNode(node.name, message: _message);
  }
}

/* SNIPPET END */