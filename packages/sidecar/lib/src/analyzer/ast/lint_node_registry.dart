part of 'general_visitor.dart';

class NodeRegistry {
  NodeRegistry();
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

  void addAdjacentStrings(LintRule linter, SidecarVisitor visitor) {
    _forAdjacentStrings
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAnnotation(LintRule linter, SidecarVisitor visitor) {
    _forAnnotation.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addArgumentList(LintRule linter, SidecarVisitor visitor) {
    _forArgumentList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAsExpression(LintRule linter, SidecarVisitor visitor) {
    _forAsExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAssertInitializer(LintRule linter, SidecarVisitor visitor) {
    _forAssertInitializer
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAssertStatement(LintRule linter, SidecarVisitor visitor) {
    _forAssertStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAssignmentExpression(LintRule linter, SidecarVisitor visitor) {
    _forAssignmentExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAugmentationImportDirective(LintRule linter, SidecarVisitor visitor) {
    _forAugmentationImportDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addAwaitExpression(LintRule linter, SidecarVisitor visitor) {
    _forAwaitExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBinaryExpression(LintRule linter, SidecarVisitor visitor) {
    _forBinaryExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBlock(LintRule linter, SidecarVisitor visitor) {
    _forBlock.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBlockFunctionBody(LintRule linter, SidecarVisitor visitor) {
    _forBlockFunctionBody
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBooleanLiteral(LintRule linter, SidecarVisitor visitor) {
    _forBooleanLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addBreakStatement(LintRule linter, SidecarVisitor visitor) {
    _forBreakStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCascadeExpression(LintRule linter, SidecarVisitor visitor) {
    _forCascadeExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCatchClause(LintRule linter, SidecarVisitor visitor) {
    _forCatchClause
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCatchClauseParameter(LintRule linter, SidecarVisitor visitor) {
    _forCatchClauseParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addClassDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forClassDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addClassTypeAlias(LintRule linter, SidecarVisitor visitor) {
    _forClassTypeAlias
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addComment(LintRule linter, SidecarVisitor visitor) {
    _forComment.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCommentReference(LintRule linter, SidecarVisitor visitor) {
    _forCommentReference
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addCompilationUnit(LintRule linter, SidecarVisitor visitor) {
    _forCompilationUnit
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConditionalExpression(LintRule linter, SidecarVisitor visitor) {
    _forConditionalExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConfiguration(LintRule linter, SidecarVisitor visitor) {
    _forConfiguration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forConstructorDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorFieldInitializer(LintRule linter, SidecarVisitor visitor) {
    _forConstructorFieldInitializer
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorName(LintRule linter, SidecarVisitor visitor) {
    _forConstructorName
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorReference(LintRule linter, SidecarVisitor visitor) {
    _forConstructorReference
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addConstructorSelector(LintRule linter, SidecarVisitor visitor) {
    _forConstructorSelector
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addContinueStatement(LintRule linter, SidecarVisitor visitor) {
    _forContinueStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDeclaredIdentifier(LintRule linter, SidecarVisitor visitor) {
    _forDeclaredIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDefaultFormalParameter(LintRule linter, SidecarVisitor visitor) {
    _forDefaultFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDoStatement(LintRule linter, SidecarVisitor visitor) {
    _forDoStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDottedName(LintRule linter, SidecarVisitor visitor) {
    _forDottedName.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addDoubleLiteral(LintRule linter, SidecarVisitor visitor) {
    _forDoubleLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEmptyFunctionBody(LintRule linter, SidecarVisitor visitor) {
    _forEmptyFunctionBody
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEmptyStatement(LintRule linter, SidecarVisitor visitor) {
    _forEmptyStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEnumConstantArguments(LintRule linter, SidecarVisitor visitor) {
    _forEnumConstantArguments
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEnumConstantDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forEnumConstantDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addEnumDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forEnumDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExportDirective(LintRule linter, SidecarVisitor visitor) {
    _forExportDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExpressionFunctionBody(LintRule linter, SidecarVisitor visitor) {
    _forExpressionFunctionBody
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExpressionStatement(LintRule linter, SidecarVisitor visitor) {
    _forExpressionStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExtendsClause(LintRule linter, SidecarVisitor visitor) {
    _forExtendsClause
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExtensionDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forExtensionDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addExtensionOverride(LintRule linter, SidecarVisitor visitor) {
    _forExtensionOverride
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFieldDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forFieldDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFieldFormalParameter(LintRule linter, SidecarVisitor visitor) {
    _forFieldFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForEachPartsWithDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forForEachPartsWithDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForEachPartsWithIdentifier(LintRule linter, SidecarVisitor visitor) {
    _forForEachPartsWithIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForElement(LintRule linter, SidecarVisitor visitor) {
    _forForElement.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFormalParameterList(LintRule linter, SidecarVisitor visitor) {
    _forFormalParameterList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForPartsWithDeclarations(LintRule linter, SidecarVisitor visitor) {
    _forForPartsWithDeclarations
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForPartsWithExpression(LintRule linter, SidecarVisitor visitor) {
    _forForPartsWithExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addForStatement(LintRule linter, SidecarVisitor visitor) {
    _forForStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forFunctionDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionDeclarationStatement(
      LintRule linter, SidecarVisitor visitor) {
    _forFunctionDeclarationStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionExpression(LintRule linter, SidecarVisitor visitor) {
    _forFunctionExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionExpressionInvocation(
      LintRule linter, SidecarVisitor visitor) {
    _forFunctionExpressionInvocation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionReference(LintRule linter, SidecarVisitor visitor) {
    _forFunctionReference
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionTypeAlias(LintRule linter, SidecarVisitor visitor) {
    _forFunctionTypeAlias
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addFunctionTypedFormalParameter(
      LintRule linter, SidecarVisitor visitor) {
    _forFunctionTypedFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addGenericFunctionType(LintRule linter, SidecarVisitor visitor) {
    _forGenericFunctionType
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addGenericTypeAlias(LintRule linter, SidecarVisitor visitor) {
    _forGenericTypeAlias
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addHideClause(LintRule linter, SidecarVisitor visitor) {
    _forHideClause.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addHideCombinator(LintRule linter, SidecarVisitor visitor) {
    _forHideCombinator
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIfElement(LintRule linter, SidecarVisitor visitor) {
    _forIfElement.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIfStatement(LintRule linter, SidecarVisitor visitor) {
    _forIfStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addImplementsClause(LintRule linter, SidecarVisitor visitor) {
    _forImplementsClause
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addImplicitCallReference(LintRule linter, SidecarVisitor visitor) {
    _forImplicitCallReference
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addImportDirective(LintRule linter, SidecarVisitor visitor) {
    _forImportDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIndexExpression(LintRule linter, SidecarVisitor visitor) {
    _forIndexExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addInstanceCreationExpression(LintRule linter, SidecarVisitor visitor) {
    _forInstanceCreationExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIntegerLiteral(LintRule linter, SidecarVisitor visitor) {
    _forIntegerLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addInterpolationExpression(LintRule linter, SidecarVisitor visitor) {
    _forInterpolationExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addInterpolationString(LintRule linter, SidecarVisitor visitor) {
    _forInterpolationString
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addIsExpression(LintRule linter, SidecarVisitor visitor) {
    _forIsExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLabel(LintRule linter, SidecarVisitor visitor) {
    _forLabel.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLabeledStatement(LintRule linter, SidecarVisitor visitor) {
    _forLabeledStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLibraryAugmentationDirective(
      LintRule linter, SidecarVisitor visitor) {
    _forLibraryAugmentationDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLibraryDirective(LintRule linter, SidecarVisitor visitor) {
    _forLibraryDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addLibraryIdentifier(LintRule linter, SidecarVisitor visitor) {
    _forLibraryIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addListLiteral(LintRule linter, SidecarVisitor visitor) {
    _forListLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addMapLiteralEntry(LintRule linter, SidecarVisitor visitor) {
    _forMapLiteralEntry
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addMethodDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forMethodDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addMethodInvocation(LintRule linter, SidecarVisitor visitor) {
    _forMethodInvocation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addMixinDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forMixinDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNamedExpression(LintRule linter, SidecarVisitor visitor) {
    _forNamedExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNamedType(LintRule linter, SidecarVisitor visitor) {
    _forNamedType.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNativeClause(LintRule linter, SidecarVisitor visitor) {
    _forNativeClause
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNativeFunctionBody(LintRule linter, SidecarVisitor visitor) {
    _forNativeFunctionBody
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addNullLiteral(LintRule linter, SidecarVisitor visitor) {
    _forNullLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addOnClause(LintRule linter, SidecarVisitor visitor) {
    _forOnClause.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addParenthesizedExpression(LintRule linter, SidecarVisitor visitor) {
    _forParenthesizedExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPartDirective(LintRule linter, SidecarVisitor visitor) {
    _forPartDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPartOfDirective(LintRule linter, SidecarVisitor visitor) {
    _forPartOfDirective
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPostfixExpression(LintRule linter, SidecarVisitor visitor) {
    _forPostfixExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPrefixedIdentifier(LintRule linter, SidecarVisitor visitor) {
    _forPrefixedIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPrefixExpression(LintRule linter, SidecarVisitor visitor) {
    _forPrefixExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addPropertyAccess(LintRule linter, SidecarVisitor visitor) {
    _forPropertyAccess
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  // void addRecordLiteral(LintError linter, SidecarVisitor visitor) {
  //   _forRecordLiterals.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  // }

  void addRedirectingConstructorInvocation(
      LintRule linter, SidecarVisitor visitor) {
    _forRedirectingConstructorInvocation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addRethrowExpression(LintRule linter, SidecarVisitor visitor) {
    _forRethrowExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addReturnStatement(LintRule linter, SidecarVisitor visitor) {
    _forReturnStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addScriptTag(LintRule linter, SidecarVisitor visitor) {
    _forScriptTag.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSetOrMapLiteral(LintRule linter, SidecarVisitor visitor) {
    _forSetOrMapLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addShowClause(LintRule linter, SidecarVisitor visitor) {
    _forShowClause.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addShowCombinator(LintRule linter, SidecarVisitor visitor) {
    _forShowCombinator
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addShowHideElement(LintRule linter, SidecarVisitor visitor) {
    _forShowHideElement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSimpleFormalParameter(LintRule linter, SidecarVisitor visitor) {
    _forSimpleFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSimpleIdentifier(LintRule linter, SidecarVisitor visitor) {
    _forSimpleIdentifier
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSimpleStringLiteral(LintRule linter, SidecarVisitor visitor) {
    _forSimpleStringLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSpreadElement(LintRule linter, SidecarVisitor visitor) {
    _forSpreadElement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addStringInterpolation(LintRule linter, SidecarVisitor visitor) {
    _forStringInterpolation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSuperConstructorInvocation(LintRule linter, SidecarVisitor visitor) {
    _forSuperConstructorInvocation
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSuperExpression(LintRule linter, SidecarVisitor visitor) {
    _forSuperExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSuperFormalParameter(LintRule linter, SidecarVisitor visitor) {
    _forSuperFormalParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSwitchCase(LintRule linter, SidecarVisitor visitor) {
    _forSwitchCase.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSwitchDefault(LintRule linter, SidecarVisitor visitor) {
    _forSwitchDefault
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSwitchStatement(LintRule linter, SidecarVisitor visitor) {
    _forSwitchStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addSymbolLiteral(LintRule linter, SidecarVisitor visitor) {
    _forSymbolLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addThisExpression(LintRule linter, SidecarVisitor visitor) {
    _forThisExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addThrowExpression(LintRule linter, SidecarVisitor visitor) {
    _forThrowExpression
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTopLevelVariableDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forTopLevelVariableDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTryStatement(LintRule linter, SidecarVisitor visitor) {
    _forTryStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTypeArgumentList(LintRule linter, SidecarVisitor visitor) {
    _forTypeArgumentList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTypeLiteral(LintRule linter, SidecarVisitor visitor) {
    _forTypeLiteral
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  @Deprecated('Use addNamedType() instead')
  void addTypeName(LintRule linter, SidecarVisitor visitor) {
    addNamedType(linter, visitor);
  }

  void addTypeParameter(LintRule linter, SidecarVisitor visitor) {
    _forTypeParameter
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addTypeParameterList(LintRule linter, SidecarVisitor visitor) {
    _forTypeParameterList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addVariableDeclaration(LintRule linter, SidecarVisitor visitor) {
    _forVariableDeclaration
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addVariableDeclarationList(LintRule linter, SidecarVisitor visitor) {
    _forVariableDeclarationList
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addVariableDeclarationStatement(
      LintRule linter, SidecarVisitor visitor) {
    _forVariableDeclarationStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addWhileStatement(LintRule linter, SidecarVisitor visitor) {
    _forWhileStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addWithClause(LintRule linter, SidecarVisitor visitor) {
    _forWithClause.add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  void addYieldStatement(LintRule linter, SidecarVisitor visitor) {
    _forYieldStatement
        .add(VisitorSubscription(linter, visitor, _getTimer(linter)));
  }

  /// Get the timer associated with the given [linter].
  Stopwatch? _getTimer(LintRule linter) {
    // if (enableTiming) {
    //   return registry.getTimer(linter);
    // } else {
    //   return null;
    // }
    return null;
  }
}
