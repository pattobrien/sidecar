// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// import 'dart:mirrors' hide SourceLocation;

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';

import 'package:source_span/source_span.dart';

import '../../type_checker.dart';

import 'utils.dart';

/// An abstraction around doing static type checking at compile/build time.

abstract class TypeCheckerImpl implements TypeChecker {
  const TypeCheckerImpl();

  /// Creates a new [TypeCheckerImpl] that delegates to other [checkers].
  ///
  /// This implementation will return `true` for type checks if _any_ of the
  /// provided type checkers return true, which is useful for deprecating an
  /// API:
  /// ```dart
  /// const $Foo = const TypeChecker.fromRuntime(Foo);
  /// const $Bar = const TypeChecker.fromRuntime(Bar);
  ///
  /// // Used until $Foo is deleted.
  /// const $FooOrBar = const TypeChecker.forAny(const [$Foo, $Bar]);
  /// ```
  const factory TypeCheckerImpl.any(Iterable<TypeChecker> checkers) =
      _AnyChecker;

  /// Create a new [TypeCheckerImpl] backed by a runtime [type].
  ///
  /// This implementation uses `dart:mirrors` (runtime reflection).
  // const factory TypeChecker.fromRuntime(Type type) = _MirrorTypeChecker;

  /// Create a new [TypeCheckerImpl] backed by a static [type].
  const factory TypeCheckerImpl.fromStatic(DartType type) = _LibraryTypeChecker;

  /// Create a new [TypeCheckerImpl] from a type name and respective package name
  const factory TypeCheckerImpl.fromPackage(
    String type, {
    required String package,
    // bool isDartLib,
    TypeChecker? typeArg,
  }) = _NamedChecker;

  /// Create a new [TypeChecker] for a ```dart``` package type.
  const factory TypeCheckerImpl.fromDartType(
    String name, {
    required String package,
  }) = _DartNamedChecker;

  /// Create a new [TypeCheckerImpl] backed by a library [url].
  ///
  /// Example of referring to a `LinkedHashMap` from `dart:collection`:
  /// ```dart
  /// const linkedHashMap = const TypeChecker.fromUrl(
  ///   'dart:collection#LinkedHashMap',
  /// );
  /// ```
  ///
  /// **NOTE**: This is considered a more _brittle_ way of determining the type
  /// because it relies on knowing the _absolute_ path (i.e. after resolved
  /// `export` directives). You should ideally only use `fromUrl` when you know
  /// the full path (likely you own/control the package) or it is in a stable
  /// package like in the `dart:` SDK.
  const factory TypeCheckerImpl.fromUrl(dynamic url) = _UriTypeChecker;

  /// Returns the first constant annotating [element] assignable to this type.
  ///
  /// Otherwise returns `null`.
  ///
  /// Throws on unresolved annotations unless [throwOnUnresolved] is `false`.
  @override
  DartObject? firstAnnotationOf(
    Element element, {
    bool throwOnUnresolved = true,
  }) {
    if (element.metadata.isEmpty) {
      return null;
    }
    final results =
        annotationsOf(element, throwOnUnresolved: throwOnUnresolved);
    return results.isEmpty ? null : results.first;
  }

  /// Returns if a constant annotating [element] is assignable to this type.
  ///
  /// Throws on unresolved annotations unless [throwOnUnresolved] is `false`.
  @override
  bool hasAnnotationOf(Element element, {bool throwOnUnresolved = true}) =>
      firstAnnotationOf(element, throwOnUnresolved: throwOnUnresolved) != null;

  /// Returns the first constant annotating [element] that is exactly this type.
  ///
  /// Throws [UnresolvedAnnotationException] on unresolved annotations unless
  /// [throwOnUnresolved] is explicitly set to `false` (default is `true`).
  @override
  DartObject? firstAnnotationOfExact(
    Element element, {
    bool throwOnUnresolved = true,
  }) {
    if (element.metadata.isEmpty) {
      return null;
    }
    final results =
        annotationsOfExact(element, throwOnUnresolved: throwOnUnresolved);
    return results.isEmpty ? null : results.first;
  }

  /// Returns if a constant annotating [element] is exactly this type.
  ///
  /// Throws [UnresolvedAnnotationException] on unresolved annotations unless
  /// [throwOnUnresolved] is explicitly set to `false` (default is `true`).
  @override
  bool hasAnnotationOfExact(Element element, {bool throwOnUnresolved = true}) =>
      firstAnnotationOfExact(element, throwOnUnresolved: throwOnUnresolved) !=
      null;

  DartObject? _computeConstantValue(
    Element element,
    int annotationIndex, {
    bool throwOnUnresolved = true,
  }) {
    final annotation = element.metadata[annotationIndex];
    final result = annotation.computeConstantValue();
    if (result == null && throwOnUnresolved) {
      throw UnresolvedAnnotationException._from(element, annotationIndex);
    }
    return result;
  }

  /// Returns annotating constants on [element] assignable to this type.
  ///
  /// Throws [UnresolvedAnnotationException] on unresolved annotations unless
  /// [throwOnUnresolved] is explicitly set to `false` (default is `true`).
  @override
  Iterable<DartObject> annotationsOf(
    Element element, {
    bool throwOnUnresolved = true,
  }) =>
      _annotationsWhere(
        element,
        isAssignableFromType,
        throwOnUnresolved: throwOnUnresolved,
      );

  Iterable<DartObject> _annotationsWhere(
    Element element,
    bool Function(DartType) predicate, {
    bool throwOnUnresolved = true,
  }) sync* {
    for (var i = 0; i < element.metadata.length; i++) {
      final value = _computeConstantValue(
        element,
        i,
        throwOnUnresolved: throwOnUnresolved,
      );
      if (value?.type != null && predicate(value!.type!)) {
        yield value;
      }
    }
  }

  /// Returns annotating constants on [element] of exactly this type.
  ///
  /// Throws [UnresolvedAnnotationException] on unresolved annotations unless
  /// [throwOnUnresolved] is explicitly set to `false` (default is `true`).
  @override
  Iterable<DartObject> annotationsOfExact(
    Element element, {
    bool throwOnUnresolved = true,
  }) =>
      _annotationsWhere(
        element,
        isExactlyType,
        throwOnUnresolved: throwOnUnresolved,
      );

  /// Returns `true` if the type of [element] can be assigned to this type.
  @override
  bool isAssignableFrom(Element? element) =>
      isExactly(element) ||
      (element is ClassElement && element.allSupertypes.any(isExactlyType));

  /// Returns `true` if the type of [element] can NOT be assigned to this type.
  @override
  bool isNotAssignableFrom(Element? element) => !isAssignableFrom(element);

  /// Returns `true` if [staticType] can be assigned to this type.
  @override
  bool isAssignableFromType(
    DartType? staticType, {
    List<TypeChecker> args = const <TypeChecker>[],
  }) {
    if (args.isNotEmpty) {
      if (staticType is! InterfaceType) return false;
      final isType = isAssignableFrom(staticType.element);
      final isArgs = staticType.typeArguments.every(
          (arg) => args.any((checker) => checker.isAssignableFromType(arg)));
      return isType && isArgs;
    }
    if (staticType is InterfaceType) {}
    return isAssignableFrom(staticType?.element);
  }

  /// Returns `true` if [staticType] can NOT be assigned to this type.
  @override
  bool isNotAssignableFromType(
    DartType? staticType, {
    List<TypeChecker> args = const <TypeChecker>[],
  }) =>
      !isAssignableFromType(staticType, args: args);

  /// Returns `true` if representing the exact same class as [element].
  @override
  bool isExactly(Element? element);

  /// Returns `true` if representing the exact same type as [staticType].
  @override
  bool isExactlyType(DartType? staticType) => isExactly(staticType?.element);

  /// Returns `true` if representing a super class of [element].
  ///
  /// This check only takes into account the *extends* hierarchy. If you wish
  /// to check mixins and interfaces, use [isAssignableFrom].
  @override
  bool isSuperOf(Element element) {
    if (element is ClassElement) {
      var theSuper = element.supertype;

      do {
        if (isExactlyType(theSuper)) {
          return true;
        }

        theSuper = theSuper?.superclass;
      } while (theSuper != null);
    }

    return false;
  }

  /// Returns `true` if representing a super type of [staticType].
  ///
  /// This only takes into account the *extends* hierarchy. If you wish
  /// to check mixins and interfaces, use [isAssignableFromType].
  @override
  bool isSuperTypeOf(DartType staticType) => isSuperOf(staticType.element!);
}

// Checks a static type against another static type;
@immutable
class _LibraryTypeChecker extends TypeCheckerImpl {
  const _LibraryTypeChecker(this._type);

  final DartType _type;

  @override
  bool isExactly(Element? element) =>
      element != null && element is ClassElement && element == _type.element;

  @override
  String toString() => urlOfElement(_type.element!);
}

@immutable
class _NamedChecker extends TypeCheckerImpl {
  const _NamedChecker(
    this._name, {
    required this.package,
    this.typeArg,
  });

  final String _name;
  final String package;
  final TypeChecker? typeArg;

  @override
  bool isExactly(Element? element) {
    if (element == null) return false;
    if (element.name != _name) return false;

    final elementUri = element.librarySource?.uri;

    return elementUri != null &&
        elementUri.scheme == 'package' &&
        elementUri.pathSegments.first == package;
  }

  @override
  bool operator ==(Object o) {
    return o is _NamedChecker && o._name == _name && o.package == package;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _name, package);

  @override
  String toString() => '$package#$_name';
}

@immutable
class _DartNamedChecker extends TypeCheckerImpl {
  const _DartNamedChecker(
    this._name, {
    required this.package,
  });

  final String _name;
  final String package;

  @override
  bool isExactly(Element? element) {
    if (element == null) return false;
    if (element.name != _name) return false;

    final elementUri = element.librarySource?.uri;

    return elementUri != null &&
        elementUri.scheme == 'dart' &&
        elementUri.pathSegments.first == package;
  }

  @override
  bool operator ==(Object o) {
    return o is _NamedChecker && o._name == _name && o.package == package;
  }

  @override
  int get hashCode => Object.hash(runtimeType, _name, package);

  @override
  String toString() => 'dart:$package#$_name';
}

// // Checks a runtime type against a static type.
// class _MirrorTypeChecker extends TypeChecker {
//   static Uri _uriOf(ClassMirror mirror) =>
//       normalizeUrl((mirror.owner as LibraryMirror).uri)
//           .replace(fragment: MirrorSystem.getName(mirror.simpleName));

//   // Precomputed type checker for types that already have been used.
//   static final _cache = Expando<TypeChecker>();

//   final Type _type;

//   const _MirrorTypeChecker(this._type) : super._();

//   TypeChecker get _computed =>
//       _cache[this] ??= TypeChecker.fromUrl(_uriOf(reflectClass(_type)));

//   @override
//   bool isExactly(Element element) => _computed.isExactly(element);

//   @override
//   String toString() => _computed.toString();
// }

/// Checks a runtime type against an Uri and Symbol.
@immutable
class _UriTypeChecker extends TypeCheckerImpl {
  const _UriTypeChecker(dynamic url) : _url = '$url';

  final String _url;

  // Precomputed cache of String --> Uri.
  static final _cache = Expando<Uri>();

  @override
  bool operator ==(Object o) => o is _UriTypeChecker && o._url == _url;

  @override
  int get hashCode => _url.hashCode;

  /// Url as a [Uri] object, lazily constructed.
  Uri get uri => _cache[this] ??= normalizeUrl(Uri.parse(_url));

  /// Returns whether this type represents the same as [url].
  bool hasSameUrl(dynamic url) =>
      uri.toString() ==
      (url is String ? url : normalizeUrl(url as Uri).toString());

  @override
  bool isExactly(Element? element) =>
      element != null && hasSameUrl(urlOfElement(element));

  @override
  String toString() => '$uri';
}

@immutable
class _AnyChecker extends TypeCheckerImpl {
  const _AnyChecker(this._checkers);

  final Iterable<TypeChecker> _checkers;

  @override
  bool isExactly(Element? element) =>
      _checkers.any((c) => c.isExactly(element));
}

/// Exception thrown when [TypeCheckerImpl] fails to resolve a metadata annotation.
///
/// Methods such as [TypeCheckerImpl.firstAnnotationOf] may throw this exception
/// when one or more annotations are not resolvable. This is usually a sign that
/// something was misspelled, an import is missing, or a dependency was not
/// defined (for build systems such as Bazel).
class UnresolvedAnnotationException implements Exception {
  /// Creates an exception from an annotation ([annotationIndex]) that was not
  /// resolvable while traversing [Element.metadata] on [annotatedElement].
  factory UnresolvedAnnotationException._from(
    Element annotatedElement,
    int annotationIndex,
  ) {
    final sourceSpan = _findSpan(annotatedElement, annotationIndex);
    return UnresolvedAnnotationException._(annotatedElement, sourceSpan);
  }

  const UnresolvedAnnotationException._(
    this.annotatedElement,
    this.annotationSource,
  );

  /// Element that was annotated with something we could not resolve.
  final Element annotatedElement;

  /// Source span of the annotation that was not resolved.
  ///
  /// May be `null` if the import library was not found.
  final SourceSpan? annotationSource;

  static SourceSpan? _findSpan(
    Element annotatedElement,
    int annotationIndex,
  ) {
    try {
      final parsedLibrary = annotatedElement.session!
              .getParsedLibraryByElement(annotatedElement.library!)
          as ParsedLibraryResult;
      final declaration = parsedLibrary.getElementDeclaration(annotatedElement);
      if (declaration == null) {
        return null;
      }
      final node = declaration.node;
      final List<Annotation> metadata;
      if (node is AnnotatedNode) {
        metadata = node.metadata;
      } else if (node is FormalParameter) {
        metadata = node.metadata;
      } else {
        throw StateError(
          'Unhandled Annotated AST node type: ${node.runtimeType}',
        );
      }
      final annotation = metadata[annotationIndex];
      final start = annotation.offset;
      final end = start + annotation.length;
      final parsedUnit = declaration.parsedUnit!;
      return SourceSpan(
        SourceLocation(start, sourceUrl: parsedUnit.uri),
        SourceLocation(end, sourceUrl: parsedUnit.uri),
        parsedUnit.content.substring(start, end),
      );
    } catch (e) {
      // Trying to get more information on https://github.com/dart-lang/sdk/issues/45127
//       log.warning(
//         '''
// An unexpected error was thrown trying to get location information on `$annotatedElement` (${annotatedElement.runtimeType}).

// Please file an issue at https://github.com/dart-lang/source_gen/issues/new
// Include the contents of this warning and the stack trace along with
// the version of `package:source_gen`, `package:analyzer` from `pubspec.lock`.
// ''',
      //   e,
      //   stack,
      // );
      return null;
    }
  }

  @override
  String toString() {
    final message = 'Could not resolve annotation for `$annotatedElement`.';
    if (annotationSource != null) {
      return annotationSource!.message(message);
    }
    return message;
  }
}
