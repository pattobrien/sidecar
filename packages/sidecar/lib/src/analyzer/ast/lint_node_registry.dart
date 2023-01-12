// ignore_for_file: public_member_api_docs
// coverage:ignore-file

part of 'registered_rule_visitor.dart';

/// Initialize and run all visitor methods within rules.
class NodeRegistry {
  /// Initialize and run all visitor methods within rules.
  NodeRegistry(this.rules) {
    for (final rule in rules) {
      rule.initializeVisitor(this);
    }
  }

  /// Rules with registered visitor methods
  final Set<BaseRule> rules;

  final List<VisitorSubscription<AdjacentStrings>> _forAdjacentStrings = [];
  final List<VisitorSubscription<Annotation>> _forAnnotation = [];
  final List<VisitorSubscription<ArgumentList>> _forArgumentList = [];
  final List<VisitorSubscription<AsExpression>> _forAsExpression = [];
  final List<VisitorSubscription<AssertInitializer>> _forAssertInitializer = [];
  final List<VisitorSubscription<AssertStatement>> _forAssertStatement = [];
  final List<VisitorSubscription<AssignmentExpression>>
      _forAssignmentExpression = [];
  final List<VisitorSubscription<AugmentationImportDirective>>
      _forAugmentationImportDirective = [];
  final List<VisitorSubscription<AwaitExpression>> _forAwaitExpression = [];
  final List<VisitorSubscription<BinaryExpression>> _forBinaryExpression = [];
  final List<VisitorSubscription<Block>> _forBlock = [];
  final List<VisitorSubscription<BlockFunctionBody>> _forBlockFunctionBody = [];
  final List<VisitorSubscription<BooleanLiteral>> _forBooleanLiteral = [];
  final List<VisitorSubscription<BreakStatement>> _forBreakStatement = [];
  final List<VisitorSubscription<CascadeExpression>> _forCascadeExpression = [];
  final List<VisitorSubscription<CatchClause>> _forCatchClause = [];
  final List<VisitorSubscription<CatchClauseParameter>>
      _forCatchClauseParameter = [];
  final List<VisitorSubscription<ClassDeclaration>> _forClassDeclaration = [];
  final List<VisitorSubscription<ClassTypeAlias>> _forClassTypeAlias = [];
  final List<VisitorSubscription<Comment>> _forComment = [];
  final List<VisitorSubscription<CommentReference>> _forCommentReference = [];
  final List<VisitorSubscription<CompilationUnit>> _forCompilationUnit = [];
  final List<VisitorSubscription<ConditionalExpression>>
      _forConditionalExpression = [];
  final List<VisitorSubscription<Configuration>> _forConfiguration = [];
  final List<VisitorSubscription<ConstructorDeclaration>>
      _forConstructorDeclaration = [];
  final List<VisitorSubscription<ConstructorFieldInitializer>>
      _forConstructorFieldInitializer = [];
  final List<VisitorSubscription<ConstructorName>> _forConstructorName = [];
  final List<VisitorSubscription<ConstructorReference>>
      _forConstructorReference = [];
  final List<VisitorSubscription<ConstructorSelector>> _forConstructorSelector =
      [];
  final List<VisitorSubscription<ContinueStatement>> _forContinueStatement = [];
  final List<VisitorSubscription<DeclaredIdentifier>> _forDeclaredIdentifier =
      [];
  final List<VisitorSubscription<DefaultFormalParameter>>
      _forDefaultFormalParameter = [];
  final List<VisitorSubscription<DoStatement>> _forDoStatement = [];
  final List<VisitorSubscription<DottedName>> _forDottedName = [];
  final List<VisitorSubscription<DoubleLiteral>> _forDoubleLiteral = [];
  final List<VisitorSubscription<EmptyFunctionBody>> _forEmptyFunctionBody = [];
  final List<VisitorSubscription<EmptyStatement>> _forEmptyStatement = [];
  final List<VisitorSubscription<EnumConstantArguments>>
      _forEnumConstantArguments = [];
  final List<VisitorSubscription<EnumConstantDeclaration>>
      _forEnumConstantDeclaration = [];
  final List<VisitorSubscription<EnumDeclaration>> _forEnumDeclaration = [];
  final List<VisitorSubscription<ExportDirective>> _forExportDirective = [];
  final List<VisitorSubscription<ExpressionFunctionBody>>
      _forExpressionFunctionBody = [];
  final List<VisitorSubscription<ExpressionStatement>> _forExpressionStatement =
      [];
  final List<VisitorSubscription<ExtendsClause>> _forExtendsClause = [];
  final List<VisitorSubscription<ExtensionDeclaration>>
      _forExtensionDeclaration = [];
  final List<VisitorSubscription<ExtensionOverride>> _forExtensionOverride = [];
  final List<VisitorSubscription<FieldDeclaration>> _forFieldDeclaration = [];
  final List<VisitorSubscription<FieldFormalParameter>>
      _forFieldFormalParameter = [];
  final List<VisitorSubscription<ForEachPartsWithDeclaration>>
      _forForEachPartsWithDeclaration = [];
  final List<VisitorSubscription<ForEachPartsWithIdentifier>>
      _forForEachPartsWithIdentifier = [];
  final List<VisitorSubscription<ForElement>> _forForElement = [];
  final List<VisitorSubscription<FormalParameterList>> _forFormalParameterList =
      [];
  final List<VisitorSubscription<ForPartsWithDeclarations>>
      _forForPartsWithDeclarations = [];
  final List<VisitorSubscription<ForPartsWithExpression>>
      _forForPartsWithExpression = [];
  final List<VisitorSubscription<ForStatement>> _forForStatement = [];
  final List<VisitorSubscription<FunctionDeclaration>> _forFunctionDeclaration =
      [];
  final List<VisitorSubscription<FunctionDeclarationStatement>>
      _forFunctionDeclarationStatement = [];
  final List<VisitorSubscription<FunctionExpression>> _forFunctionExpression =
      [];
  final List<VisitorSubscription<FunctionExpressionInvocation>>
      _forFunctionExpressionInvocation = [];
  final List<VisitorSubscription<FunctionReference>> _forFunctionReference = [];
  final List<VisitorSubscription<FunctionTypeAlias>> _forFunctionTypeAlias = [];
  final List<VisitorSubscription<FunctionTypedFormalParameter>>
      _forFunctionTypedFormalParameter = [];
  final List<VisitorSubscription<GenericFunctionType>> _forGenericFunctionType =
      [];
  final List<VisitorSubscription<GenericTypeAlias>> _forGenericTypeAlias = [];
  final List<VisitorSubscription<HideClause>> _forHideClause = [];
  final List<VisitorSubscription<HideCombinator>> _forHideCombinator = [];
  final List<VisitorSubscription<IfElement>> _forIfElement = [];
  final List<VisitorSubscription<IfStatement>> _forIfStatement = [];
  final List<VisitorSubscription<ImplementsClause>> _forImplementsClause = [];
  final List<VisitorSubscription<ImplicitCallReference>>
      _forImplicitCallReference = [];
  final List<VisitorSubscription<ImportDirective>> _forImportDirective = [];
  final List<VisitorSubscription<IndexExpression>> _forIndexExpression = [];
  final List<VisitorSubscription<InstanceCreationExpression>>
      _forInstanceCreationExpression = [];
  final List<VisitorSubscription<IntegerLiteral>> _forIntegerLiteral = [];
  final List<VisitorSubscription<InterpolationExpression>>
      _forInterpolationExpression = [];
  final List<VisitorSubscription<InterpolationString>> _forInterpolationString =
      [];
  final List<VisitorSubscription<IsExpression>> _forIsExpression = [];
  final List<VisitorSubscription<Label>> _forLabel = [];
  final List<VisitorSubscription<LabeledStatement>> _forLabeledStatement = [];
  final List<VisitorSubscription<LibraryAugmentationDirective>>
      _forLibraryAugmentationDirective = [];
  final List<VisitorSubscription<LibraryDirective>> _forLibraryDirective = [];
  final List<VisitorSubscription<LibraryIdentifier>> _forLibraryIdentifier = [];
  final List<VisitorSubscription<ListLiteral>> _forListLiteral = [];
  final List<VisitorSubscription<MapLiteralEntry>> _forMapLiteralEntry = [];
  final List<VisitorSubscription<MethodDeclaration>> _forMethodDeclaration = [];
  final List<VisitorSubscription<MethodInvocation>> _forMethodInvocation = [];
  final List<VisitorSubscription<MixinDeclaration>> _forMixinDeclaration = [];
  final List<VisitorSubscription<NamedExpression>> _forNamedExpression = [];
  final List<VisitorSubscription<NamedType>> _forNamedType = [];
  final List<VisitorSubscription<NativeClause>> _forNativeClause = [];
  final List<VisitorSubscription<NativeFunctionBody>> _forNativeFunctionBody =
      [];
  final List<VisitorSubscription<NullLiteral>> _forNullLiteral = [];
  final List<VisitorSubscription<OnClause>> _forOnClause = [];
  final List<VisitorSubscription<ParenthesizedExpression>>
      _forParenthesizedExpression = [];
  final List<VisitorSubscription<PartDirective>> _forPartDirective = [];
  final List<VisitorSubscription<PartOfDirective>> _forPartOfDirective = [];
  final List<VisitorSubscription<PostfixExpression>> _forPostfixExpression = [];
  final List<VisitorSubscription<PrefixedIdentifier>> _forPrefixedIdentifier =
      [];
  final List<VisitorSubscription<PrefixExpression>> _forPrefixExpression = [];
  final List<VisitorSubscription<PropertyAccess>> _forPropertyAccess = [];
  // final List<VisitorSubscription<RecordLiteral>> _forRecordLiterals = [];
  final List<VisitorSubscription<RedirectingConstructorInvocation>>
      _forRedirectingConstructorInvocation = [];
  final List<VisitorSubscription<RethrowExpression>> _forRethrowExpression = [];
  final List<VisitorSubscription<ReturnStatement>> _forReturnStatement = [];
  final List<VisitorSubscription<ScriptTag>> _forScriptTag = [];
  final List<VisitorSubscription<SetOrMapLiteral>> _forSetOrMapLiteral = [];
  final List<VisitorSubscription<ShowClause>> _forShowClause = [];
  final List<VisitorSubscription<ShowCombinator>> _forShowCombinator = [];
  final List<VisitorSubscription<ShowHideElement>> _forShowHideElement = [];
  final List<VisitorSubscription<SimpleFormalParameter>>
      _forSimpleFormalParameter = [];
  final List<VisitorSubscription<SimpleIdentifier>> _forSimpleIdentifier = [];
  final List<VisitorSubscription<SimpleStringLiteral>> _forSimpleStringLiteral =
      [];
  final List<VisitorSubscription<SpreadElement>> _forSpreadElement = [];
  final List<VisitorSubscription<StringInterpolation>> _forStringInterpolation =
      [];
  final List<VisitorSubscription<SuperConstructorInvocation>>
      _forSuperConstructorInvocation = [];
  final List<VisitorSubscription<SuperExpression>> _forSuperExpression = [];
  final List<VisitorSubscription<SuperFormalParameter>>
      _forSuperFormalParameter = [];
  final List<VisitorSubscription<SwitchCase>> _forSwitchCase = [];
  final List<VisitorSubscription<SwitchDefault>> _forSwitchDefault = [];
  final List<VisitorSubscription<SwitchStatement>> _forSwitchStatement = [];
  final List<VisitorSubscription<SymbolLiteral>> _forSymbolLiteral = [];
  final List<VisitorSubscription<ThisExpression>> _forThisExpression = [];
  final List<VisitorSubscription<ThrowExpression>> _forThrowExpression = [];
  final List<VisitorSubscription<TopLevelVariableDeclaration>>
      _forTopLevelVariableDeclaration = [];
  final List<VisitorSubscription<TryStatement>> _forTryStatement = [];
  final List<VisitorSubscription<TypeArgumentList>> _forTypeArgumentList = [];
  final List<VisitorSubscription<TypeLiteral>> _forTypeLiteral = [];
  final List<VisitorSubscription<TypeParameter>> _forTypeParameter = [];
  final List<VisitorSubscription<TypeParameterList>> _forTypeParameterList = [];
  final List<VisitorSubscription<VariableDeclaration>> _forVariableDeclaration =
      [];
  final List<VisitorSubscription<VariableDeclarationList>>
      _forVariableDeclarationList = [];
  final List<VisitorSubscription<VariableDeclarationStatement>>
      _forVariableDeclarationStatement = [];
  final List<VisitorSubscription<WhileStatement>> _forWhileStatement = [];
  final List<VisitorSubscription<WithClause>> _forWithClause = [];
  final List<VisitorSubscription<YieldStatement>> _forYieldStatement = [];

  final List<VisitorSubscription<RecordLiteral>> _forRecordLiteral = [];
  final List<VisitorSubscription<RecordTypeAnnotation>>
      _forRecordTypeAnnotation = [];
  final List<VisitorSubscription<RecordTypeAnnotationNamedField>>
      _forRecordTypeAnnotationNamedField = [];
  final List<VisitorSubscription<RecordTypeAnnotationNamedFields>>
      _forRecordTypeAnnotationNamedFields = [];
  final List<VisitorSubscription<RecordTypeAnnotationPositionalField>>
      _forRecordTypeAnnotationPositionalField = [];
  final List<VisitorSubscription<AstNode>> _forNode = [];

  void addNode(Rule rule) {
    _forNode.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitAdjacentStrings method.
  void addAdjacentStrings(Rule rule) {
    _forAdjacentStrings.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitAnnotation method.
  void addAnnotation(Rule rule) {
    _forAnnotation.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitArgumentList method.
  void addArgumentList(Rule rule) {
    _forArgumentList.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitAsExpression method.
  void addAsExpression(Rule rule) {
    _forAsExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitAssertInitializer method.
  void addAssertInitializer(Rule rule) {
    _forAssertInitializer.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitAssertStatement method.
  void addAssertStatement(Rule rule) {
    _forAssertStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitAssignmentExpression method.
  void addAssignmentExpression(Rule rule) {
    _forAssignmentExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitAugmentationImportDirective method.
  void addAugmentationImportDirective(Rule rule) {
    _forAugmentationImportDirective
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitAwaitExpression method.
  void addAwaitExpression(Rule rule) {
    _forAwaitExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitBinaryExpression method.
  void addBinaryExpression(Rule rule) {
    _forBinaryExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitBlock method.
  void addBlock(Rule rule) {
    _forBlock.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitBlockFunctionBody method.
  void addBlockFunctionBody(Rule rule) {
    _forBlockFunctionBody.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitBooleanLiteral method.
  void addBooleanLiteral(Rule rule) {
    _forBooleanLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitBreakStatement method.
  void addBreakStatement(Rule rule) {
    _forBreakStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitCascadeExpression method.
  void addCascadeExpression(Rule rule) {
    _forCascadeExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitCatchClause method.
  void addCatchClause(Rule rule) {
    _forCatchClause.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitCatchClauseParameter method.
  void addCatchClauseParameter(Rule rule) {
    _forCatchClauseParameter.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitClassDeclaration method.
  void addClassDeclaration(Rule rule) {
    _forClassDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitClassTypeAlias method.
  void addClassTypeAlias(Rule rule) {
    _forClassTypeAlias.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitComment method.
  void addComment(Rule rule) {
    _forComment.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitCommentReference method.
  void addCommentReference(Rule rule) {
    _forCommentReference.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitCompilationUnit method.
  void addCompilationUnit(Rule rule) {
    _forCompilationUnit.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitConditionalExpression method.
  void addConditionalExpression(Rule rule) {
    _forConditionalExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitConfiguration method.
  void addConfiguration(Rule rule) {
    _forConfiguration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitConstructorDeclaration method.
  void addConstructorDeclaration(Rule rule) {
    _forConstructorDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitConstructorFieldInitializer method.
  void addConstructorFieldInitializer(Rule rule) {
    _forConstructorFieldInitializer
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitConstructorName method.
  void addConstructorName(Rule rule) {
    _forConstructorName.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitConstructorReference method.
  void addConstructorReference(Rule rule) {
    _forConstructorReference.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitConstructorSelector method.
  void addConstructorSelector(Rule rule) {
    _forConstructorSelector.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitContinueStatement method.
  void addContinueStatement(Rule rule) {
    _forContinueStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitDeclaredIdentifier method.
  void addDeclaredIdentifier(Rule rule) {
    _forDeclaredIdentifier.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitDefaultFormalParameter method.
  void addDefaultFormalParameter(Rule rule) {
    _forDefaultFormalParameter.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitDoStatement method.
  void addDoStatement(Rule rule) {
    _forDoStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitDottedName method.
  void addDottedName(Rule rule) {
    _forDottedName.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitDoubleLiteral method.
  void addDoubleLiteral(Rule rule) {
    _forDoubleLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitEmptyFunctionBody method.
  void addEmptyFunctionBody(Rule rule) {
    _forEmptyFunctionBody.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitEmptyStatement method.
  void addEmptyStatement(Rule rule) {
    _forEmptyStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitEnumConstantArguments method.
  void addEnumConstantArguments(Rule rule) {
    _forEnumConstantArguments.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitEnumConstantDeclaration method.
  void addEnumConstantDeclaration(Rule rule) {
    _forEnumConstantDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitEnumDeclaration method.
  void addEnumDeclaration(Rule rule) {
    _forEnumDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitExportDirective method.
  void addExportDirective(Rule rule) {
    _forExportDirective.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitExpressionFunctionBody method.
  void addExpressionFunctionBody(Rule rule) {
    _forExpressionFunctionBody.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitExpressionStatement method.
  void addExpressionStatement(Rule rule) {
    _forExpressionStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitExtendsClause method.
  void addExtendsClause(Rule rule) {
    _forExtendsClause.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitExtensionDeclaration method.
  void addExtensionDeclaration(Rule rule) {
    _forExtensionDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitExtensionOverride method.
  void addExtensionOverride(Rule rule) {
    _forExtensionOverride.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFieldDeclaration method.
  void addFieldDeclaration(Rule rule) {
    _forFieldDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFieldFormalParameter method.
  void addFieldFormalParameter(Rule rule) {
    _forFieldFormalParameter.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitForEachPartsWithDeclaration method.
  void addForEachPartsWithDeclaration(Rule rule) {
    _forForEachPartsWithDeclaration
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitForEachPartsWithIdentifier method.
  void addForEachPartsWithIdentifier(Rule rule) {
    _forForEachPartsWithIdentifier
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitForElement method.
  void addForElement(Rule rule) {
    _forForElement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFormalParameterList method.
  void addFormalParameterList(Rule rule) {
    _forFormalParameterList.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitForPartsWithDeclarations method.
  void addForPartsWithDeclarations(Rule rule) {
    _forForPartsWithDeclarations
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitForPartsWithExpression method.
  void addForPartsWithExpression(Rule rule) {
    _forForPartsWithExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitForStatement method.
  void addForStatement(Rule rule) {
    _forForStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFunctionDeclaration method.
  void addFunctionDeclaration(Rule rule) {
    _forFunctionDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFunctionDelarationStatement method.
  void addFunctionDeclarationStatement(Rule rule) {
    _forFunctionDeclarationStatement
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFunctionExpression method.
  void addFunctionExpression(Rule rule) {
    _forFunctionExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFunctionExpressionInvocation method.
  void addFunctionExpressionInvocation(Rule rule) {
    _forFunctionExpressionInvocation
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFunctionReference method.
  void addFunctionReference(Rule rule) {
    _forFunctionReference.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFunctionTypeAlias method.
  void addFunctionTypeAlias(Rule rule) {
    _forFunctionTypeAlias.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitFunctionTypedFormalParameter method.
  void addFunctionTypedFormalParameter(Rule rule) {
    _forFunctionTypedFormalParameter
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitGenericFunctionType method.
  void addGenericFunctionType(Rule rule) {
    _forGenericFunctionType.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitGenericTypeAlias method.
  void addGenericTypeAlias(Rule rule) {
    _forGenericTypeAlias.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitHideClause method.
  void addHideClause(Rule rule) {
    _forHideClause.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitHideCombinator method.
  void addHideCombinator(Rule rule) {
    _forHideCombinator.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitIfElement method.
  void addIfElement(Rule rule) {
    _forIfElement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitIfStatement method.
  void addIfStatement(Rule rule) {
    _forIfStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitImplementsClause method.
  void addImplementsClause(Rule rule) {
    _forImplementsClause.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitImplicitCallReference method.
  void addImplicitCallReference(Rule rule) {
    _forImplicitCallReference.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitImportDirective method.
  void addImportDirective(Rule rule) {
    _forImportDirective.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitIndexExpression method.
  void addIndexExpression(Rule rule) {
    _forIndexExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitInstanceCreationExpression method.
  void addInstanceCreationExpression(Rule rule) {
    _forInstanceCreationExpression
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitIntegerLiteral method.
  void addIntegerLiteral(Rule rule) {
    _forIntegerLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitInterpolationExpression method.
  void addInterpolationExpression(Rule rule) {
    _forInterpolationExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitInterpolationString method.
  void addInterpolationString(Rule rule) {
    _forInterpolationString.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitIsExpression method.
  void addIsExpression(Rule rule) {
    _forIsExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitLabel method.
  void addLabel(Rule rule) {
    _forLabel.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitLabeledStatement method.
  void addLabeledStatement(Rule rule) {
    _forLabeledStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitLibraryAugmentationDirective method.
  void addLibraryAugmentationDirective(Rule rule) {
    _forLibraryAugmentationDirective
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitLibraryDirective method.
  void addLibraryDirective(Rule rule) {
    _forLibraryDirective.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitLibraryIdentifier method.
  void addLibraryIdentifier(Rule rule) {
    _forLibraryIdentifier.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitListLiteral method.
  void addListLiteral(Rule rule) {
    _forListLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitMapLiteralEntry method.
  void addMapLiteralEntry(Rule rule) {
    _forMapLiteralEntry.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitMethodDeclaration method.
  void addMethodDeclaration(Rule rule) {
    _forMethodDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitMethodInvocation method.
  void addMethodInvocation(Rule rule) {
    _forMethodInvocation.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitMixinDeclaration method.
  void addMixinDeclaration(Rule rule) {
    _forMixinDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitNamedExpression method.
  void addNamedExpression(Rule rule) {
    _forNamedExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitNamedType method.
  void addNamedType(Rule rule) {
    _forNamedType.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitNativeClause method.
  void addNativeClause(Rule rule) {
    _forNativeClause.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for vistiNativeFunctionBody method.
  void addNativeFunctionBody(Rule rule) {
    _forNativeFunctionBody.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitNullLiteral method.
  void addNullLiteral(Rule rule) {
    _forNullLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitOnClause method.
  void addOnClause(Rule rule) {
    _forOnClause.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitParenthesizedExpression method.
  void addParenthesizedExpression(Rule rule) {
    _forParenthesizedExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitPartDirective method.
  void addPartDirective(Rule rule) {
    _forPartDirective.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitPartOfDirective method.
  void addPartOfDirective(Rule rule) {
    _forPartOfDirective.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitPostfixExpression method.
  void addPostfixExpression(Rule rule) {
    _forPostfixExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitPrefixedIdentifier method.
  void addPrefixedIdentifier(Rule rule) {
    _forPrefixedIdentifier.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitPrefixExpression method.
  void addPrefixExpression(Rule rule) {
    _forPrefixExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitPropertyAccess method.
  void addPropertyAccess(Rule rule) {
    _forPropertyAccess.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  // void addRecordLiteral(LintError linter, SidecarAstVisitor rule) {
  //   _forRecordLiterals.add(VisitorSubscription(rule, _getTimer(rule)));
  // }

  /// Register a rule for visitRedirectingConstructorInvocation method.
  void addRedirectingConstructorInvocation(Rule rule) {
    _forRedirectingConstructorInvocation
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitRethrowExpression method.
  void addRethrowExpression(Rule rule) {
    _forRethrowExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitReturnStatement method.
  void addReturnStatement(Rule rule) {
    _forReturnStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitScriptTag method.
  void addScriptTag(Rule rule) {
    _forScriptTag.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSetOrMapLiteral method.
  void addSetOrMapLiteral(Rule rule) {
    _forSetOrMapLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitShowClause method.
  void addShowClause(Rule rule) {
    _forShowClause.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitShowCombinator method.
  void addShowCombinator(Rule rule) {
    _forShowCombinator.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitShowHideElement method.
  void addShowHideElement(Rule rule) {
    _forShowHideElement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSimpleFormalParameter method.
  void addSimpleFormalParameter(Rule rule) {
    _forSimpleFormalParameter.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSimpleIdentifier method.
  void addSimpleIdentifier(Rule rule) {
    _forSimpleIdentifier.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSimpleStringLiteral method.
  void addSimpleStringLiteral(Rule rule) {
    _forSimpleStringLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSpreadElement method.
  void addSpreadElement(Rule rule) {
    _forSpreadElement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitStringInterpolation method.
  void addStringInterpolation(Rule rule) {
    _forStringInterpolation.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSuperConstructorInvocation method.
  void addSuperConstructorInvocation(Rule rule) {
    _forSuperConstructorInvocation
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSuperExpression method.
  void addSuperExpression(Rule rule) {
    _forSuperExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSuperFormalParameter method.
  void addSuperFormalParameter(Rule rule) {
    _forSuperFormalParameter.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSwitchCase method.
  void addSwitchCase(Rule rule) {
    _forSwitchCase.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSwitchDefault method.
  void addSwitchDefault(Rule rule) {
    _forSwitchDefault.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSwitchStatement method.
  void addSwitchStatement(Rule rule) {
    _forSwitchStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitSymbolLiteral method.
  void addSymbolLiteral(Rule rule) {
    _forSymbolLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitThisExpression method.
  void addThisExpression(Rule rule) {
    _forThisExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitThrowExpression method.
  void addThrowExpression(Rule rule) {
    _forThrowExpression.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitTopLevelVariableDeclaration method.
  void addTopLevelVariableDeclaration(Rule rule) {
    _forTopLevelVariableDeclaration
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitTryStatement method.
  void addTryStatement(Rule rule) {
    _forTryStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitTypeArgumentList method.
  void addTypeArgumentList(Rule rule) {
    _forTypeArgumentList.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitTypeLiteral method.
  void addTypeLiteral(Rule rule) {
    _forTypeLiteral.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  @Deprecated('Use addNamedType() instead')

  /// Register a rule for visitTypeName method.
  void addTypeName(Rule rule) {
    addNamedType(rule);
  }

  /// Register a rule for visitTypeParameter method.
  void addTypeParameter(Rule rule) {
    _forTypeParameter.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitTypeParameterList method.
  void addTypeParameterList(Rule rule) {
    _forTypeParameterList.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitVariableDeclaration method.
  void addVariableDeclaration(Rule rule) {
    _forVariableDeclaration.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitVariableDeclarationList method.
  void addVariableDeclarationList(Rule rule) {
    _forVariableDeclarationList.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitVariableDeclarationStatement method.
  void addVariableDeclarationStatement(Rule rule) {
    _forVariableDeclarationStatement
        .add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitWhileStatement method.
  void addWhileStatement(Rule rule) {
    _forWhileStatement.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitWithClause method.
  void addWithClause(Rule rule) {
    _forWithClause.add(VisitorSubscription(rule, _getTimer(rule)));
  }

  /// Register a rule for visitYieldStatement method.
  void addYieldStatement(Rule linter) {
    _forYieldStatement.add(VisitorSubscription(linter, _getTimer(linter)));
  }

  /// Get the timer associated with the given [linter].
  Stopwatch? _getTimer(Rule linter) {
    // if (enableTiming) {
    //   return registry.getTimer(linter);
    // } else {
    //   return null;
    // }
    return null;
  }
}
