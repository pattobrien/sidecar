import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:riverpod/riverpod.dart';

import 'package:sidecar/builder.dart';
import 'package:sidecar_annotations/sidecar_annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../../context_services/analysis_errors.dart';
import '../../services/log_delegate/log_delegate_base.dart';
import '../../services/resolved_unit_service/resolved_unit_service.dart';
import '../../utils/utils.dart';

final annotationsAggregateProvider =
    Provider.family<List<SidecarAnnotatedNode>, ContextRoot>(
        (ref, contextRoot) {
  return contextRoot
      .analyzedFiles()
      .map((path) {
        final analyzedFile = AnalyzedFile(contextRoot, path);

        ref.read(logDelegateProvider).sidecarVerboseMessage(
            'annotations refresh: ${analyzedFile.relativePath} - ${analyzedFile.isDartFile}');

        return ref.watch(annotationsNotifierProvider(analyzedFile)).value ?? [];
      })
      .expand((element) => element)
      .toList();
});

final annotationsNotifierProvider = StateNotifierProvider.family<
    FileAnnotationsNotifier,
    AsyncValue<List<SidecarAnnotatedNode>>,
    AnalyzedFile>((ref, analyzedFile) {
  final notifier = FileAnnotationsNotifier(ref, analyzedFile: analyzedFile);
  ref.listen(
    resolvedUnitProvider(analyzedFile),
    (previous, next) {
      ref.read(logDelegateProvider).sidecarVerboseMessage(
          'unit updated, refreshing annotations: ${analyzedFile.relativePath}');
      notifier.refresh();
    },
  );
  return notifier;
});

class FileAnnotationsNotifier
    extends StateNotifier<AsyncValue<List<SidecarAnnotatedNode>>> {
  FileAnnotationsNotifier(
    this.ref, {
    required this.analyzedFile,
  }) : super(const AsyncValue.loading());

  final Ref ref;
  final AnalyzedFile analyzedFile;

  void refresh() {
    final visitor = _AnnotationVisitor();
    final unitResult = ref.read(resolvedUnitProvider(analyzedFile)).value;
    if (unitResult == null) return;
    unitResult.unit.accept(visitor);
    final annotations = visitor.annotatedNodes;
    state = AsyncValue.data(annotations);
  }
}

class _AnnotationVisitor extends GeneralizingAstVisitor<void> {
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
