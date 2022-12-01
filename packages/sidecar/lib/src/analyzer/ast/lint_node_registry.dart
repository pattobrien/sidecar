// ignore_for_file: public_member_api_docs
// coverage:ignore-file

part of 'registered_rule_visitor.dart';

class NodeRegistry {
  NodeRegistry(this.rules) {
    init();
  }

  final Set<BaseRule> rules;

  void init() {
    for (final rule in rules) {
      rule.initializeVisitor(this);
    }
  }

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

  void addNode(Rule visitor) {
    _forNode.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAdjacentStrings(Rule visitor) {
    _forAdjacentStrings.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAnnotation(Rule visitor) {
    _forAnnotation.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addArgumentList(Rule visitor) {
    _forArgumentList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAsExpression(Rule visitor) {
    _forAsExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssertInitializer(Rule visitor) {
    _forAssertInitializer.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssertStatement(Rule visitor) {
    _forAssertStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssignmentExpression(Rule visitor) {
    _forAssignmentExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAugmentationImportDirective(Rule visitor) {
    _forAugmentationImportDirective
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAwaitExpression(Rule visitor) {
    _forAwaitExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBinaryExpression(Rule visitor) {
    _forBinaryExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBlock(Rule visitor) {
    _forBlock.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBlockFunctionBody(Rule visitor) {
    _forBlockFunctionBody.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBooleanLiteral(Rule visitor) {
    _forBooleanLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBreakStatement(Rule visitor) {
    _forBreakStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCascadeExpression(Rule visitor) {
    _forCascadeExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCatchClause(Rule visitor) {
    _forCatchClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCatchClauseParameter(Rule visitor) {
    _forCatchClauseParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addClassDeclaration(Rule visitor) {
    _forClassDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addClassTypeAlias(Rule visitor) {
    _forClassTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addComment(Rule visitor) {
    _forComment.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCommentReference(Rule visitor) {
    _forCommentReference.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCompilationUnit(Rule visitor) {
    _forCompilationUnit.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConditionalExpression(Rule visitor) {
    _forConditionalExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConfiguration(Rule visitor) {
    _forConfiguration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorDeclaration(Rule visitor) {
    _forConstructorDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorFieldInitializer(Rule visitor) {
    _forConstructorFieldInitializer
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorName(Rule visitor) {
    _forConstructorName.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorReference(Rule visitor) {
    _forConstructorReference
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorSelector(Rule visitor) {
    _forConstructorSelector
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addContinueStatement(Rule visitor) {
    _forContinueStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDeclaredIdentifier(Rule visitor) {
    _forDeclaredIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDefaultFormalParameter(Rule visitor) {
    _forDefaultFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDoStatement(Rule visitor) {
    _forDoStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDottedName(Rule visitor) {
    _forDottedName.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDoubleLiteral(Rule visitor) {
    _forDoubleLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEmptyFunctionBody(Rule visitor) {
    _forEmptyFunctionBody.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEmptyStatement(Rule visitor) {
    _forEmptyStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumConstantArguments(Rule visitor) {
    _forEnumConstantArguments
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumConstantDeclaration(Rule visitor) {
    _forEnumConstantDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumDeclaration(Rule visitor) {
    _forEnumDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExportDirective(Rule visitor) {
    _forExportDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExpressionFunctionBody(Rule visitor) {
    _forExpressionFunctionBody
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExpressionStatement(Rule visitor) {
    _forExpressionStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtendsClause(Rule visitor) {
    _forExtendsClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtensionDeclaration(Rule visitor) {
    _forExtensionDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtensionOverride(Rule visitor) {
    _forExtensionOverride.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFieldDeclaration(Rule visitor) {
    _forFieldDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFieldFormalParameter(Rule visitor) {
    _forFieldFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForEachPartsWithDeclaration(Rule visitor) {
    _forForEachPartsWithDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForEachPartsWithIdentifier(Rule visitor) {
    _forForEachPartsWithIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForElement(Rule visitor) {
    _forForElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFormalParameterList(Rule visitor) {
    _forFormalParameterList
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForPartsWithDeclarations(Rule visitor) {
    _forForPartsWithDeclarations
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForPartsWithExpression(Rule visitor) {
    _forForPartsWithExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForStatement(Rule visitor) {
    _forForStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionDeclaration(Rule visitor) {
    _forFunctionDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionDeclarationStatement(Rule visitor) {
    _forFunctionDeclarationStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionExpression(Rule visitor) {
    _forFunctionExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionExpressionInvocation(Rule visitor) {
    _forFunctionExpressionInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionReference(Rule visitor) {
    _forFunctionReference.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionTypeAlias(Rule visitor) {
    _forFunctionTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionTypedFormalParameter(Rule visitor) {
    _forFunctionTypedFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addGenericFunctionType(Rule visitor) {
    _forGenericFunctionType
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addGenericTypeAlias(Rule visitor) {
    _forGenericTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addHideClause(Rule visitor) {
    _forHideClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addHideCombinator(Rule visitor) {
    _forHideCombinator.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIfElement(Rule visitor) {
    _forIfElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIfStatement(Rule visitor) {
    _forIfStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImplementsClause(Rule visitor) {
    _forImplementsClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImplicitCallReference(Rule visitor) {
    _forImplicitCallReference
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImportDirective(Rule visitor) {
    _forImportDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIndexExpression(Rule visitor) {
    _forIndexExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInstanceCreationExpression(Rule visitor) {
    _forInstanceCreationExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIntegerLiteral(Rule visitor) {
    _forIntegerLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInterpolationExpression(Rule visitor) {
    _forInterpolationExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInterpolationString(Rule visitor) {
    _forInterpolationString
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIsExpression(Rule visitor) {
    _forIsExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLabel(Rule visitor) {
    _forLabel.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLabeledStatement(Rule visitor) {
    _forLabeledStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryAugmentationDirective(Rule visitor) {
    _forLibraryAugmentationDirective
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryDirective(Rule visitor) {
    _forLibraryDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryIdentifier(Rule visitor) {
    _forLibraryIdentifier.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addListLiteral(Rule visitor) {
    _forListLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMapLiteralEntry(Rule visitor) {
    _forMapLiteralEntry.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMethodDeclaration(Rule visitor) {
    _forMethodDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMethodInvocation(Rule visitor) {
    _forMethodInvocation.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMixinDeclaration(Rule visitor) {
    _forMixinDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNamedExpression(Rule visitor) {
    _forNamedExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNamedType(Rule visitor) {
    _forNamedType.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNativeClause(Rule visitor) {
    _forNativeClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNativeFunctionBody(Rule visitor) {
    _forNativeFunctionBody
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNullLiteral(Rule visitor) {
    _forNullLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addOnClause(Rule visitor) {
    _forOnClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addParenthesizedExpression(Rule visitor) {
    _forParenthesizedExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPartDirective(Rule visitor) {
    _forPartDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPartOfDirective(Rule visitor) {
    _forPartOfDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPostfixExpression(Rule visitor) {
    _forPostfixExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPrefixedIdentifier(Rule visitor) {
    _forPrefixedIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPrefixExpression(Rule visitor) {
    _forPrefixExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPropertyAccess(Rule visitor) {
    _forPropertyAccess.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  // void addRecordLiteral(LintError linter, SidecarAstVisitor visitor) {
  //   _forRecordLiterals.add(VisitorSubscription(visitor, _getTimer(visitor)));
  // }

  void addRedirectingConstructorInvocation(Rule visitor) {
    _forRedirectingConstructorInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addRethrowExpression(Rule visitor) {
    _forRethrowExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addReturnStatement(Rule visitor) {
    _forReturnStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addScriptTag(Rule visitor) {
    _forScriptTag.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSetOrMapLiteral(Rule visitor) {
    _forSetOrMapLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowClause(Rule visitor) {
    _forShowClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowCombinator(Rule visitor) {
    _forShowCombinator.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowHideElement(Rule visitor) {
    _forShowHideElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleFormalParameter(Rule visitor) {
    _forSimpleFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleIdentifier(Rule visitor) {
    _forSimpleIdentifier.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleStringLiteral(Rule visitor) {
    _forSimpleStringLiteral
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSpreadElement(Rule visitor) {
    _forSpreadElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addStringInterpolation(Rule visitor) {
    _forStringInterpolation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperConstructorInvocation(Rule visitor) {
    _forSuperConstructorInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperExpression(Rule visitor) {
    _forSuperExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperFormalParameter(Rule visitor) {
    _forSuperFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchCase(Rule visitor) {
    _forSwitchCase.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchDefault(Rule visitor) {
    _forSwitchDefault.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchStatement(Rule visitor) {
    _forSwitchStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSymbolLiteral(Rule visitor) {
    _forSymbolLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addThisExpression(Rule visitor) {
    _forThisExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addThrowExpression(Rule visitor) {
    _forThrowExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTopLevelVariableDeclaration(Rule visitor) {
    _forTopLevelVariableDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTryStatement(Rule visitor) {
    _forTryStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeArgumentList(Rule visitor) {
    _forTypeArgumentList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeLiteral(Rule visitor) {
    _forTypeLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  @Deprecated('Use addNamedType() instead')
  void addTypeName(Rule visitor) {
    addNamedType(visitor);
  }

  void addTypeParameter(Rule visitor) {
    _forTypeParameter.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeParameterList(Rule visitor) {
    _forTypeParameterList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclaration(Rule visitor) {
    _forVariableDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclarationList(Rule visitor) {
    _forVariableDeclarationList
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclarationStatement(Rule visitor) {
    _forVariableDeclarationStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addWhileStatement(Rule visitor) {
    _forWhileStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addWithClause(Rule visitor) {
    _forWithClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

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
