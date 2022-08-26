part of 'general_visitor.dart';

class NodeLintRegistry {
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

  NodeLintRegistry();

  void addAdjacentStrings(LintError linter, AstVisitor visitor) {
    _forAdjacentStrings
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAnnotation(LintError linter, AstVisitor visitor) {
    _forAnnotation.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addArgumentList(LintError linter, AstVisitor visitor) {
    _forArgumentList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAsExpression(LintError linter, AstVisitor visitor) {
    _forAsExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAssertInitializer(LintError linter, AstVisitor visitor) {
    _forAssertInitializer
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAssertStatement(LintError linter, AstVisitor visitor) {
    _forAssertStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAssignmentExpression(LintError linter, AstVisitor visitor) {
    _forAssignmentExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAugmentationImportDirective(LintError linter, AstVisitor visitor) {
    _forAugmentationImportDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAwaitExpression(LintError linter, AstVisitor visitor) {
    _forAwaitExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBinaryExpression(LintError linter, AstVisitor visitor) {
    _forBinaryExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBlock(LintError linter, AstVisitor visitor) {
    _forBlock.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBlockFunctionBody(LintError linter, AstVisitor visitor) {
    _forBlockFunctionBody
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBooleanLiteral(LintError linter, AstVisitor visitor) {
    _forBooleanLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBreakStatement(LintError linter, AstVisitor visitor) {
    _forBreakStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCascadeExpression(LintError linter, AstVisitor visitor) {
    _forCascadeExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCatchClause(LintError linter, AstVisitor visitor) {
    _forCatchClause
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCatchClauseParameter(LintError linter, AstVisitor visitor) {
    _forCatchClauseParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addClassDeclaration(LintError linter, AstVisitor visitor) {
    _forClassDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addClassTypeAlias(LintError linter, AstVisitor visitor) {
    _forClassTypeAlias
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addComment(LintError linter, AstVisitor visitor) {
    _forComment.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCommentReference(LintError linter, AstVisitor visitor) {
    _forCommentReference
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCompilationUnit(LintError linter, AstVisitor visitor) {
    _forCompilationUnit
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConditionalExpression(LintError linter, AstVisitor visitor) {
    _forConditionalExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConfiguration(LintError linter, AstVisitor visitor) {
    _forConfiguration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorDeclaration(LintError linter, AstVisitor visitor) {
    _forConstructorDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorFieldInitializer(LintError linter, AstVisitor visitor) {
    _forConstructorFieldInitializer
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorName(LintError linter, AstVisitor visitor) {
    _forConstructorName
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorReference(LintError linter, AstVisitor visitor) {
    _forConstructorReference
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorSelector(LintError linter, AstVisitor visitor) {
    _forConstructorSelector
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addContinueStatement(LintError linter, AstVisitor visitor) {
    _forContinueStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDeclaredIdentifier(LintError linter, AstVisitor visitor) {
    _forDeclaredIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDefaultFormalParameter(LintError linter, AstVisitor visitor) {
    _forDefaultFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDoStatement(LintError linter, AstVisitor visitor) {
    _forDoStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDottedName(LintError linter, AstVisitor visitor) {
    _forDottedName.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDoubleLiteral(LintError linter, AstVisitor visitor) {
    _forDoubleLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEmptyFunctionBody(LintError linter, AstVisitor visitor) {
    _forEmptyFunctionBody
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEmptyStatement(LintError linter, AstVisitor visitor) {
    _forEmptyStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEnumConstantArguments(LintError linter, AstVisitor visitor) {
    _forEnumConstantArguments
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEnumConstantDeclaration(LintError linter, AstVisitor visitor) {
    _forEnumConstantDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEnumDeclaration(LintError linter, AstVisitor visitor) {
    _forEnumDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExportDirective(LintError linter, AstVisitor visitor) {
    _forExportDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExpressionFunctionBody(LintError linter, AstVisitor visitor) {
    _forExpressionFunctionBody
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExpressionStatement(LintError linter, AstVisitor visitor) {
    _forExpressionStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExtendsClause(LintError linter, AstVisitor visitor) {
    _forExtendsClause
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExtensionDeclaration(LintError linter, AstVisitor visitor) {
    _forExtensionDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExtensionOverride(LintError linter, AstVisitor visitor) {
    _forExtensionOverride
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFieldDeclaration(LintError linter, AstVisitor visitor) {
    _forFieldDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFieldFormalParameter(LintError linter, AstVisitor visitor) {
    _forFieldFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForEachPartsWithDeclaration(LintError linter, AstVisitor visitor) {
    _forForEachPartsWithDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForEachPartsWithIdentifier(LintError linter, AstVisitor visitor) {
    _forForEachPartsWithIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForElement(LintError linter, AstVisitor visitor) {
    _forForElement.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFormalParameterList(LintError linter, AstVisitor visitor) {
    _forFormalParameterList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForPartsWithDeclarations(LintError linter, AstVisitor visitor) {
    _forForPartsWithDeclarations
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForPartsWithExpression(LintError linter, AstVisitor visitor) {
    _forForPartsWithExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForStatement(LintError linter, AstVisitor visitor) {
    _forForStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionDeclaration(LintError linter, AstVisitor visitor) {
    _forFunctionDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionDeclarationStatement(LintError linter, AstVisitor visitor) {
    _forFunctionDeclarationStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionExpression(LintError linter, AstVisitor visitor) {
    _forFunctionExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionExpressionInvocation(LintError linter, AstVisitor visitor) {
    _forFunctionExpressionInvocation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionReference(LintError linter, AstVisitor visitor) {
    _forFunctionReference
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionTypeAlias(LintError linter, AstVisitor visitor) {
    _forFunctionTypeAlias
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionTypedFormalParameter(LintError linter, AstVisitor visitor) {
    _forFunctionTypedFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addGenericFunctionType(LintError linter, AstVisitor visitor) {
    _forGenericFunctionType
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addGenericTypeAlias(LintError linter, AstVisitor visitor) {
    _forGenericTypeAlias
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addHideClause(LintError linter, AstVisitor visitor) {
    _forHideClause.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addHideCombinator(LintError linter, AstVisitor visitor) {
    _forHideCombinator
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIfElement(LintError linter, AstVisitor visitor) {
    _forIfElement.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIfStatement(LintError linter, AstVisitor visitor) {
    _forIfStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addImplementsClause(LintError linter, AstVisitor visitor) {
    _forImplementsClause
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addImplicitCallReference(LintError linter, AstVisitor visitor) {
    _forImplicitCallReference
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addImportDirective(LintError linter, AstVisitor visitor) {
    _forImportDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIndexExpression(LintError linter, AstVisitor visitor) {
    _forIndexExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addInstanceCreationExpression(LintError linter, AstVisitor visitor) {
    _forInstanceCreationExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIntegerLiteral(LintError linter, AstVisitor visitor) {
    _forIntegerLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addInterpolationExpression(LintError linter, AstVisitor visitor) {
    _forInterpolationExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addInterpolationString(LintError linter, AstVisitor visitor) {
    _forInterpolationString
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIsExpression(LintError linter, AstVisitor visitor) {
    _forIsExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLabel(LintError linter, AstVisitor visitor) {
    _forLabel.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLabeledStatement(LintError linter, AstVisitor visitor) {
    _forLabeledStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLibraryAugmentationDirective(LintError linter, AstVisitor visitor) {
    _forLibraryAugmentationDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLibraryDirective(LintError linter, AstVisitor visitor) {
    _forLibraryDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLibraryIdentifier(LintError linter, AstVisitor visitor) {
    _forLibraryIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addListLiteral(LintError linter, AstVisitor visitor) {
    _forListLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addMapLiteralEntry(LintError linter, AstVisitor visitor) {
    _forMapLiteralEntry
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addMethodDeclaration(LintError linter, AstVisitor visitor) {
    _forMethodDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addMethodInvocation(LintError linter, AstVisitor visitor) {
    _forMethodInvocation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addMixinDeclaration(LintError linter, AstVisitor visitor) {
    _forMixinDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNamedExpression(LintError linter, AstVisitor visitor) {
    _forNamedExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNamedType(LintError linter, AstVisitor visitor) {
    _forNamedType.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNativeClause(LintError linter, AstVisitor visitor) {
    _forNativeClause
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNativeFunctionBody(LintError linter, AstVisitor visitor) {
    _forNativeFunctionBody
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNullLiteral(LintError linter, AstVisitor visitor) {
    _forNullLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addOnClause(LintError linter, AstVisitor visitor) {
    _forOnClause.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addParenthesizedExpression(LintError linter, AstVisitor visitor) {
    _forParenthesizedExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPartDirective(LintError linter, AstVisitor visitor) {
    _forPartDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPartOfDirective(LintError linter, AstVisitor visitor) {
    _forPartOfDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPostfixExpression(LintError linter, AstVisitor visitor) {
    _forPostfixExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPrefixedIdentifier(LintError linter, AstVisitor visitor) {
    _forPrefixedIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPrefixExpression(LintError linter, AstVisitor visitor) {
    _forPrefixExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPropertyAccess(LintError linter, AstVisitor visitor) {
    _forPropertyAccess
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  // void addRecordLiteral(LintError linter, AstVisitor visitor) {
  //   _forRecordLiterals.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  // }

  void addRedirectingConstructorInvocation(
      LintError linter, AstVisitor visitor) {
    _forRedirectingConstructorInvocation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addRethrowExpression(LintError linter, AstVisitor visitor) {
    _forRethrowExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addReturnStatement(LintError linter, AstVisitor visitor) {
    _forReturnStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addScriptTag(LintError linter, AstVisitor visitor) {
    _forScriptTag.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSetOrMapLiteral(LintError linter, AstVisitor visitor) {
    _forSetOrMapLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addShowClause(LintError linter, AstVisitor visitor) {
    _forShowClause.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addShowCombinator(LintError linter, AstVisitor visitor) {
    _forShowCombinator
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addShowHideElement(LintError linter, AstVisitor visitor) {
    _forShowHideElement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSimpleFormalParameter(LintError linter, AstVisitor visitor) {
    _forSimpleFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSimpleIdentifier(LintError linter, AstVisitor visitor) {
    _forSimpleIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSimpleStringLiteral(LintError linter, AstVisitor visitor) {
    _forSimpleStringLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSpreadElement(LintError linter, AstVisitor visitor) {
    _forSpreadElement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addStringInterpolation(LintError linter, AstVisitor visitor) {
    _forStringInterpolation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSuperConstructorInvocation(LintError linter, AstVisitor visitor) {
    _forSuperConstructorInvocation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSuperExpression(LintError linter, AstVisitor visitor) {
    _forSuperExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSuperFormalParameter(LintError linter, AstVisitor visitor) {
    _forSuperFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSwitchCase(LintError linter, AstVisitor visitor) {
    _forSwitchCase.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSwitchDefault(LintError linter, AstVisitor visitor) {
    _forSwitchDefault
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSwitchStatement(LintError linter, AstVisitor visitor) {
    _forSwitchStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSymbolLiteral(LintError linter, AstVisitor visitor) {
    _forSymbolLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addThisExpression(LintError linter, AstVisitor visitor) {
    _forThisExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addThrowExpression(LintError linter, AstVisitor visitor) {
    _forThrowExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTopLevelVariableDeclaration(LintError linter, AstVisitor visitor) {
    _forTopLevelVariableDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTryStatement(LintError linter, AstVisitor visitor) {
    _forTryStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTypeArgumentList(LintError linter, AstVisitor visitor) {
    _forTypeArgumentList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTypeLiteral(LintError linter, AstVisitor visitor) {
    _forTypeLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  @Deprecated('Use addNamedType() instead')
  void addTypeName(LintError linter, AstVisitor visitor) {
    addNamedType(linter, visitor);
  }

  void addTypeParameter(LintError linter, AstVisitor visitor) {
    _forTypeParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTypeParameterList(LintError linter, AstVisitor visitor) {
    _forTypeParameterList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addVariableDeclaration(LintError linter, AstVisitor visitor) {
    _forVariableDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addVariableDeclarationList(LintError linter, AstVisitor visitor) {
    _forVariableDeclarationList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addVariableDeclarationStatement(LintError linter, AstVisitor visitor) {
    _forVariableDeclarationStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addWhileStatement(LintError linter, AstVisitor visitor) {
    _forWhileStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addWithClause(LintError linter, AstVisitor visitor) {
    _forWithClause.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addYieldStatement(LintError linter, AstVisitor visitor) {
    _forYieldStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  /// Get the timer associated with the given [linter].
  Stopwatch? _getTimer(LintError linter) {
    // if (enableTiming) {
    //   return registry.getTimer(linter);
    // } else {
    //   return null;
    // }
    return null;
  }
}
