import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import '../../../rules/rules.dart';
import '../../protocol/models/data_result.dart';
import '../../protocol/protocol.dart';
import '../../rules/rules.dart';
import '../sidecar_analyzer.dart';
import 'visitor_subscription.dart';

part 'lint_node_registry.dart';

/// Visitor that executes all visit methods of a given NodeRegistry.
class RegisteredRuleVisitor extends GeneralizingAstVisitor<void> {
  /// Visitor that executes all visit methods of a given NodeRegistry.
  RegisteredRuleVisitor(this.registry);

  /// Contains aggregated lists of Sidecar Rule visitor methods for a given file.
  final NodeRegistry registry;

  //TODO: can we combine lintResults and assistResults ?
  Set<LintResult> get lintResults =>
      registry.rules.map((e) => e.lintResults).expand((e) => e).toSet();

  Set<SingleDataResult<Object>> get dataResults => registry.rules
      .whereType<Data<Object>>()
      .map((e) => e.dataResults)
      .expand((e) => e)
      .toSet();

  Set<AssistFilterResult> get assistResults =>
      registry.rules.map((e) => e.assistFilterResults).expand((e) => e).toSet();

  @override
  void visitNode(AstNode node) {
    _runSubscriptions(node, registry._forNode);
    node.visitChildren(this);
    // super.visitNode(node);
  }

  @override
  void visitAdjacentStrings(AdjacentStrings node) {
    _runSubscriptions(node, registry._forAdjacentStrings);
    node.visitChildren(this);
  }

  @override
  void visitAnnotation(Annotation node) {
    _runSubscriptions(node, registry._forAnnotation);
    node.visitChildren(this);
  }

  @override
  void visitArgumentList(ArgumentList node) {
    _runSubscriptions(node, registry._forArgumentList);
    node.visitChildren(this);
  }

  @override
  void visitAsExpression(AsExpression node) {
    _runSubscriptions(node, registry._forAsExpression);
    node.visitChildren(this);
  }

  @override
  void visitAssertInitializer(AssertInitializer node) {
    _runSubscriptions(node, registry._forAssertInitializer);
    node.visitChildren(this);
  }

  @override
  void visitAssertStatement(AssertStatement node) {
    _runSubscriptions(node, registry._forAssertStatement);
    node.visitChildren(this);
  }

  @override
  void visitAssignmentExpression(AssignmentExpression node) {
    _runSubscriptions(node, registry._forAssignmentExpression);
    node.visitChildren(this);
  }

  @override
  void visitAugmentationImportDirective(AugmentationImportDirective node) {
    _runSubscriptions(node, registry._forAugmentationImportDirective);
    node.visitChildren(this);
  }

  @override
  void visitAwaitExpression(AwaitExpression node) {
    _runSubscriptions(node, registry._forAwaitExpression);
    node.visitChildren(this);
  }

  @override
  void visitBinaryExpression(BinaryExpression node) {
    _runSubscriptions(node, registry._forBinaryExpression);
    node.visitChildren(this);
  }

  @override
  void visitBlock(Block node) {
    _runSubscriptions(node, registry._forBlock);
    node.visitChildren(this);
  }

  @override
  void visitBlockFunctionBody(BlockFunctionBody node) {
    _runSubscriptions(node, registry._forBlockFunctionBody);
    node.visitChildren(this);
  }

  @override
  void visitBooleanLiteral(BooleanLiteral node) {
    _runSubscriptions(node, registry._forBooleanLiteral);
    node.visitChildren(this);
  }

  @override
  void visitBreakStatement(BreakStatement node) {
    _runSubscriptions(node, registry._forBreakStatement);
    node.visitChildren(this);
  }

  @override
  void visitCascadeExpression(CascadeExpression node) {
    _runSubscriptions(node, registry._forCascadeExpression);
    node.visitChildren(this);
  }

  @override
  void visitCatchClause(CatchClause node) {
    _runSubscriptions(node, registry._forCatchClause);
    node.visitChildren(this);
  }

  @override
  void visitCatchClauseParameter(CatchClauseParameter node) {
    _runSubscriptions(node, registry._forCatchClauseParameter);
    node.visitChildren(this);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _runSubscriptions(node, registry._forClassDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitClassTypeAlias(ClassTypeAlias node) {
    _runSubscriptions(node, registry._forClassTypeAlias);
    node.visitChildren(this);
  }

  @override
  void visitComment(Comment node) {
    _runSubscriptions(node, registry._forComment);
    node.visitChildren(this);
  }

  @override
  void visitCommentReference(CommentReference node) {
    _runSubscriptions(node, registry._forCommentReference);
    node.visitChildren(this);
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    _runSubscriptions(node, registry._forCompilationUnit);
    node.visitChildren(this);
  }

  @override
  void visitConditionalExpression(ConditionalExpression node) {
    _runSubscriptions(node, registry._forConditionalExpression);
    node.visitChildren(this);
  }

  @override
  void visitConfiguration(Configuration node) {
    _runSubscriptions(node, registry._forConfiguration);
    node.visitChildren(this);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    _runSubscriptions(node, registry._forConstructorDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitConstructorFieldInitializer(ConstructorFieldInitializer node) {
    _runSubscriptions(node, registry._forConstructorFieldInitializer);
    node.visitChildren(this);
  }

  @override
  void visitConstructorName(ConstructorName node) {
    _runSubscriptions(node, registry._forConstructorName);
    node.visitChildren(this);
  }

  @override
  void visitConstructorReference(ConstructorReference node) {
    _runSubscriptions(node, registry._forConstructorReference);
    node.visitChildren(this);
  }

  @override
  void visitConstructorSelector(ConstructorSelector node) {
    _runSubscriptions(node, registry._forConstructorSelector);
    node.visitChildren(this);
  }

  @override
  void visitContinueStatement(ContinueStatement node) {
    _runSubscriptions(node, registry._forContinueStatement);
    node.visitChildren(this);
  }

  @override
  void visitDeclaredIdentifier(DeclaredIdentifier node) {
    _runSubscriptions(node, registry._forDeclaredIdentifier);
    node.visitChildren(this);
  }

  @override
  void visitDefaultFormalParameter(DefaultFormalParameter node) {
    _runSubscriptions(node, registry._forDefaultFormalParameter);
    node.visitChildren(this);
  }

  @override
  void visitDoStatement(DoStatement node) {
    _runSubscriptions(node, registry._forDoStatement);
    node.visitChildren(this);
  }

  @override
  void visitDottedName(DottedName node) {
    _runSubscriptions(node, registry._forDottedName);
    node.visitChildren(this);
  }

  @override
  void visitDoubleLiteral(DoubleLiteral node) {
    _runSubscriptions(node, registry._forDoubleLiteral);
    node.visitChildren(this);
  }

  @override
  void visitEmptyFunctionBody(EmptyFunctionBody node) {
    _runSubscriptions(node, registry._forEmptyFunctionBody);
    node.visitChildren(this);
  }

  @override
  void visitEmptyStatement(EmptyStatement node) {
    _runSubscriptions(node, registry._forEmptyStatement);
    node.visitChildren(this);
  }

  @override
  void visitEnumConstantArguments(EnumConstantArguments node) {
    _runSubscriptions(node, registry._forEnumConstantArguments);
    node.visitChildren(this);
  }

  @override
  void visitEnumConstantDeclaration(EnumConstantDeclaration node) {
    _runSubscriptions(node, registry._forEnumConstantDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    _runSubscriptions(node, registry._forEnumDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitExportDirective(ExportDirective node) {
    _runSubscriptions(node, registry._forExportDirective);
    node.visitChildren(this);
  }

  @override
  void visitExpressionFunctionBody(ExpressionFunctionBody node) {
    _runSubscriptions(node, registry._forExpressionFunctionBody);
    node.visitChildren(this);
  }

  @override
  void visitExpressionStatement(ExpressionStatement node) {
    _runSubscriptions(node, registry._forExpressionStatement);
    node.visitChildren(this);
  }

  @override
  void visitExtendsClause(ExtendsClause node) {
    _runSubscriptions(node, registry._forExtendsClause);
    node.visitChildren(this);
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    _runSubscriptions(node, registry._forExtensionDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitExtensionOverride(ExtensionOverride node) {
    _runSubscriptions(node, registry._forExtensionOverride);
    node.visitChildren(this);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    _runSubscriptions(node, registry._forFieldDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitFieldFormalParameter(FieldFormalParameter node) {
    _runSubscriptions(node, registry._forFieldFormalParameter);
    node.visitChildren(this);
  }

  @override
  void visitForEachPartsWithDeclaration(ForEachPartsWithDeclaration node) {
    _runSubscriptions(node, registry._forForEachPartsWithDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitForEachPartsWithIdentifier(ForEachPartsWithIdentifier node) {
    _runSubscriptions(node, registry._forForEachPartsWithIdentifier);
    node.visitChildren(this);
  }

  @override
  void visitForElement(ForElement node) {
    _runSubscriptions(node, registry._forForElement);
    node.visitChildren(this);
  }

  @override
  void visitFormalParameterList(FormalParameterList node) {
    _runSubscriptions(node, registry._forFormalParameterList);
    node.visitChildren(this);
  }

  @override
  void visitForPartsWithDeclarations(ForPartsWithDeclarations node) {
    _runSubscriptions(node, registry._forForPartsWithDeclarations);
    node.visitChildren(this);
  }

  @override
  void visitForPartsWithExpression(ForPartsWithExpression node) {
    _runSubscriptions(node, registry._forForPartsWithExpression);
    node.visitChildren(this);
  }

  @override
  void visitForStatement(ForStatement node) {
    _runSubscriptions(node, registry._forForStatement);
    node.visitChildren(this);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    _runSubscriptions(node, registry._forFunctionDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    _runSubscriptions(node, registry._forFunctionDeclarationStatement);
    node.visitChildren(this);
  }

  @override
  void visitFunctionExpression(FunctionExpression node) {
    _runSubscriptions(node, registry._forFunctionExpression);
    node.visitChildren(this);
  }

  @override
  void visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    _runSubscriptions(node, registry._forFunctionExpressionInvocation);
    node.visitChildren(this);
  }

  @override
  void visitFunctionReference(FunctionReference node) {
    _runSubscriptions(node, registry._forFunctionReference);
    node.visitChildren(this);
  }

  @override
  void visitFunctionTypeAlias(FunctionTypeAlias node) {
    _runSubscriptions(node, registry._forFunctionTypeAlias);
    node.visitChildren(this);
  }

  @override
  void visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) {
    _runSubscriptions(node, registry._forFunctionTypedFormalParameter);
    node.visitChildren(this);
  }

  @override
  void visitGenericFunctionType(GenericFunctionType node) {
    _runSubscriptions(node, registry._forGenericFunctionType);
    node.visitChildren(this);
  }

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    _runSubscriptions(node, registry._forGenericTypeAlias);
    node.visitChildren(this);
  }

  @override
  void visitHideClause(HideClause node) {
    _runSubscriptions(node, registry._forHideClause);
    node.visitChildren(this);
  }

  @override
  void visitHideCombinator(HideCombinator node) {
    _runSubscriptions(node, registry._forHideCombinator);
    node.visitChildren(this);
  }

  @override
  void visitIfElement(IfElement node) {
    _runSubscriptions(node, registry._forIfElement);
    node.visitChildren(this);
  }

  @override
  void visitIfStatement(IfStatement node) {
    _runSubscriptions(node, registry._forIfStatement);
    node.visitChildren(this);
  }

  @override
  void visitImplementsClause(ImplementsClause node) {
    _runSubscriptions(node, registry._forImplementsClause);
    node.visitChildren(this);
  }

  @override
  void visitImplicitCallReference(ImplicitCallReference node) {
    _runSubscriptions(node, registry._forImplicitCallReference);
    node.visitChildren(this);
  }

  @override
  void visitImportDirective(ImportDirective node) {
    _runSubscriptions(node, registry._forImportDirective);
    node.visitChildren(this);
  }

  @override
  void visitIndexExpression(IndexExpression node) {
    _runSubscriptions(node, registry._forIndexExpression);
    node.visitChildren(this);
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    _runSubscriptions(node, registry._forInstanceCreationExpression);
    node.visitChildren(this);
  }

  @override
  void visitIntegerLiteral(IntegerLiteral node) {
    _runSubscriptions(node, registry._forIntegerLiteral);
    node.visitChildren(this);
  }

  @override
  void visitInterpolationExpression(InterpolationExpression node) {
    _runSubscriptions(node, registry._forInterpolationExpression);
    node.visitChildren(this);
  }

  @override
  void visitInterpolationString(InterpolationString node) {
    _runSubscriptions(node, registry._forInterpolationString);
    node.visitChildren(this);
  }

  @override
  void visitIsExpression(IsExpression node) {
    _runSubscriptions(node, registry._forIsExpression);
    node.visitChildren(this);
  }

  @override
  void visitLabel(Label node) {
    _runSubscriptions(node, registry._forLabel);
    node.visitChildren(this);
  }

  @override
  void visitLabeledStatement(LabeledStatement node) {
    _runSubscriptions(node, registry._forLabeledStatement);
    node.visitChildren(this);
  }

  @override
  void visitLibraryAugmentationDirective(LibraryAugmentationDirective node) {
    _runSubscriptions(node, registry._forLibraryAugmentationDirective);
    node.visitChildren(this);
  }

  @override
  void visitLibraryDirective(LibraryDirective node) {
    _runSubscriptions(node, registry._forLibraryDirective);
    node.visitChildren(this);
  }

  @override
  void visitLibraryIdentifier(LibraryIdentifier node) {
    _runSubscriptions(node, registry._forLibraryIdentifier);
    node.visitChildren(this);
  }

  @override
  void visitListLiteral(ListLiteral node) {
    _runSubscriptions(node, registry._forListLiteral);
    node.visitChildren(this);
  }

  @override
  void visitMapLiteralEntry(MapLiteralEntry node) {
    _runSubscriptions(node, registry._forMapLiteralEntry);
    node.visitChildren(this);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    _runSubscriptions(node, registry._forMethodDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    _runSubscriptions(node, registry._forMethodInvocation);
    node.visitChildren(this);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    _runSubscriptions(node, registry._forMixinDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitNamedExpression(NamedExpression node) {
    _runSubscriptions(node, registry._forNamedExpression);
    node.visitChildren(this);
  }

  @override
  void visitNamedType(NamedType node) {
    _runSubscriptions(node, registry._forNamedType);
    node.visitChildren(this);
  }

  @override
  void visitNativeClause(NativeClause node) {
    _runSubscriptions(node, registry._forNativeClause);
    node.visitChildren(this);
  }

  @override
  void visitNativeFunctionBody(NativeFunctionBody node) {
    _runSubscriptions(node, registry._forNativeFunctionBody);
    node.visitChildren(this);
  }

  @override
  void visitNullLiteral(NullLiteral node) {
    _runSubscriptions(node, registry._forNullLiteral);
    node.visitChildren(this);
  }

  @override
  void visitOnClause(OnClause node) {
    _runSubscriptions(node, registry._forOnClause);
    node.visitChildren(this);
  }

  @override
  void visitParenthesizedExpression(ParenthesizedExpression node) {
    _runSubscriptions(node, registry._forParenthesizedExpression);
    node.visitChildren(this);
  }

  @override
  void visitPartDirective(PartDirective node) {
    _runSubscriptions(node, registry._forPartDirective);
    node.visitChildren(this);
  }

  @override
  void visitPartOfDirective(PartOfDirective node) {
    _runSubscriptions(node, registry._forPartOfDirective);
    node.visitChildren(this);
  }

  @override
  void visitPostfixExpression(PostfixExpression node) {
    _runSubscriptions(node, registry._forPostfixExpression);
    node.visitChildren(this);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    _runSubscriptions(node, registry._forPrefixedIdentifier);
    node.visitChildren(this);
  }

  @override
  void visitPrefixExpression(PrefixExpression node) {
    _runSubscriptions(node, registry._forPrefixExpression);
    node.visitChildren(this);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    _runSubscriptions(node, registry._forPropertyAccess);
    node.visitChildren(this);
  }

  // @override
  // void visitRecordLiteral(RecordLiteral node) {
  //   _runSubscriptions(node, registry._forRecordLiterals);
  //   node.visitChildren(this);
  // }

  @override
  void visitRedirectingConstructorInvocation(
      RedirectingConstructorInvocation node) {
    _runSubscriptions(node, registry._forRedirectingConstructorInvocation);
    node.visitChildren(this);
  }

  @override
  void visitRethrowExpression(RethrowExpression node) {
    _runSubscriptions(node, registry._forRethrowExpression);
    node.visitChildren(this);
  }

  @override
  void visitReturnStatement(ReturnStatement node) {
    _runSubscriptions(node, registry._forReturnStatement);
    node.visitChildren(this);
  }

  @override
  void visitScriptTag(ScriptTag scriptTag) {
    _runSubscriptions(scriptTag, registry._forScriptTag);
    scriptTag.visitChildren(this);
  }

  @override
  void visitSetOrMapLiteral(SetOrMapLiteral node) {
    _runSubscriptions(node, registry._forSetOrMapLiteral);
    node.visitChildren(this);
  }

  @override
  void visitShowClause(ShowClause node) {
    _runSubscriptions(node, registry._forShowClause);
    node.visitChildren(this);
  }

  @override
  void visitShowCombinator(ShowCombinator node) {
    _runSubscriptions(node, registry._forShowCombinator);
    node.visitChildren(this);
  }

  @override
  void visitShowHideElement(ShowHideElement node) {
    _runSubscriptions(node, registry._forShowHideElement);
    node.visitChildren(this);
  }

  @override
  void visitSimpleFormalParameter(SimpleFormalParameter node) {
    _runSubscriptions(node, registry._forSimpleFormalParameter);
    node.visitChildren(this);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    _runSubscriptions(node, registry._forSimpleIdentifier);
    node.visitChildren(this);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    _runSubscriptions(node, registry._forSimpleStringLiteral);
    node.visitChildren(this);
  }

  @override
  void visitSpreadElement(SpreadElement node) {
    _runSubscriptions(node, registry._forSpreadElement);
    node.visitChildren(this);
  }

  @override
  void visitStringInterpolation(StringInterpolation node) {
    _runSubscriptions(node, registry._forStringInterpolation);
    node.visitChildren(this);
  }

  @override
  void visitSuperConstructorInvocation(SuperConstructorInvocation node) {
    _runSubscriptions(node, registry._forSuperConstructorInvocation);
    node.visitChildren(this);
  }

  @override
  void visitSuperExpression(SuperExpression node) {
    _runSubscriptions(node, registry._forSuperExpression);
    node.visitChildren(this);
  }

  @override
  void visitSuperFormalParameter(SuperFormalParameter node) {
    _runSubscriptions(node, registry._forSuperFormalParameter);
    node.visitChildren(this);
  }

  @override
  void visitSwitchCase(SwitchCase node) {
    _runSubscriptions(node, registry._forSwitchCase);
    node.visitChildren(this);
  }

  @override
  void visitSwitchDefault(SwitchDefault node) {
    _runSubscriptions(node, registry._forSwitchDefault);
    node.visitChildren(this);
  }

  @override
  void visitSwitchStatement(SwitchStatement node) {
    _runSubscriptions(node, registry._forSwitchStatement);
    node.visitChildren(this);
  }

  @override
  void visitSymbolLiteral(SymbolLiteral node) {
    _runSubscriptions(node, registry._forSymbolLiteral);
    node.visitChildren(this);
  }

  @override
  void visitThisExpression(ThisExpression node) {
    _runSubscriptions(node, registry._forThisExpression);
    node.visitChildren(this);
  }

  @override
  void visitThrowExpression(ThrowExpression node) {
    _runSubscriptions(node, registry._forThrowExpression);
    node.visitChildren(this);
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    _runSubscriptions(node, registry._forTopLevelVariableDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitTryStatement(TryStatement node) {
    _runSubscriptions(node, registry._forTryStatement);
    node.visitChildren(this);
  }

  @override
  void visitTypeArgumentList(TypeArgumentList node) {
    _runSubscriptions(node, registry._forTypeArgumentList);
    node.visitChildren(this);
  }

  @override
  void visitTypeLiteral(TypeLiteral node) {
    _runSubscriptions(node, registry._forTypeLiteral);
    node.visitChildren(this);
  }

  @override
  void visitTypeParameter(TypeParameter node) {
    _runSubscriptions(node, registry._forTypeParameter);
    node.visitChildren(this);
  }

  @override
  void visitTypeParameterList(TypeParameterList node) {
    _runSubscriptions(node, registry._forTypeParameterList);
    node.visitChildren(this);
  }

  @override
  void visitVariableDeclaration(VariableDeclaration node) {
    _runSubscriptions(node, registry._forVariableDeclaration);
    node.visitChildren(this);
  }

  @override
  void visitVariableDeclarationList(VariableDeclarationList node) {
    _runSubscriptions(node, registry._forVariableDeclarationList);
    node.visitChildren(this);
  }

  @override
  void visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    _runSubscriptions(node, registry._forVariableDeclarationStatement);
    node.visitChildren(this);
  }

  @override
  void visitWhileStatement(WhileStatement node) {
    _runSubscriptions(node, registry._forWhileStatement);
    node.visitChildren(this);
  }

  @override
  void visitWithClause(WithClause node) {
    _runSubscriptions(node, registry._forWithClause);
    node.visitChildren(this);
  }

  @override
  void visitYieldStatement(YieldStatement node) {
    _runSubscriptions(node, registry._forYieldStatement);
    node.visitChildren(this);
  }

  @override
  void visitRecordLiteral(RecordLiteral node) {
    _runSubscriptions(node, registry._forRecordLiteral);
    node.visitChildren(this);
  }

  @override
  void visitRecordTypeAnnotation(RecordTypeAnnotation node) {
    _runSubscriptions(node, registry._forRecordTypeAnnotation);
    node.visitChildren(this);
  }

  @override
  void visitRecordTypeAnnotationNamedField(
      RecordTypeAnnotationNamedField node) {
    _runSubscriptions(node, registry._forRecordTypeAnnotationNamedField);
    node.visitChildren(this);
  }

  @override
  void visitRecordTypeAnnotationNamedFields(
      RecordTypeAnnotationNamedFields node) {
    _runSubscriptions(node, registry._forRecordTypeAnnotationNamedFields);
    node.visitChildren(this);
  }

  @override
  void visitRecordTypeAnnotationPositionalField(
      RecordTypeAnnotationPositionalField node) {
    _runSubscriptions(node, registry._forRecordTypeAnnotationPositionalField);
    node.visitChildren(this);
  }

  void _runSubscriptions<T extends AstNode>(
    T node,
    List<VisitorSubscription<T>> subscriptions,
  ) {
    for (var i = 0; i < subscriptions.length; i++) {
      final subscription = subscriptions[i];
      final timer = subscription.timer;
      timer?.start();
      try {
        final rule = subscription.rule;
        timedLog<dynamic>(
            'runSubscriptions ${rule.code.id} ${node.beginToken.lexeme}', () {
          node.accept<dynamic>(rule);
        });
      } catch (e) {
        // if (!exceptionHandler(
        //     node, subscription.linter, exception, stackTrace)) {
        rethrow;
        // }
      }
      timer?.stop();
    }
  }
}
