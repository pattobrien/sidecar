import 'package:analyzer/dart/analysis/context_root.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:riverpod/riverpod.dart';

final annotationServiceProvider =
    Provider.family<AnnotationService, ContextRoot>(
  (ref, root) => AnnotationService(root),
);

class AnnotationService {
  AnnotationService(this.root);
  final ContextRoot root;
  List<ElementAnnotation> annotations = <ElementAnnotation>[];

  void addAnnotation(ElementAnnotation annotation) =>
      annotations.add(annotation);

  void addAnnotations(List<ElementAnnotation> annots) {
    for (final annotation in annots) {
      annotations.add(annotation);
    }
  }
}
