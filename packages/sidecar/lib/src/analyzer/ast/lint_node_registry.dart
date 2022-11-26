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
  final List<VisitorSubscription<AstNode>> _forNode = [];

  void addNode(SidecarVisitor visitor) {
    _forNode.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAdjacentStrings(SidecarVisitor visitor) {
    _forAdjacentStrings.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAnnotation(SidecarVisitor visitor) {
    _forAnnotation.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addArgumentList(SidecarVisitor visitor) {
    _forArgumentList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAsExpression(SidecarVisitor visitor) {
    _forAsExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssertInitializer(SidecarVisitor visitor) {
    _forAssertInitializer.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssertStatement(SidecarVisitor visitor) {
    _forAssertStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssignmentExpression(SidecarVisitor visitor) {
    _forAssignmentExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAugmentationImportDirective(SidecarVisitor visitor) {
    _forAugmentationImportDirective
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAwaitExpression(SidecarVisitor visitor) {
    _forAwaitExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBinaryExpression(SidecarVisitor visitor) {
    _forBinaryExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBlock(SidecarVisitor visitor) {
    _forBlock.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBlockFunctionBody(SidecarVisitor visitor) {
    _forBlockFunctionBody.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBooleanLiteral(SidecarVisitor visitor) {
    _forBooleanLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBreakStatement(SidecarVisitor visitor) {
    _forBreakStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCascadeExpression(SidecarVisitor visitor) {
    _forCascadeExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCatchClause(SidecarVisitor visitor) {
    _forCatchClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCatchClauseParameter(SidecarVisitor visitor) {
    _forCatchClauseParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addClassDeclaration(SidecarVisitor visitor) {
    _forClassDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addClassTypeAlias(SidecarVisitor visitor) {
    _forClassTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addComment(SidecarVisitor visitor) {
    _forComment.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCommentReference(SidecarVisitor visitor) {
    _forCommentReference.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCompilationUnit(SidecarVisitor visitor) {
    _forCompilationUnit.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConditionalExpression(SidecarVisitor visitor) {
    _forConditionalExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConfiguration(SidecarVisitor visitor) {
    _forConfiguration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorDeclaration(SidecarVisitor visitor) {
    _forConstructorDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorFieldInitializer(SidecarVisitor visitor) {
    _forConstructorFieldInitializer
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorName(SidecarVisitor visitor) {
    _forConstructorName.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorReference(SidecarVisitor visitor) {
    _forConstructorReference
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorSelector(SidecarVisitor visitor) {
    _forConstructorSelector
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addContinueStatement(SidecarVisitor visitor) {
    _forContinueStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDeclaredIdentifier(SidecarVisitor visitor) {
    _forDeclaredIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDefaultFormalParameter(SidecarVisitor visitor) {
    _forDefaultFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDoStatement(SidecarVisitor visitor) {
    _forDoStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDottedName(SidecarVisitor visitor) {
    _forDottedName.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDoubleLiteral(SidecarVisitor visitor) {
    _forDoubleLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEmptyFunctionBody(SidecarVisitor visitor) {
    _forEmptyFunctionBody.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEmptyStatement(SidecarVisitor visitor) {
    _forEmptyStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumConstantArguments(SidecarVisitor visitor) {
    _forEnumConstantArguments
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumConstantDeclaration(SidecarVisitor visitor) {
    _forEnumConstantDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumDeclaration(SidecarVisitor visitor) {
    _forEnumDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExportDirective(SidecarVisitor visitor) {
    _forExportDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExpressionFunctionBody(SidecarVisitor visitor) {
    _forExpressionFunctionBody
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExpressionStatement(SidecarVisitor visitor) {
    _forExpressionStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtendsClause(SidecarVisitor visitor) {
    _forExtendsClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtensionDeclaration(SidecarVisitor visitor) {
    _forExtensionDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtensionOverride(SidecarVisitor visitor) {
    _forExtensionOverride.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFieldDeclaration(SidecarVisitor visitor) {
    _forFieldDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFieldFormalParameter(SidecarVisitor visitor) {
    _forFieldFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForEachPartsWithDeclaration(SidecarVisitor visitor) {
    _forForEachPartsWithDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForEachPartsWithIdentifier(SidecarVisitor visitor) {
    _forForEachPartsWithIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForElement(SidecarVisitor visitor) {
    _forForElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFormalParameterList(SidecarVisitor visitor) {
    _forFormalParameterList
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForPartsWithDeclarations(SidecarVisitor visitor) {
    _forForPartsWithDeclarations
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForPartsWithExpression(SidecarVisitor visitor) {
    _forForPartsWithExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForStatement(SidecarVisitor visitor) {
    _forForStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionDeclaration(SidecarVisitor visitor) {
    _forFunctionDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionDeclarationStatement(SidecarVisitor visitor) {
    _forFunctionDeclarationStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionExpression(SidecarVisitor visitor) {
    _forFunctionExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionExpressionInvocation(SidecarVisitor visitor) {
    _forFunctionExpressionInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionReference(SidecarVisitor visitor) {
    _forFunctionReference.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionTypeAlias(SidecarVisitor visitor) {
    _forFunctionTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionTypedFormalParameter(SidecarVisitor visitor) {
    _forFunctionTypedFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addGenericFunctionType(SidecarVisitor visitor) {
    _forGenericFunctionType
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addGenericTypeAlias(SidecarVisitor visitor) {
    _forGenericTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addHideClause(SidecarVisitor visitor) {
    _forHideClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addHideCombinator(SidecarVisitor visitor) {
    _forHideCombinator.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIfElement(SidecarVisitor visitor) {
    _forIfElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIfStatement(SidecarVisitor visitor) {
    _forIfStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImplementsClause(SidecarVisitor visitor) {
    _forImplementsClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImplicitCallReference(SidecarVisitor visitor) {
    _forImplicitCallReference
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImportDirective(SidecarVisitor visitor) {
    _forImportDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIndexExpression(SidecarVisitor visitor) {
    _forIndexExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInstanceCreationExpression(SidecarVisitor visitor) {
    _forInstanceCreationExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIntegerLiteral(SidecarVisitor visitor) {
    _forIntegerLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInterpolationExpression(SidecarVisitor visitor) {
    _forInterpolationExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInterpolationString(SidecarVisitor visitor) {
    _forInterpolationString
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIsExpression(SidecarVisitor visitor) {
    _forIsExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLabel(SidecarVisitor visitor) {
    _forLabel.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLabeledStatement(SidecarVisitor visitor) {
    _forLabeledStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryAugmentationDirective(SidecarVisitor visitor) {
    _forLibraryAugmentationDirective
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryDirective(SidecarVisitor visitor) {
    _forLibraryDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryIdentifier(SidecarVisitor visitor) {
    _forLibraryIdentifier.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addListLiteral(SidecarVisitor visitor) {
    _forListLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMapLiteralEntry(SidecarVisitor visitor) {
    _forMapLiteralEntry.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMethodDeclaration(SidecarVisitor visitor) {
    _forMethodDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMethodInvocation(SidecarVisitor visitor) {
    _forMethodInvocation.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMixinDeclaration(SidecarVisitor visitor) {
    _forMixinDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNamedExpression(SidecarVisitor visitor) {
    _forNamedExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNamedType(SidecarVisitor visitor) {
    _forNamedType.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNativeClause(SidecarVisitor visitor) {
    _forNativeClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNativeFunctionBody(SidecarVisitor visitor) {
    _forNativeFunctionBody
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNullLiteral(SidecarVisitor visitor) {
    _forNullLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addOnClause(SidecarVisitor visitor) {
    _forOnClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addParenthesizedExpression(SidecarVisitor visitor) {
    _forParenthesizedExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPartDirective(SidecarVisitor visitor) {
    _forPartDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPartOfDirective(SidecarVisitor visitor) {
    _forPartOfDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPostfixExpression(SidecarVisitor visitor) {
    _forPostfixExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPrefixedIdentifier(SidecarVisitor visitor) {
    _forPrefixedIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPrefixExpression(SidecarVisitor visitor) {
    _forPrefixExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPropertyAccess(SidecarVisitor visitor) {
    _forPropertyAccess.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  // void addRecordLiteral(LintError linter, SidecarVisitor visitor) {
  //   _forRecordLiterals.add(VisitorSubscription(visitor, _getTimer(visitor)));
  // }

  void addRedirectingConstructorInvocation(SidecarVisitor visitor) {
    _forRedirectingConstructorInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addRethrowExpression(SidecarVisitor visitor) {
    _forRethrowExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addReturnStatement(SidecarVisitor visitor) {
    _forReturnStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addScriptTag(SidecarVisitor visitor) {
    _forScriptTag.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSetOrMapLiteral(SidecarVisitor visitor) {
    _forSetOrMapLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowClause(SidecarVisitor visitor) {
    _forShowClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowCombinator(SidecarVisitor visitor) {
    _forShowCombinator.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowHideElement(SidecarVisitor visitor) {
    _forShowHideElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleFormalParameter(SidecarVisitor visitor) {
    _forSimpleFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleIdentifier(SidecarVisitor visitor) {
    _forSimpleIdentifier.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleStringLiteral(SidecarVisitor visitor) {
    _forSimpleStringLiteral
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSpreadElement(SidecarVisitor visitor) {
    _forSpreadElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addStringInterpolation(SidecarVisitor visitor) {
    _forStringInterpolation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperConstructorInvocation(SidecarVisitor visitor) {
    _forSuperConstructorInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperExpression(SidecarVisitor visitor) {
    _forSuperExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperFormalParameter(SidecarVisitor visitor) {
    _forSuperFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchCase(SidecarVisitor visitor) {
    _forSwitchCase.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchDefault(SidecarVisitor visitor) {
    _forSwitchDefault.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchStatement(SidecarVisitor visitor) {
    _forSwitchStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSymbolLiteral(SidecarVisitor visitor) {
    _forSymbolLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addThisExpression(SidecarVisitor visitor) {
    _forThisExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addThrowExpression(SidecarVisitor visitor) {
    _forThrowExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTopLevelVariableDeclaration(SidecarVisitor visitor) {
    _forTopLevelVariableDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTryStatement(SidecarVisitor visitor) {
    _forTryStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeArgumentList(SidecarVisitor visitor) {
    _forTypeArgumentList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeLiteral(SidecarVisitor visitor) {
    _forTypeLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  @Deprecated('Use addNamedType() instead')
  void addTypeName(SidecarVisitor visitor) {
    addNamedType(visitor);
  }

  void addTypeParameter(SidecarVisitor visitor) {
    _forTypeParameter.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeParameterList(SidecarVisitor visitor) {
    _forTypeParameterList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclaration(SidecarVisitor visitor) {
    _forVariableDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclarationList(SidecarVisitor visitor) {
    _forVariableDeclarationList
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclarationStatement(SidecarVisitor visitor) {
    _forVariableDeclarationStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addWhileStatement(SidecarVisitor visitor) {
    _forWhileStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addWithClause(SidecarVisitor visitor) {
    _forWithClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addYieldStatement(SidecarVisitor linter) {
    _forYieldStatement.add(VisitorSubscription(linter, _getTimer(linter)));
  }

  /// Get the timer associated with the given [linter].
  Stopwatch? _getTimer(SidecarVisitor linter) {
    // if (enableTiming) {
    //   return registry.getTimer(linter);
    // } else {
    //   return null;
    // }
    return null;
  }
}
