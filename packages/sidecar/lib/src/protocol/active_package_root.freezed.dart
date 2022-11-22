// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'active_package_root.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ActivePackageRoot _$ActivePackageRootFromJson(Map<String, dynamic> json) {
  return _ActivePackageRoot.fromJson(json);
}

/// @nodoc
mixin _$ActivePackageRoot {
  Uri get root => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivePackageRootCopyWith<ActivePackageRoot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivePackageRootCopyWith<$Res> {
  factory $ActivePackageRootCopyWith(
          ActivePackageRoot value, $Res Function(ActivePackageRoot) then) =
      _$ActivePackageRootCopyWithImpl<$Res>;
  $Res call({Uri root});
}

/// @nodoc
class _$ActivePackageRootCopyWithImpl<$Res>
    implements $ActivePackageRootCopyWith<$Res> {
  _$ActivePackageRootCopyWithImpl(this._value, this._then);

  final ActivePackageRoot _value;
  // ignore: unused_field
  final $Res Function(ActivePackageRoot) _then;

  @override
  $Res call({
    Object? root = freezed,
  }) {
    return _then(_value.copyWith(
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc
abstract class _$$_ActivePackageRootCopyWith<$Res>
    implements $ActivePackageRootCopyWith<$Res> {
  factory _$$_ActivePackageRootCopyWith(_$_ActivePackageRoot value,
          $Res Function(_$_ActivePackageRoot) then) =
      __$$_ActivePackageRootCopyWithImpl<$Res>;
  @override
  $Res call({Uri root});
}

/// @nodoc
class __$$_ActivePackageRootCopyWithImpl<$Res>
    extends _$ActivePackageRootCopyWithImpl<$Res>
    implements _$$_ActivePackageRootCopyWith<$Res> {
  __$$_ActivePackageRootCopyWithImpl(
      _$_ActivePackageRoot _value, $Res Function(_$_ActivePackageRoot) _then)
      : super(_value, (v) => _then(v as _$_ActivePackageRoot));

  @override
  _$_ActivePackageRoot get _value => super._value as _$_ActivePackageRoot;

  @override
  $Res call({
    Object? root = freezed,
  }) {
    return _then(_$_ActivePackageRoot(
      root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ActivePackageRoot extends _ActivePackageRoot {
  const _$_ActivePackageRoot(this.root) : super._();

  factory _$_ActivePackageRoot.fromJson(Map<String, dynamic> json) =>
      _$$_ActivePackageRootFromJson(json);

  @override
  final Uri root;

  @override
  String toString() {
    return 'ActivePackageRoot(root: $root)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivePackageRoot &&
            const DeepCollectionEquality().equals(other.root, root));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(root));

  @JsonKey(ignore: true)
  @override
  _$$_ActivePackageRootCopyWith<_$_ActivePackageRoot> get copyWith =>
      __$$_ActivePackageRootCopyWithImpl<_$_ActivePackageRoot>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ActivePackageRootToJson(
      this,
    );
  }
}

abstract class _ActivePackageRoot extends ActivePackageRoot {
  const factory _ActivePackageRoot(final Uri root) = _$_ActivePackageRoot;
  const _ActivePackageRoot._() : super._();

  factory _ActivePackageRoot.fromJson(Map<String, dynamic> json) =
      _$_ActivePackageRoot.fromJson;

  @override
  Uri get root;
  @override
  @JsonKey(ignore: true)
  _$$_ActivePackageRootCopyWith<_$_ActivePackageRoot> get copyWith =>
      throw _privateConstructorUsedError;
}
