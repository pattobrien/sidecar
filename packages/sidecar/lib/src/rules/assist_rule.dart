import '../analyzer/ast/ast.dart';
import 'base_rule.dart';
import 'visitor.dart';

abstract class AssistRule extends BaseRule {}

mixin AssistFilterWithVisitor on AssistRule {
  SidecarVisitor Function() get visitorCreator;

  void initializeVisitor(NodeRegistry registry);
}
