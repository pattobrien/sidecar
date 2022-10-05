import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:sidecar_annotations/sidecar_annotations.dart';

import '../../builder.dart';

mixin AnnotationSubscriber on SidecarBase {
  late List<SidecarAnnotatedNode> _annotatedNodes;

  @override
  List<SidecarAnnotatedNode> get annotatedNodes => _annotatedNodes;

  List<SidecarInput> get subscribedAnnotations;

  @override
  void update({
    List<SidecarAnnotatedNode> annotatedNodes = const [],
  }) {
    return super.update(annotatedNodes: annotatedNodes);
  }

  void subscribe() {
    ref.listen<List<SidecarAnnotatedNode>>(
        sidecarAnnotatedNodeProvider.select((value) => value
            .where((node) => subscribedAnnotations.any(
                (subscribedAnnotation) => node.input == subscribedAnnotation))
            .toList()), (previous, next) {
      //
    });
  }
}

final sidecarAnnotatedNodeProvider =
    Provider<List<SidecarAnnotatedNode>>((ref) => throw UnimplementedError());
