import 'package:analyzer/dart/ast/ast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sidecar_annotations/sidecar_annotations.dart';

part 'sidecar_annotated_node.freezed.dart';

@freezed
class SidecarAnnotatedNode with _$SidecarAnnotatedNode {
  const factory SidecarAnnotatedNode({
    required AnnotatedNode annotatedNode,
    required SidecarInput input,
  }) = _SidecarAnnotatedNode;
  const SidecarAnnotatedNode._();
}
