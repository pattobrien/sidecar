// ignore_for_file: public_member_api_docs

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

  void addNode(SidecarAstVisitor visitor) {
    _forNode.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAdjacentStrings(SidecarAstVisitor visitor) {
    _forAdjacentStrings.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAnnotation(SidecarAstVisitor visitor) {
    _forAnnotation.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addArgumentList(SidecarAstVisitor visitor) {
    _forArgumentList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAsExpression(SidecarAstVisitor visitor) {
    _forAsExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssertInitializer(SidecarAstVisitor visitor) {
    _forAssertInitializer.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssertStatement(SidecarAstVisitor visitor) {
    _forAssertStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAssignmentExpression(SidecarAstVisitor visitor) {
    _forAssignmentExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAugmentationImportDirective(SidecarAstVisitor visitor) {
    _forAugmentationImportDirective
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addAwaitExpression(SidecarAstVisitor visitor) {
    _forAwaitExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBinaryExpression(SidecarAstVisitor visitor) {
    _forBinaryExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBlock(SidecarAstVisitor visitor) {
    _forBlock.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBlockFunctionBody(SidecarAstVisitor visitor) {
    _forBlockFunctionBody.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBooleanLiteral(SidecarAstVisitor visitor) {
    _forBooleanLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addBreakStatement(SidecarAstVisitor visitor) {
    _forBreakStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCascadeExpression(SidecarAstVisitor visitor) {
    _forCascadeExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCatchClause(SidecarAstVisitor visitor) {
    _forCatchClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCatchClauseParameter(SidecarAstVisitor visitor) {
    _forCatchClauseParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addClassDeclaration(SidecarAstVisitor visitor) {
    _forClassDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addClassTypeAlias(SidecarAstVisitor visitor) {
    _forClassTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addComment(SidecarAstVisitor visitor) {
    _forComment.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCommentReference(SidecarAstVisitor visitor) {
    _forCommentReference.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addCompilationUnit(SidecarAstVisitor visitor) {
    _forCompilationUnit.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConditionalExpression(SidecarAstVisitor visitor) {
    _forConditionalExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConfiguration(SidecarAstVisitor visitor) {
    _forConfiguration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorDeclaration(SidecarAstVisitor visitor) {
    _forConstructorDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorFieldInitializer(SidecarAstVisitor visitor) {
    _forConstructorFieldInitializer
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorName(SidecarAstVisitor visitor) {
    _forConstructorName.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorReference(SidecarAstVisitor visitor) {
    _forConstructorReference
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addConstructorSelector(SidecarAstVisitor visitor) {
    _forConstructorSelector
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addContinueStatement(SidecarAstVisitor visitor) {
    _forContinueStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDeclaredIdentifier(SidecarAstVisitor visitor) {
    _forDeclaredIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDefaultFormalParameter(SidecarAstVisitor visitor) {
    _forDefaultFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDoStatement(SidecarAstVisitor visitor) {
    _forDoStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDottedName(SidecarAstVisitor visitor) {
    _forDottedName.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addDoubleLiteral(SidecarAstVisitor visitor) {
    _forDoubleLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEmptyFunctionBody(SidecarAstVisitor visitor) {
    _forEmptyFunctionBody.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEmptyStatement(SidecarAstVisitor visitor) {
    _forEmptyStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumConstantArguments(SidecarAstVisitor visitor) {
    _forEnumConstantArguments
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumConstantDeclaration(SidecarAstVisitor visitor) {
    _forEnumConstantDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addEnumDeclaration(SidecarAstVisitor visitor) {
    _forEnumDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExportDirective(SidecarAstVisitor visitor) {
    _forExportDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExpressionFunctionBody(SidecarAstVisitor visitor) {
    _forExpressionFunctionBody
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExpressionStatement(SidecarAstVisitor visitor) {
    _forExpressionStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtendsClause(SidecarAstVisitor visitor) {
    _forExtendsClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtensionDeclaration(SidecarAstVisitor visitor) {
    _forExtensionDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addExtensionOverride(SidecarAstVisitor visitor) {
    _forExtensionOverride.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFieldDeclaration(SidecarAstVisitor visitor) {
    _forFieldDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFieldFormalParameter(SidecarAstVisitor visitor) {
    _forFieldFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForEachPartsWithDeclaration(SidecarAstVisitor visitor) {
    _forForEachPartsWithDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForEachPartsWithIdentifier(SidecarAstVisitor visitor) {
    _forForEachPartsWithIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForElement(SidecarAstVisitor visitor) {
    _forForElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFormalParameterList(SidecarAstVisitor visitor) {
    _forFormalParameterList
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForPartsWithDeclarations(SidecarAstVisitor visitor) {
    _forForPartsWithDeclarations
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForPartsWithExpression(SidecarAstVisitor visitor) {
    _forForPartsWithExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addForStatement(SidecarAstVisitor visitor) {
    _forForStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionDeclaration(SidecarAstVisitor visitor) {
    _forFunctionDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionDeclarationStatement(SidecarAstVisitor visitor) {
    _forFunctionDeclarationStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionExpression(SidecarAstVisitor visitor) {
    _forFunctionExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionExpressionInvocation(SidecarAstVisitor visitor) {
    _forFunctionExpressionInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionReference(SidecarAstVisitor visitor) {
    _forFunctionReference.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionTypeAlias(SidecarAstVisitor visitor) {
    _forFunctionTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addFunctionTypedFormalParameter(SidecarAstVisitor visitor) {
    _forFunctionTypedFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addGenericFunctionType(SidecarAstVisitor visitor) {
    _forGenericFunctionType
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addGenericTypeAlias(SidecarAstVisitor visitor) {
    _forGenericTypeAlias.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addHideClause(SidecarAstVisitor visitor) {
    _forHideClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addHideCombinator(SidecarAstVisitor visitor) {
    _forHideCombinator.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIfElement(SidecarAstVisitor visitor) {
    _forIfElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIfStatement(SidecarAstVisitor visitor) {
    _forIfStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImplementsClause(SidecarAstVisitor visitor) {
    _forImplementsClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImplicitCallReference(SidecarAstVisitor visitor) {
    _forImplicitCallReference
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addImportDirective(SidecarAstVisitor visitor) {
    _forImportDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIndexExpression(SidecarAstVisitor visitor) {
    _forIndexExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInstanceCreationExpression(SidecarAstVisitor visitor) {
    _forInstanceCreationExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIntegerLiteral(SidecarAstVisitor visitor) {
    _forIntegerLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInterpolationExpression(SidecarAstVisitor visitor) {
    _forInterpolationExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addInterpolationString(SidecarAstVisitor visitor) {
    _forInterpolationString
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addIsExpression(SidecarAstVisitor visitor) {
    _forIsExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLabel(SidecarAstVisitor visitor) {
    _forLabel.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLabeledStatement(SidecarAstVisitor visitor) {
    _forLabeledStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryAugmentationDirective(SidecarAstVisitor visitor) {
    _forLibraryAugmentationDirective
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryDirective(SidecarAstVisitor visitor) {
    _forLibraryDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addLibraryIdentifier(SidecarAstVisitor visitor) {
    _forLibraryIdentifier.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addListLiteral(SidecarAstVisitor visitor) {
    _forListLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMapLiteralEntry(SidecarAstVisitor visitor) {
    _forMapLiteralEntry.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMethodDeclaration(SidecarAstVisitor visitor) {
    _forMethodDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMethodInvocation(SidecarAstVisitor visitor) {
    _forMethodInvocation.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addMixinDeclaration(SidecarAstVisitor visitor) {
    _forMixinDeclaration.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNamedExpression(SidecarAstVisitor visitor) {
    _forNamedExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNamedType(SidecarAstVisitor visitor) {
    _forNamedType.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNativeClause(SidecarAstVisitor visitor) {
    _forNativeClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNativeFunctionBody(SidecarAstVisitor visitor) {
    _forNativeFunctionBody
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addNullLiteral(SidecarAstVisitor visitor) {
    _forNullLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addOnClause(SidecarAstVisitor visitor) {
    _forOnClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addParenthesizedExpression(SidecarAstVisitor visitor) {
    _forParenthesizedExpression
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPartDirective(SidecarAstVisitor visitor) {
    _forPartDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPartOfDirective(SidecarAstVisitor visitor) {
    _forPartOfDirective.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPostfixExpression(SidecarAstVisitor visitor) {
    _forPostfixExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPrefixedIdentifier(SidecarAstVisitor visitor) {
    _forPrefixedIdentifier
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPrefixExpression(SidecarAstVisitor visitor) {
    _forPrefixExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addPropertyAccess(SidecarAstVisitor visitor) {
    _forPropertyAccess.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  // void addRecordLiteral(LintError linter, SidecarAstVisitor visitor) {
  //   _forRecordLiterals.add(VisitorSubscription(visitor, _getTimer(visitor)));
  // }

  void addRedirectingConstructorInvocation(SidecarAstVisitor visitor) {
    _forRedirectingConstructorInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addRethrowExpression(SidecarAstVisitor visitor) {
    _forRethrowExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addReturnStatement(SidecarAstVisitor visitor) {
    _forReturnStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addScriptTag(SidecarAstVisitor visitor) {
    _forScriptTag.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSetOrMapLiteral(SidecarAstVisitor visitor) {
    _forSetOrMapLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowClause(SidecarAstVisitor visitor) {
    _forShowClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowCombinator(SidecarAstVisitor visitor) {
    _forShowCombinator.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addShowHideElement(SidecarAstVisitor visitor) {
    _forShowHideElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleFormalParameter(SidecarAstVisitor visitor) {
    _forSimpleFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleIdentifier(SidecarAstVisitor visitor) {
    _forSimpleIdentifier.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSimpleStringLiteral(SidecarAstVisitor visitor) {
    _forSimpleStringLiteral
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSpreadElement(SidecarAstVisitor visitor) {
    _forSpreadElement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addStringInterpolation(SidecarAstVisitor visitor) {
    _forStringInterpolation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperConstructorInvocation(SidecarAstVisitor visitor) {
    _forSuperConstructorInvocation
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperExpression(SidecarAstVisitor visitor) {
    _forSuperExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSuperFormalParameter(SidecarAstVisitor visitor) {
    _forSuperFormalParameter
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchCase(SidecarAstVisitor visitor) {
    _forSwitchCase.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchDefault(SidecarAstVisitor visitor) {
    _forSwitchDefault.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSwitchStatement(SidecarAstVisitor visitor) {
    _forSwitchStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addSymbolLiteral(SidecarAstVisitor visitor) {
    _forSymbolLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addThisExpression(SidecarAstVisitor visitor) {
    _forThisExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addThrowExpression(SidecarAstVisitor visitor) {
    _forThrowExpression.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTopLevelVariableDeclaration(SidecarAstVisitor visitor) {
    _forTopLevelVariableDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTryStatement(SidecarAstVisitor visitor) {
    _forTryStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeArgumentList(SidecarAstVisitor visitor) {
    _forTypeArgumentList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeLiteral(SidecarAstVisitor visitor) {
    _forTypeLiteral.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  @Deprecated('Use addNamedType() instead')
  void addTypeName(SidecarAstVisitor visitor) {
    addNamedType(visitor);
  }

  void addTypeParameter(SidecarAstVisitor visitor) {
    _forTypeParameter.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addTypeParameterList(SidecarAstVisitor visitor) {
    _forTypeParameterList.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclaration(SidecarAstVisitor visitor) {
    _forVariableDeclaration
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclarationList(SidecarAstVisitor visitor) {
    _forVariableDeclarationList
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addVariableDeclarationStatement(SidecarAstVisitor visitor) {
    _forVariableDeclarationStatement
        .add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addWhileStatement(SidecarAstVisitor visitor) {
    _forWhileStatement.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addWithClause(SidecarAstVisitor visitor) {
    _forWithClause.add(VisitorSubscription(visitor, _getTimer(visitor)));
  }

  void addYieldStatement(SidecarAstVisitor linter) {
    _forYieldStatement.add(VisitorSubscription(linter, _getTimer(linter)));
  }

  /// Get the timer associated with the given [linter].
  Stopwatch? _getTimer(SidecarAstVisitor linter) {
    // if (enableTiming) {
    //   return registry.getTimer(linter);
    // } else {
    //   return null;
    // }
    return null;
  }
}
