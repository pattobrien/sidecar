// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'active_package.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ActivePackage {
  Uri get root => throw _privateConstructorUsedError;
  PackageConfig get packageConfig => throw _privateConstructorUsedError;
  List<Uri>? get workspaceScope => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivePackageCopyWith<ActivePackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivePackageCopyWith<$Res> {
  factory $ActivePackageCopyWith(
          ActivePackage value, $Res Function(ActivePackage) then) =
      _$ActivePackageCopyWithImpl<$Res, ActivePackage>;
  @useResult
  $Res call({Uri root, PackageConfig packageConfig, List<Uri>? workspaceScope});
}

/// @nodoc
class _$ActivePackageCopyWithImpl<$Res, $Val extends ActivePackage>
    implements $ActivePackageCopyWith<$Res> {
  _$ActivePackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? root = null,
    Object? packageConfig = null,
    Object? workspaceScope = freezed,
  }) {
    return _then(_value.copyWith(
      root: null == root
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
      packageConfig: null == packageConfig
          ? _value.packageConfig
          : packageConfig // ignore: cast_nullable_to_non_nullable
              as PackageConfig,
      workspaceScope: freezed == workspaceScope
          ? _value.workspaceScope
          : workspaceScope // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivePackageCopyWith<$Res>
    implements $ActivePackageCopyWith<$Res> {
  factory _$$_ActivePackageCopyWith(
          _$_ActivePackage value, $Res Function(_$_ActivePackage) then) =
      __$$_ActivePackageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uri root, PackageConfig packageConfig, List<Uri>? workspaceScope});
}

/// @nodoc
class __$$_ActivePackageCopyWithImpl<$Res>
    extends _$ActivePackageCopyWithImpl<$Res, _$_ActivePackage>
    implements _$$_ActivePackageCopyWith<$Res> {
  __$$_ActivePackageCopyWithImpl(
      _$_ActivePackage _value, $Res Function(_$_ActivePackage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? root = null,
    Object? packageConfig = null,
    Object? workspaceScope = freezed,
  }) {
    return _then(_$_ActivePackage(
      root: null == root
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
      packageConfig: null == packageConfig
          ? _value.packageConfig
          : packageConfig // ignore: cast_nullable_to_non_nullable
              as PackageConfig,
      workspaceScope: freezed == workspaceScope
          ? _value._workspaceScope
          : workspaceScope // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
    ));
  }
}

/// @nodoc

class _$_ActivePackage extends _ActivePackage {
  const _$_ActivePackage(
      {required this.root,
      required this.packageConfig,
      final List<Uri>? workspaceScope})
      : _workspaceScope = workspaceScope,
        super._();

  @override
  final Uri root;
  @override
  final PackageConfig packageConfig;
  final List<Uri>? _workspaceScope;
  @override
  List<Uri>? get workspaceScope {
    final value = _workspaceScope;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ActivePackage(root: $root, packageConfig: $packageConfig, workspaceScope: $workspaceScope)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivePackage &&
            (identical(other.root, root) || other.root == root) &&
            (identical(other.packageConfig, packageConfig) ||
                other.packageConfig == packageConfig) &&
            const DeepCollectionEquality()
                .equals(other._workspaceScope, _workspaceScope));
  }

  @override
  int get hashCode => Object.hash(runtimeType, root, packageConfig,
      const DeepCollectionEquality().hash(_workspaceScope));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivePackageCopyWith<_$_ActivePackage> get copyWith =>
      __$$_ActivePackageCopyWithImpl<_$_ActivePackage>(this, _$identity);
}

abstract class _ActivePackage extends ActivePackage {
  const factory _ActivePackage(
      {required final Uri root,
      required final PackageConfig packageConfig,
      final List<Uri>? workspaceScope}) = _$_ActivePackage;
  const _ActivePackage._() : super._();

  @override
  Uri get root;
  @override
  PackageConfig get packageConfig;
  @override
  List<Uri>? get workspaceScope;
  @override
  @JsonKey(ignore: true)
  _$$_ActivePackageCopyWith<_$_ActivePackage> get copyWith =>
      throw _privateConstructorUsedError;
}
