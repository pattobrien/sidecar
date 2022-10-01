import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sidecar/builder.dart';

import '../../services/resolved_unit_service/resolved_unit_service.dart';
import '../../context_services/analysis_errors.dart';
import '../../utils/annotation_utils.dart';

final annotationsAggregateProvider =
    Provider.family<List<AnnotatedNode>, ContextRoot>((ref, contextRoot) {
  return contextRoot
      .analyzedFiles()
      .map((path) {
        final analyzedFile = AnalyzedFile(contextRoot, path);
        return ref.watch(annotationsNotifierProvider(analyzedFile)).value ?? [];
      })
      .expand((element) => element)
      .toList();
});

final annotationsNotifierProvider = StateNotifierProvider.family<
    FileAnnotationsNotifier,
    AsyncValue<List<AnnotatedNode>>,
    AnalyzedFile>((ref, analyzedFile) {
  final unitResult = ref.watch(resolvedUnitProvider(analyzedFile)).value;
  return FileAnnotationsNotifier(
    ref,
    analyzedFile: analyzedFile,
    unitResult: unitResult,
  );
});

class FileAnnotationsNotifier
    extends StateNotifier<AsyncValue<List<AnnotatedNode>>> {
  FileAnnotationsNotifier(
    this.ref, {
    required this.analyzedFile,
    required this.unitResult,
  }) : super(AsyncValue.loading());

  final Ref ref;
  final ResolvedUnitResult? unitResult;
  final AnalyzedFile analyzedFile;

  void refresh() {
    final visitor = _AnnotationVisitor(ref);
    unitResult?.unit.accept(visitor);
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
      if (SidecarTypeChecker.isSidecarInput(obj?.type)) return true;
      return false;
    });
    for (final annotation in annotations) {
      annotatedNodes.add(node);
    }
    super.visitAnnotatedNode(node);
  }

  // @override
  // void visitAnnotation(Annotation node) {
  //   final value = node.elementAnnotation?.computeConstantValue();
  //   if (SidecarTypeChecker.isSidecarInput(value?.type)) {
  //     final sidecarInput = value!;
  //     final z = node.childEntities;
  //     // final thisOrSupers = <DartObject>[
  //     //   sidecarInput,
  //     //   ...sidecarInput.,
  //     // ];
  //     // final val = thisOrSupers.firstWhere((element) => element.comp());
  //     final x = value.getField('(super)')?.getField('configuration');

  //     final y = value.variable;
  //     // annotations.add(node.elementAnnotation!);
  //     // print('# o annos: ${annotations.length}');
  //   }
  //   super.visitAnnotation(node);
  // }
}
