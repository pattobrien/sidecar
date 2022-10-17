import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class Visitor extends SimpleElementVisitor<void> {
  // late String className;
  final fields = <String, dynamic>{};
  String? className;

  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    className = elementReturnType;
    // className = elementReturnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();
    // 7
    fields[element.name] = elementType.replaceFirst('*', '');
  }
}
