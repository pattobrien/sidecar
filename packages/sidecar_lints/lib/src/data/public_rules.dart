import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as p;
import 'package:sidecar/sidecar.dart';

import '../constants.dart';

const kPublicRulesCode = DataCode('public_rules', package: kPackageName);

class PublicRules extends DataRule {
  @override
  DataCode get code => kPublicRulesCode;

  @override
  void initializeVisitor(NodeRegistry registry) {
    registry.addCompilationUnit(this);
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    final packageRoot = context.currentSession.analysisContext.contextRoot.root;
    final packageName = packageRoot.shortName;
    final importLibrary =
        packageRoot.toUri().resolve(p.join('lib', '$packageName.dart'));

    // only analyze lib/<package_name>.dart file; otherwise, exit
    if (unit.path != importLibrary.path) return;

    final classes = <ClassElement>[
      ...unit.libraryElement.exportedLibraries
          .map((e) => e.definingCompilationUnit.classes)
          .expand((element) => element)
    ];
    reportData(classes);
    super.visitCompilationUnit(node);
  }
}
