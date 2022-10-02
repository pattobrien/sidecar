import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../../../sidecar_analyzer_plugin_core.dart';
import '../../context_services/analysis_errors.dart';
import '../../services/log_delegate/log_delegate_base.dart';
import '../../services/resolved_unit_service/resolved_unit_service.dart';
import '../../utils/utils.dart';

final annotationsAggregateProvider =
    Provider.family<List<AnnotatedNode>, ContextRoot>((ref, contextRoot) {
  return contextRoot
      .analyzedFiles()
      .map((path) {
        final analyzedFile = AnalyzedFile(contextRoot, path);

        ref.read(pluginChannelProvider).sendError(
            'annotations refresh: ${analyzedFile.relativePath} - ${analyzedFile.isDartFile}');

        ref.read(logDelegateProvider).sidecarMessage(
            'annotations refresh: ${analyzedFile.relativePath} - ${analyzedFile.isDartFile}');

        return ref.watch(annotationsNotifierProvider(analyzedFile)).value ?? [];
      })
      .expand((element) => element)
      .toList();
});

final annotationsNotifierProvider = StateNotifierProvider.family<
    FileAnnotationsNotifier,
    AsyncValue<List<AnnotatedNode>>,
    AnalyzedFile>((ref, analyzedFile) {
  final notifier = FileAnnotationsNotifier(ref, analyzedFile: analyzedFile);
  ref.listen(
    resolvedUnitProvider(analyzedFile),
    (previous, next) {
      ref.read(logDelegateProvider).sidecarMessage(
          'unit updated, refreshing annotations: ${analyzedFile.relativePath}');
      notifier.refresh();
    },
  );
  return notifier;
});

class FileAnnotationsNotifier
    extends StateNotifier<AsyncValue<List<AnnotatedNode>>> {
  FileAnnotationsNotifier(
    this.ref, {
    required this.analyzedFile,
  }) : super(const AsyncValue.loading());

  final Ref ref;
  final AnalyzedFile analyzedFile;

  void refresh() {
    final visitor = _AnnotationVisitor(ref);
    final unitResult = ref.read(resolvedUnitProvider(analyzedFile)).value;
    if (unitResult == null) return;
    unitResult.unit.accept(visitor);
    state = AsyncValue.data(visitor.annotatedNodes);
  }
}

class _AnnotationVisitor extends GeneralizingAstVisitor<void> {
  _AnnotationVisitor(this.ref);
  final Ref ref;
  final List<AnnotatedNode> annotatedNodes = [];

  @override
  void visitAnnotatedNode(AnnotatedNode node) {
    final annotations = node.metadata.where((annotation) {
      final obj = annotation.elementAnnotation?.computeConstantValue();
      if (SidecarTypeChecker.isSidecarInput(obj?.type?.element2)) {
        return true;
      }
      return false;
    });
    for (final _ in annotations) {
      annotatedNodes.add(node);
    }
    super.visitAnnotatedNode(node);
  }
}
