// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The base class representing an arbitrary chunk of Dart code, which may or
/// may not be syntactically or semantically valid yet.
class Code {
  /// All the chunks of [Code], raw [String]s, or [Identifier]s that
  /// comprise this [Code] object.
  final List<Object> parts;

  /// Can be used to more efficiently detect the kind of code, avoiding is
  /// checks and enabling switch statements.
  CodeKind get kind => CodeKind.raw;

  Code.fromString(String code) : parts = [code];

  Code.fromParts(this.parts)
      : assert(parts.every((element) =>
            element is String || element is Code || element is Identifier));
}

/// A piece of code representing a syntactically valid declaration.
class DeclarationCode extends Code {
  DeclarationCode.fromString(super.code) : super.fromString();

  DeclarationCode.fromParts(super.parts) : super.fromParts();

  @override
  CodeKind get kind => CodeKind.declaration;
}

/// A piece of code representing a syntactically valid expression.
class ExpressionCode extends Code {
  ExpressionCode.fromString(super.code) : super.fromString();

  ExpressionCode.fromParts(super.parts) : super.fromParts();

  @override
  CodeKind get kind => CodeKind.expression;
}

/// A piece of code representing a syntactically valid function body.
///
/// This includes any and all code after the parameter list of a function,
/// including modifiers like `async`.
///
/// Both arrow and block function bodies are allowed.
class FunctionBodyCode extends Code {
  FunctionBodyCode.fromString(super.code) : super.fromString();

  FunctionBodyCode.fromParts(super.parts) : super.fromParts();

  @override
  CodeKind get kind => CodeKind.functionBody;
}

/// A piece of code identifying a syntactically valid function or function type
/// parameter.
///
/// There is no distinction here made between named and positional parameters.
///
/// There is also no distinction between function type parameters and normal
/// function parameters, so the [name] is nullable (it is not required for
/// positional function type parameters).
///
/// It is the job of the user to construct and combine these together in a way
/// that creates valid parameter lists.
class ParameterCode implements Code {
  final Code? defaultValue;
  final List<String> keywords;
  final String? name;
  final TypeAnnotationCode? type;

  @override
  CodeKind get kind => CodeKind.parameter;

  @override
  List<Object> get parts => [
        if (keywords.isNotEmpty) ...[
          ...keywords.joinAsCode(' '),
          ' ',
        ],
        if (type != null) ...[
          type!,
          ' ',
        ],
        if (name != null) name!,
        if (defaultValue != null) ...[
          ' = ',
          defaultValue!,
        ]
      ];

  ParameterCode({
    this.defaultValue,
    this.keywords = const [],
    this.name,
    this.type,
  });
}

/// A piece of code representing a type annotation.
abstract class TypeAnnotationCode implements Code, TypeAnnotation {
  @override
  TypeAnnotationCode get code => this;

  /// Returns a [TypeAnnotationCode] object which is a non-nullable version
  /// of this one.
  ///
  /// Returns the current instance if it is already non-nullable.
  TypeAnnotationCode get asNonNullable => this;

  /// Returns a [TypeAnnotationCode] object which is a non-nullable version
  /// of this one.
  ///
  /// Returns the current instance if it is already nullable.
  NullableTypeAnnotationCode get asNullable =>
      new NullableTypeAnnotationCode(this);

  /// Whether or not this type is nullable.
  bool get isNullable => false;
}

/// The nullable version of an underlying type annotation.
class NullableTypeAnnotationCode implements TypeAnnotationCode {
  /// The underlying type that is being made nullable.
  TypeAnnotationCode underlyingType;

  @override
  TypeAnnotationCode get code => this;

  @override
  CodeKind get kind => CodeKind.nullableTypeAnnotation;

  @override
  List<Object> get parts => [...underlyingType.parts, '?'];

  /// Creates a nullable [underlyingType] annotation.
  ///
  /// If [underlyingType] is a NullableTypeAnnotationCode, returns that
  /// same type.
  NullableTypeAnnotationCode(this.underlyingType);

  @override
  TypeAnnotationCode get asNonNullable => underlyingType;

  @override
  NullableTypeAnnotationCode get asNullable => this;

  @override
  bool get isNullable => true;
}

/// A piece of code representing a reference to a named type.
class NamedTypeAnnotationCode extends TypeAnnotationCode {
  final Identifier name;

  final List<TypeAnnotationCode> typeArguments;

  @override
  CodeKind get kind => CodeKind.namedTypeAnnotation;

  @override
  List<Object> get parts => [
        name,
        if (typeArguments.isNotEmpty) ...[
          '<',
          ...typeArguments.joinAsCode(', '),
          '>',
        ],
      ];

  NamedTypeAnnotationCode({required this.name, this.typeArguments = const []});
}

/// A piece of code representing a function type annotation.
class FunctionTypeAnnotationCode extends TypeAnnotationCode {
  final List<ParameterCode> namedParameters;

  final List<ParameterCode> positionalParameters;

  final TypeAnnotationCode? returnType;

  final List<TypeParameterCode> typeParameters;

  @override
  CodeKind get kind => CodeKind.functionTypeAnnotation;

  @override
  List<Object> get parts => [
        if (returnType != null) returnType!,
        ' Function',
        if (typeParameters.isNotEmpty) ...[
          '<',
          ...typeParameters.joinAsCode(', '),
          '>',
        ],
        '(',
        for (ParameterCode positional in positionalParameters) ...[
          positional,
          ', ',
        ],
        if (namedParameters.isNotEmpty) ...[
          '{',
          for (ParameterCode named in namedParameters) ...[
            named,
            ', ',
          ],
          '}',
        ],
        ')',
      ];

  FunctionTypeAnnotationCode({
    this.namedParameters = const [],
    this.positionalParameters = const [],
    this.returnType,
    this.typeParameters = const [],
  });
}

class OmittedTypeAnnotationCode extends TypeAnnotationCode {
  final OmittedTypeAnnotation typeAnnotation;

  OmittedTypeAnnotationCode(this.typeAnnotation);

  @override
  CodeKind get kind => CodeKind.omittedTypeAnnotation;

  @override
  List<Object> get parts => [typeAnnotation];
}

/// A piece of code representing a valid named type parameter.
class TypeParameterCode implements Code {
  final TypeAnnotationCode? bound;
  final String name;

  @override
  CodeKind get kind => CodeKind.typeParameter;

  @override
  List<Object> get parts => [
        name,
        if (bound != null) ...[
          ' extends ',
          bound!,
        ]
      ];

  TypeParameterCode({this.bound, required this.name});
}

extension Join<T extends Object> on List<T> {
  /// Joins all the items in [this] with [separator], and returns
  /// a new list.
  List<Object> joinAsCode(String separator) => [
        for (int i = 0; i < length - 1; i++) ...[
          this[i],
          separator,
        ],
        if (isNotEmpty) last,
      ];
}

enum CodeKind {
  declaration,
  expression,
  functionBody,
  functionTypeAnnotation,
  namedTypeAnnotation,
  nullableTypeAnnotation,
  omittedTypeAnnotation,
  parameter,
  raw,
  typeParameter,
}

// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// A concrete reference to a named declaration, which may or may not yet be
/// resolved.
///
/// These can be passed directly to [Code] objects, which will automatically do
/// any necessary prefixing when emitting references.
///
/// Concrete implementations should override `==` so that identifiers can be
/// reliably compared against each other.
abstract class Identifier {
  String get name;
}

/// The base class for an unresolved reference to a type.
///
/// See the subtypes [FunctionTypeAnnotation] and [NamedTypeAnnotation].
abstract class TypeAnnotation {
  /// Whether or not the type annotation is explicitly nullable (contains a
  /// trailing `?`)
  bool get isNullable;

  /// A convenience method to get a [Code] object equivalent to this type
  /// annotation.
  TypeAnnotationCode get code;
}

/// The base class for function type declarations.
abstract class FunctionTypeAnnotation implements TypeAnnotation {
  /// The return type of this function.
  TypeAnnotation get returnType;

  /// The positional parameters for this function.
  Iterable<FunctionTypeParameter> get positionalParameters;

  /// The named parameters for this function.
  Iterable<FunctionTypeParameter> get namedParameters;

  /// The type parameters for this function.
  Iterable<TypeParameterDeclaration> get typeParameters;
}

/// An unresolved reference to a type.
///
/// These can be resolved to a [TypeDeclaration] using the `builder` classes
/// depending on the phase a macro is running in.
abstract class NamedTypeAnnotation implements TypeAnnotation {
  /// An identifier pointing to this named type.
  Identifier get identifier;

  /// The type arguments, if applicable.
  Iterable<TypeAnnotation> get typeArguments;
}

/// An omitted type annotation.
///
/// This will be given whenever there is no explicit type annotation for a
/// declaration.
///
/// These type annotations can still produce valid [Code] objects, which will
/// result in the inferred type being emitted into the resulting code (or
/// dynamic).
///
/// In the definition phase, you may also ask explicitly for the inferred type
/// using the `inferType` API.
abstract class OmittedTypeAnnotation implements TypeAnnotation {}

/// The interface representing a resolved type.
///
/// Resolved types understand exactly what type they represent, and can be
/// compared to other static types.
abstract class StaticType {
  /// Returns true if this is a subtype of [other].
  Future<bool> isSubtypeOf(covariant StaticType other);

  /// Returns true if this is an identical type to [other].
  Future<bool> isExactly(covariant StaticType other);
}

/// A subtype of [StaticType] representing types that can be resolved by name
/// to a concrete declaration.
abstract class NamedStaticType implements StaticType {}

/// The base class for all declarations.
abstract class Declaration {
  ///  An identifier pointing to this named declaration.
  Identifier get identifier;
}

/// Base class for all Declarations which have a surrounding class.
abstract class ClassMemberDeclaration implements Declaration {
  /// The class that defines this method.
  Identifier get definingClass;

  /// Whether or not this is a static member.
  bool get isStatic;
}

/// Marker interface for a declaration that defines a new type in the program.
///
/// See [ParameterizedTypeDeclaration] and [TypeParameterDeclaration].
abstract class TypeDeclaration implements Declaration {}

/// A [TypeDeclaration] which may have type parameters.
///
/// See subtypes [ClassDeclaration] and [TypeAliasDeclaration].
abstract class ParameterizedTypeDeclaration implements TypeDeclaration {
  /// The type parameters defined for this type declaration.
  Iterable<TypeParameterDeclaration> get typeParameters;
}

/// A marker interface for the type declarations which are introspectable.
///
/// All type declarations which can have members will have a variant which
/// implements this type.
mixin IntrospectableType implements TypeDeclaration {}

/// Class (and enum) introspection information.
///
/// Information about fields, methods, and constructors must be retrieved from
/// the `builder` objects.
abstract class ClassDeclaration implements ParameterizedTypeDeclaration {
  /// Whether this class has an `abstract` modifier.
  bool get isAbstract;

  /// Whether this class has an `external` modifier.
  bool get isExternal;

  /// The `extends` type annotation, if present.
  NamedTypeAnnotation? get superclass;

  /// All the `implements` type annotations.
  Iterable<NamedTypeAnnotation> get interfaces;

  /// All the `with` type annotations.
  Iterable<NamedTypeAnnotation> get mixins;

  /// All the type arguments, if applicable.
  Iterable<TypeParameterDeclaration> get typeParameters;
}

/// An introspectable class declaration.
abstract class IntrospectableClassDeclaration
    implements ClassDeclaration, IntrospectableType {}

/// Type alias introspection information.
abstract class TypeAliasDeclaration implements ParameterizedTypeDeclaration {
  /// The type annotation this is an alias for.
  TypeAnnotation get aliasedType;
}

/// Function introspection information.
abstract class FunctionDeclaration implements Declaration {
  /// Whether this function has an `abstract` modifier.
  bool get isAbstract;

  /// Whether this function has an `external` modifier.
  bool get isExternal;

  /// Whether this function is an operator.
  bool get isOperator;

  /// Whether this function is actually a getter.
  bool get isGetter;

  /// Whether this function is actually a setter.
  bool get isSetter;

  /// The return type of this function.
  TypeAnnotation get returnType;

  /// The positional parameters for this function.
  Iterable<ParameterDeclaration> get positionalParameters;

  /// The named parameters for this function.
  Iterable<ParameterDeclaration> get namedParameters;

  /// The type parameters for this function.
  Iterable<TypeParameterDeclaration> get typeParameters;
}

/// Method introspection information.
abstract class MethodDeclaration
    implements FunctionDeclaration, ClassMemberDeclaration {}

/// Constructor introspection information.
abstract class ConstructorDeclaration implements MethodDeclaration {
  /// Whether or not this is a factory constructor.
  bool get isFactory;
}

/// Variable introspection information.
abstract class VariableDeclaration implements Declaration {
  /// Whether this field has an `external` modifier.
  bool get isExternal;

  /// Whether this field has a `final` modifier.
  bool get isFinal;

  /// Whether this field has a `late` modifier.
  bool get isLate;

  /// The type of this field.
  TypeAnnotation get type;
}

/// Field introspection information.
abstract class FieldDeclaration
    implements VariableDeclaration, ClassMemberDeclaration {}

/// General parameter introspection information, see the subtypes
/// [FunctionTypeParameter] and [ParameterDeclaration].
abstract class Parameter {
  /// The type of this parameter.
  TypeAnnotation get type;

  /// Whether or not this is a named parameter.
  bool get isNamed;

  /// Whether or not this parameter is either a non-optional positional
  /// parameter or an optional parameter with the `required` keyword.
  bool get isRequired;

  /// A convenience method to get a `code` object equivalent to this parameter.
  ///
  /// Note that the original default value will not be included, as it is not a
  /// part of this API.
  ParameterCode get code;
}

/// Parameters of normal functions/methods, which always have an identifier.
abstract class ParameterDeclaration implements Parameter, Declaration {}

/// Function type parameters don't always have names, and it is never useful to
/// get an [Identifier] for them, so they do not implement [Declaration] and
/// instead have an optional name.
abstract class FunctionTypeParameter implements Parameter {
  String? get name;
}

/// Generic type parameter introspection information.
abstract class TypeParameterDeclaration implements TypeDeclaration {
  /// The bound for this type parameter, if it has any.
  TypeAnnotation? get bound;

  /// A convenience method to get a `code` object equivalent to this type
  /// parameter.
  TypeParameterCode get code;
}
