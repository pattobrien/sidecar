import 'package:riverpod/riverpod.dart';

import '../context/context.dart';
import '../plugin/plugin.dart';
import '../visitors/annotation_visitor.dart';
import 'resolved_unit_provider.dart';
import 'sidecar_annotated_node.dart';

final annotationsProvider =
    Provider.family<List<SidecarAnnotatedNode>, ActiveContextRoot>(
  (ref, activeRoot) {
    final context = ref.watch(activeContextForRootProvider(activeRoot));
    final files = context.activeRoot.typedAnalyzedFiles();
    return files
        .map<List<SidecarAnnotatedNode>>((file) {
          final unit = ref.watch(resolvedUnitProvider(file)).valueOrNull;
          if (unit == null) return [];
          final visitor = AnnotationVisitor();
          unit.unit.accept(visitor);
          return visitor.annotatedNodes;
        })
        .expand((e) => e)
        .toList();
  },
  name: 'annotationsProvider',
  dependencies: [
    resolvedUnitProvider,
    activeContextForRootProvider,
  ],
);
