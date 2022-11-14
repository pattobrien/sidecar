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
  ActivePackageRoot get packageRoot => throw _privateConstructorUsedError;
  ProjectConfiguration get sidecarOptionsFile =>
      throw _privateConstructorUsedError;
  Package get sidecarPluginPackage => throw _privateConstructorUsedError;
  PackageConfig? get packageConfig => throw _privateConstructorUsedError;
  List<Uri>? get workspaceScope => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivePackageCopyWith<ActivePackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivePackageCopyWith<$Res> {
  factory $ActivePackageCopyWith(
          ActivePackage value, $Res Function(ActivePackage) then) =
      _$ActivePackageCopyWithImpl<$Res>;
  $Res call(
      {ActivePackageRoot packageRoot,
      ProjectConfiguration sidecarOptionsFile,
      Package sidecarPluginPackage,
      PackageConfig? packageConfig,
      List<Uri>? workspaceScope});

  $ActivePackageRootCopyWith<$Res> get packageRoot;
}

/// @nodoc
class _$ActivePackageCopyWithImpl<$Res>
    implements $ActivePackageCopyWith<$Res> {
  _$ActivePackageCopyWithImpl(this._value, this._then);

  final ActivePackage _value;
  // ignore: unused_field
  final $Res Function(ActivePackage) _then;

  @override
  $Res call({
    Object? packageRoot = freezed,
    Object? sidecarOptionsFile = freezed,
    Object? sidecarPluginPackage = freezed,
    Object? packageConfig = freezed,
    Object? workspaceScope = freezed,
  }) {
    return _then(_value.copyWith(
      packageRoot: packageRoot == freezed
          ? _value.packageRoot
          : packageRoot // ignore: cast_nullable_to_non_nullable
              as ActivePackageRoot,
      sidecarOptionsFile: sidecarOptionsFile == freezed
          ? _value.sidecarOptionsFile
          : sidecarOptionsFile // ignore: cast_nullable_to_non_nullable
              as ProjectConfiguration,
      sidecarPluginPackage: sidecarPluginPackage == freezed
          ? _value.sidecarPluginPackage
          : sidecarPluginPackage // ignore: cast_nullable_to_non_nullable
              as Package,
      packageConfig: packageConfig == freezed
          ? _value.packageConfig
          : packageConfig // ignore: cast_nullable_to_non_nullable
              as PackageConfig?,
      workspaceScope: workspaceScope == freezed
          ? _value.workspaceScope
          : workspaceScope // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
    ));
  }

  @override
  $ActivePackageRootCopyWith<$Res> get packageRoot {
    return $ActivePackageRootCopyWith<$Res>(_value.packageRoot, (value) {
      return _then(_value.copyWith(packageRoot: value));
    });
  }
}

/// @nodoc
abstract class _$$_ActivePackageCopyWith<$Res>
    implements $ActivePackageCopyWith<$Res> {
  factory _$$_ActivePackageCopyWith(
          _$_ActivePackage value, $Res Function(_$_ActivePackage) then) =
      __$$_ActivePackageCopyWithImpl<$Res>;
  @override
  $Res call(
      {ActivePackageRoot packageRoot,
      ProjectConfiguration sidecarOptionsFile,
      Package sidecarPluginPackage,
      PackageConfig? packageConfig,
      List<Uri>? workspaceScope});

  @override
  $ActivePackageRootCopyWith<$Res> get packageRoot;
}

/// @nodoc
class __$$_ActivePackageCopyWithImpl<$Res>
    extends _$ActivePackageCopyWithImpl<$Res>
    implements _$$_ActivePackageCopyWith<$Res> {
  __$$_ActivePackageCopyWithImpl(
      _$_ActivePackage _value, $Res Function(_$_ActivePackage) _then)
      : super(_value, (v) => _then(v as _$_ActivePackage));

  @override
  _$_ActivePackage get _value => super._value as _$_ActivePackage;

  @override
  $Res call({
    Object? packageRoot = freezed,
    Object? sidecarOptionsFile = freezed,
    Object? sidecarPluginPackage = freezed,
    Object? packageConfig = freezed,
    Object? workspaceScope = freezed,
  }) {
    return _then(_$_ActivePackage(
      packageRoot: packageRoot == freezed
          ? _value.packageRoot
          : packageRoot // ignore: cast_nullable_to_non_nullable
              as ActivePackageRoot,
      sidecarOptionsFile: sidecarOptionsFile == freezed
          ? _value.sidecarOptionsFile
          : sidecarOptionsFile // ignore: cast_nullable_to_non_nullable
              as ProjectConfiguration,
      sidecarPluginPackage: sidecarPluginPackage == freezed
          ? _value.sidecarPluginPackage
          : sidecarPluginPackage // ignore: cast_nullable_to_non_nullable
              as Package,
      packageConfig: packageConfig == freezed
          ? _value.packageConfig
          : packageConfig // ignore: cast_nullable_to_non_nullable
              as PackageConfig?,
      workspaceScope: workspaceScope == freezed
          ? _value._workspaceScope
          : workspaceScope // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
    ));
  }
}

/// @nodoc

class _$_ActivePackage extends _ActivePackage {
  const _$_ActivePackage(
      {required this.packageRoot,
      required this.sidecarOptionsFile,
      required this.sidecarPluginPackage,
      this.packageConfig,
      final List<Uri>? workspaceScope})
      : _workspaceScope = workspaceScope,
        super._();

  @override
  final ActivePackageRoot packageRoot;
  @override
  final ProjectConfiguration sidecarOptionsFile;
  @override
  final Package sidecarPluginPackage;
  @override
  final PackageConfig? packageConfig;
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
    return 'ActivePackage(packageRoot: $packageRoot, sidecarOptionsFile: $sidecarOptionsFile, sidecarPluginPackage: $sidecarPluginPackage, packageConfig: $packageConfig, workspaceScope: $workspaceScope)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivePackage &&
            const DeepCollectionEquality()
                .equals(other.packageRoot, packageRoot) &&
            const DeepCollectionEquality()
                .equals(other.sidecarOptionsFile, sidecarOptionsFile) &&
            const DeepCollectionEquality()
                .equals(other.sidecarPluginPackage, sidecarPluginPackage) &&
            const DeepCollectionEquality()
                .equals(other.packageConfig, packageConfig) &&
            const DeepCollectionEquality()
                .equals(other._workspaceScope, _workspaceScope));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(packageRoot),
      const DeepCollectionEquality().hash(sidecarOptionsFile),
      const DeepCollectionEquality().hash(sidecarPluginPackage),
      const DeepCollectionEquality().hash(packageConfig),
      const DeepCollectionEquality().hash(_workspaceScope));

  @JsonKey(ignore: true)
  @override
  _$$_ActivePackageCopyWith<_$_ActivePackage> get copyWith =>
      __$$_ActivePackageCopyWithImpl<_$_ActivePackage>(this, _$identity);
}

abstract class _ActivePackage extends ActivePackage {
  const factory _ActivePackage(
      {required final ActivePackageRoot packageRoot,
      required final ProjectConfiguration sidecarOptionsFile,
      required final Package sidecarPluginPackage,
      final PackageConfig? packageConfig,
      final List<Uri>? workspaceScope}) = _$_ActivePackage;
  const _ActivePackage._() : super._();

  @override
  ActivePackageRoot get packageRoot;
  @override
  ProjectConfiguration get sidecarOptionsFile;
  @override
  Package get sidecarPluginPackage;
  @override
  PackageConfig? get packageConfig;
  @override
  List<Uri>? get workspaceScope;
  @override
  @JsonKey(ignore: true)
  _$$_ActivePackageCopyWith<_$_ActivePackage> get copyWith =>
      throw _privateConstructorUsedError;
}
