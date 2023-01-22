/* SNIP RuleImports */
import 'package:analyzer/dart/ast/ast.dart';
import 'package:sidecar/sidecar.dart';
/* SNIP RuleImports END */
/* SNIP GlobImport */
import 'package:glob/glob.dart';
/* SNIP GlobImport */

/* SNIP ClassStart */
class BlocOutsideControllerLayer extends LintRule {
  /* SNIP ClassStart END */
  /* SNIP LINTCODE */
  static const id = 'bloc_outside_controller_layer';
  static const package = 'bloc_feature_structure';
  static const message = 'Logic should be created in application folders.';

  @override
  LintCode get code => const LintCode(id, package: package);
  /* SNIP LINTCODE END */

  /* SNIP VisitCompilationUnit */
  @override
  void visitCompilationUnit(CompilationUnit node) {
    final controllersFolderGlob = Glob('**/features/**/controllers/**');
    isControllerFile = controllersFolderGlob.matches(unit.path);
  }

  /* SNIP VisitCompilationUnit END */
  /* SNIP isApplicationFile */
  late final bool isControllerFile;
  /* SNIP isApplicationFile END */

  /* SNIP initializeVisitor */
  @override
  void initializeVisitor(NodeRegistry registry) =>
      registry.addCompilationUnit(this);
  /* SNIP initializeVisitor END */

  /* SNIP visitClassDeclaration */
  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // dont perform type analysis on files inside of controller folders
    if (isControllerFile) return;

    // type check against the type of the declared class
    final classType = node.declaredElement2?.thisType;
    final blocBase = TypeChecker.fromName('BlocBase', packageName: 'bloc');
    if (!blocBase.isAssignableFromType(classType)) return;

    reportAstNode(node.name, message: message);
  }
  /* SNIP visitClassDeclaration END */
  /* SNIP CLASSEND */
} 
/* SNIP CLASSEND END */

/* SNIPPET END */
