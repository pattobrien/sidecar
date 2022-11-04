// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'active_context_root.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActiveContextRoot {
  ContextRoot get contextRoot => throw _privateConstructorUsedError;

  /// Indicates the package that explicitly activates Sidecar as a plugin.
  bool get isExplicitlyEnabledRoot => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActiveContextRootCopyWith<ActiveContextRoot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveContextRootCopyWith<$Res> {
  factory $ActiveContextRootCopyWith(
          ActiveContextRoot value, $Res Function(ActiveContextRoot) then) =
      _$ActiveContextRootCopyWithImpl<$Res>;
  $Res call({ContextRoot contextRoot, bool isExplicitlyEnabledRoot});
}

/// @nodoc
class _$ActiveContextRootCopyWithImpl<$Res>
    implements $ActiveContextRootCopyWith<$Res> {
  _$ActiveContextRootCopyWithImpl(this._value, this._then);

  final ActiveContextRoot _value;
  // ignore: unused_field
  final $Res Function(ActiveContextRoot) _then;

  @override
  $Res call({
    Object? contextRoot = freezed,
    Object? isExplicitlyEnabledRoot = freezed,
  }) {
    return _then(_value.copyWith(
      contextRoot: contextRoot == freezed
          ? _value.contextRoot
          : contextRoot // ignore: cast_nullable_to_non_nullable
              as ContextRoot,
      isExplicitlyEnabledRoot: isExplicitlyEnabledRoot == freezed
          ? _value.isExplicitlyEnabledRoot
          : isExplicitlyEnabledRoot // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_ActiveContextRootCopyWith<$Res>
    implements $ActiveContextRootCopyWith<$Res> {
  factory _$$_ActiveContextRootCopyWith(_$_ActiveContextRoot value,
          $Res Function(_$_ActiveContextRoot) then) =
      __$$_ActiveContextRootCopyWithImpl<$Res>;
  @override
  $Res call({ContextRoot contextRoot, bool isExplicitlyEnabledRoot});
}

/// @nodoc
class __$$_ActiveContextRootCopyWithImpl<$Res>
    extends _$ActiveContextRootCopyWithImpl<$Res>
    implements _$$_ActiveContextRootCopyWith<$Res> {
  __$$_ActiveContextRootCopyWithImpl(
      _$_ActiveContextRoot _value, $Res Function(_$_ActiveContextRoot) _then)
      : super(_value, (v) => _then(v as _$_ActiveContextRoot));

  @override
  _$_ActiveContextRoot get _value => super._value as _$_ActiveContextRoot;

  @override
  $Res call({
    Object? contextRoot = freezed,
    Object? isExplicitlyEnabledRoot = freezed,
  }) {
    return _then(_$_ActiveContextRoot(
      contextRoot == freezed
          ? _value.contextRoot
          : contextRoot // ignore: cast_nullable_to_non_nullable
              as ContextRoot,
      isExplicitlyEnabledRoot: isExplicitlyEnabledRoot == freezed
          ? _value.isExplicitlyEnabledRoot
          : isExplicitlyEnabledRoot // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ActiveContextRoot extends _ActiveContextRoot {
  const _$_ActiveContextRoot(this.contextRoot,
      {required this.isExplicitlyEnabledRoot})
      : super._();

  @override
  final ContextRoot contextRoot;

  /// Indicates the package that explicitly activates Sidecar as a plugin.
  @override
  final bool isExplicitlyEnabledRoot;

  @override
  String toString() {
    return 'ActiveContextRoot(contextRoot: $contextRoot, isExplicitlyEnabledRoot: $isExplicitlyEnabledRoot)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_ActiveContextRootCopyWith<_$_ActiveContextRoot> get copyWith =>
      __$$_ActiveContextRootCopyWithImpl<_$_ActiveContextRoot>(
          this, _$identity);
}

abstract class _ActiveContextRoot extends ActiveContextRoot {
  const factory _ActiveContextRoot(final ContextRoot contextRoot,
      {required final bool isExplicitlyEnabledRoot}) = _$_ActiveContextRoot;
  const _ActiveContextRoot._() : super._();

  @override
  ContextRoot get contextRoot;
  @override

  /// Indicates the package that explicitly activates Sidecar as a plugin.
  bool get isExplicitlyEnabledRoot;
  @override
  @JsonKey(ignore: true)
  _$$_ActiveContextRootCopyWith<_$_ActiveContextRoot> get copyWith =>
      throw _privateConstructorUsedError;
}
