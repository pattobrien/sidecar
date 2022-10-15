import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:sidecar_annotations/sidecar_annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../../utils/utils.dart';
import '../results/results.dart';

class AnnotationVisitor extends GeneralizingAstVisitor<void> {
  final List<SidecarAnnotatedNode> annotatedNodes = [];

  @override
  void visitAnnotatedNode(AnnotatedNode node) {
    final annotations = node.metadata.where((annotation) {
      final type = annotation.elementAnnotation?.computeConstantValue()?.type;
      if (type is InterfaceType) {
        final isSidecarInput = SidecarTypeChecker.isSidecarInput(type);
        return isSidecarInput;
      }
      return false;
    });
    for (final annotation in annotations) {
      final sidecarInput = annotation.computeSidecarInput();
      annotatedNodes.add(
        SidecarAnnotatedNode(annotatedNode: node, input: sidecarInput),
      );
    }
    super.visitAnnotatedNode(node);
  }
}

extension SidecarInputAnnotation on Annotation {
  SidecarInput computeSidecarInput() {
    final value = elementAnnotation!.computeConstantValue()!;
    final constantValue = ConstantReader(value);
    return SidecarInput(
      packageName: constantValue.read('packageName').literalValue! as String,
      configuration: constantValue.read('configuration').literalValue! as Map,
      lintName: constantValue.read('lintName').literalValue as String?,
    );
  }
}
