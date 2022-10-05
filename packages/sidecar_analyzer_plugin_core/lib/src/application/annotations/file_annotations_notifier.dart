import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:riverpod/riverpod.dart';

import 'package:sidecar/builder.dart';
import 'package:sidecar_annotations/sidecar_annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../../context_services/analyzed_file.dart';
import '../../reports/file_report_notifier.dart';
import '../../services/log_delegate/log_delegate_base.dart';
import '../../services/resolved_unit_service/resolved_unit_service.dart';
import '../../utils/utils.dart';
import '../analysis_results/file_report_provider.dart';

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
  ref.listen(resolvedUnitProvider(analyzedFile), (previous, next) {
    notifier.refresh();
  });
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

  FileReportNotifier get reporter =>
      ref.read(fileReportProvider(analyzedFile).notifier);

  void refresh() {
    reporter.recordAnnotationsStart();
    final visitor = AnnotationVisitor();
    final unitResult = ref.read(resolvedUnitProvider(analyzedFile)).value;
    if (unitResult == null) return;
    unitResult.unit.accept(visitor);
    final annotations = visitor.annotatedNodes;
    state = AsyncValue.data(annotations);
    reporter.recordAnnotationsCompleted();
  }
}

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
