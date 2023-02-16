// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'src/type_checker/type_checker_impl.dart';

/// An abstraction around doing static type checking at compile/build time.

abstract class TypeChecker {
  /// Creates a new [TypeChecker] that delegates to other [checkers].
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
  const factory TypeChecker.any(Iterable<TypeChecker> checkers) =
      TypeCheckerImpl.any;

  /// Create a new [TypeChecker] backed by a static [type].
  const factory TypeChecker.fromStatic(DartType type) =
      TypeCheckerImpl.fromStatic;

  /// Create a new [TypeChecker] from a type name and respective package name
  const factory TypeChecker.fromPackage(String type,
      {required String package}) = TypeCheckerImpl.fromPackage;

  /// Create a new [TypeChecker] for a dart package [type].
  ///
  /// For example:
  ///
  /// ```dart
  /// const colorType = TypeChecker.fromDart('Color', package: 'ui');
  /// ```
  const factory TypeChecker.fromDart(String type, {required String package}) =
      TypeCheckerImpl.fromDartType;

  /// Returns the first constant annotating [element] assignable to this type.
  ///
  /// Otherwise returns `null`.
  ///
  /// Throws on unresolved annotations unless [throwOnUnresolved] is `false`.
  DartObject? firstAnnotationOf(
    Element element, {
    bool throwOnUnresolved = true,
  });

  /// Returns if a constant annotating [element] is assignable to this type.
  ///
  /// Throws on unresolved annotations unless [throwOnUnresolved] is `false`.
  bool hasAnnotationOf(
    Element element, {
    bool throwOnUnresolved = true,
  });

  /// Returns the first constant annotating [element] that is exactly this type.
  ///
  /// Throws [UnresolvedAnnotationException] on unresolved annotations unless
  /// [throwOnUnresolved] is explicitly set to `false` (default is `true`).
  DartObject? firstAnnotationOfExact(
    Element element, {
    bool throwOnUnresolved = true,
  });

  /// Returns if a constant annotating [element] is exactly this type.
  ///
  /// Throws [UnresolvedAnnotationException] on unresolved annotations unless
  /// [throwOnUnresolved] is explicitly set to `false` (default is `true`).
  bool hasAnnotationOfExact(
    Element element, {
    bool throwOnUnresolved = true,
  });

  /// Returns annotating constants on [element] assignable to this type.
  ///
  /// Throws [UnresolvedAnnotationException] on unresolved annotations unless
  /// [throwOnUnresolved] is explicitly set to `false` (default is `true`).
  Iterable<DartObject> annotationsOf(
    Element element, {
    bool throwOnUnresolved = true,
  });

  /// Returns annotating constants on [element] of exactly this type.
  ///
  /// Throws [UnresolvedAnnotationException] on unresolved annotations unless
  /// [throwOnUnresolved] is explicitly set to `false` (default is `true`).
  Iterable<DartObject> annotationsOfExact(
    Element element, {
    bool throwOnUnresolved = true,
  });

  /// Returns `true` if the type of [element] can be assigned to this type.
  bool isAssignableFrom(Element? element);

  /// Returns `true` if the type of [element] can NOT be assigned to this type.
  bool isNotAssignableFrom(Element? element);

  /// Returns `true` if [staticType] can be assigned to this type.
  bool isAssignableFromType(
    DartType? staticType, {
    List<TypeChecker> args = const [],
  });

  /// Returns `true` if [staticType] can NOT be assigned to this type.
  bool isNotAssignableFromType(
    DartType? staticType, {
    List<TypeChecker> args = const [],
  });

  /// Returns `true` if representing the exact same class as [element].
  bool isExactly(Element? element);

  /// Returns `true` if representing the exact same type as [staticType].
  bool isExactlyType(DartType? staticType) => isExactly(staticType?.element);

  /// Returns `true` if representing a super class of [element].
  ///
  /// This check only takes into account the *extends* hierarchy. If you wish
  /// to check mixins and interfaces, use [isAssignableFrom].
  bool isSuperOf(Element element);

  /// Returns `true` if representing a super type of [staticType].
  ///
  /// This only takes into account the *extends* hierarchy. If you wish
  /// to check mixins and interfaces, use [isAssignableFromType].
  bool isSuperTypeOf(DartType staticType);
}
