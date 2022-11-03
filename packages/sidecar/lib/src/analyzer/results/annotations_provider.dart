import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../context/context.dart';
import '../plugin/plugin.dart';
import '../visitors/annotation_visitor.dart';
import 'resolved_unit_provider.dart';
import 'sidecar_annotated_node.dart';

part 'annotations_provider.g.dart';

@riverpod
List<SidecarAnnotatedNode> sidecarAnnotationsForRoot(
  SidecarAnnotationsForRootRef ref,
  ActiveContextRoot root,
) {
  final context = ref.watch(activeContextForRootProvider(root));
  final files = context.activeRoot.typedAnalyzedFiles();
  return files
      .map<List<SidecarAnnotatedNode>>((file) {
        final unit =
            ref.watch(getResolvedUnitForFileProvider(file)).valueOrNull;
        if (unit == null) return [];
        final visitor = AnnotationVisitor();
        unit.unit.accept(visitor);
        return visitor.annotatedNodes;
      })
      .expand((e) => e)
      .toList();
}
