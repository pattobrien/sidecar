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

  /* SKIP END */
  @override
  void visitCompilationUnit(CompilationUnit node) {
    final applicationFolderGlob = Glob('**/features/**/application/**');
    isApplicationFile = applicationFolderGlob.matches(unit.path);
  }

  late final bool isApplicationFile;

  @override
  void initializeVisitor(NodeRegistry registry) =>
      registry.addCompilationUnit(this);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // skip any files within an `application` folder
    if (isApplicationFile) return;

    // TODO: check if declaration is a bloc class
  }
}

/* SNIPPET END */