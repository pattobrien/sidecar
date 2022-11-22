// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import '../../protocol/protocol.dart';
// import '../plugin/plugin.dart';
// import '../visitors/annotation_visitor.dart';
// import 'resolved_unit_provider.dart';
// import 'sidecar_annotated_node.dart';

// part 'annotations_provider.g.dart';

// @riverpod
// List<SidecarAnnotatedNode> sidecarAnnotationsForRoot(
//   SidecarAnnotationsForRootRef ref,
//   Context root,
// ) {
//   final files = ref.watch(analyzedFilesForRootProvider(root));
//   return files
//       .map<List<SidecarAnnotatedNode>>((file) {
//         final unit =
//             ref.watch(getResolvedUnitForFileProvider(file)).valueOrNull;
//         if (unit == null) return [];
//         final visitor = AnnotationVisitor();
//         unit.unit.accept(visitor);
//         return visitor.annotatedNodes;
//       })
//       .expand((e) => e)
//       .toList();
// }
