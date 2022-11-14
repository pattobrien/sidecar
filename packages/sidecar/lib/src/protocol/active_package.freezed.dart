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

ActivePackage _$ActivePackageFromJson(Map<String, dynamic> json) {
  return _ActivePackage.fromJson(json);
}

/// @nodoc
mixin _$ActivePackage {
  Uri get root => throw _privateConstructorUsedError;
  Uri get sidecarOptionsFile => throw _privateConstructorUsedError;
  Uri get sidecarPluginPackage => throw _privateConstructorUsedError;
  List<Uri> get sidecarPackages => throw _privateConstructorUsedError;
  List<Uri> get dependencies => throw _privateConstructorUsedError;
  List<Uri>? get workspaceScope => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
      {Uri root,
      Uri sidecarOptionsFile,
      Uri sidecarPluginPackage,
      List<Uri> sidecarPackages,
      List<Uri> dependencies,
      List<Uri>? workspaceScope});
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
    Object? root = freezed,
    Object? sidecarOptionsFile = freezed,
    Object? sidecarPluginPackage = freezed,
    Object? sidecarPackages = freezed,
    Object? dependencies = freezed,
    Object? workspaceScope = freezed,
  }) {
    return _then(_value.copyWith(
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
      sidecarOptionsFile: sidecarOptionsFile == freezed
          ? _value.sidecarOptionsFile
          : sidecarOptionsFile // ignore: cast_nullable_to_non_nullable
              as Uri,
      sidecarPluginPackage: sidecarPluginPackage == freezed
          ? _value.sidecarPluginPackage
          : sidecarPluginPackage // ignore: cast_nullable_to_non_nullable
              as Uri,
      sidecarPackages: sidecarPackages == freezed
          ? _value.sidecarPackages
          : sidecarPackages // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
      dependencies: dependencies == freezed
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
      workspaceScope: workspaceScope == freezed
          ? _value.workspaceScope
          : workspaceScope // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
    ));
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
      {Uri root,
      Uri sidecarOptionsFile,
      Uri sidecarPluginPackage,
      List<Uri> sidecarPackages,
      List<Uri> dependencies,
      List<Uri>? workspaceScope});
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
    Object? root = freezed,
    Object? sidecarOptionsFile = freezed,
    Object? sidecarPluginPackage = freezed,
    Object? sidecarPackages = freezed,
    Object? dependencies = freezed,
    Object? workspaceScope = freezed,
  }) {
    return _then(_$_ActivePackage(
      root: root == freezed
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as Uri,
      sidecarOptionsFile: sidecarOptionsFile == freezed
          ? _value.sidecarOptionsFile
          : sidecarOptionsFile // ignore: cast_nullable_to_non_nullable
              as Uri,
      sidecarPluginPackage: sidecarPluginPackage == freezed
          ? _value.sidecarPluginPackage
          : sidecarPluginPackage // ignore: cast_nullable_to_non_nullable
              as Uri,
      sidecarPackages: sidecarPackages == freezed
          ? _value._sidecarPackages
          : sidecarPackages // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
      dependencies: dependencies == freezed
          ? _value._dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
      workspaceScope: workspaceScope == freezed
          ? _value._workspaceScope
          : workspaceScope // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ActivePackage extends _ActivePackage {
  const _$_ActivePackage(
      {required this.root,
      required this.sidecarOptionsFile,
      required this.sidecarPluginPackage,
      required final List<Uri> sidecarPackages,
      required final List<Uri> dependencies,
      final List<Uri>? workspaceScope})
      : _sidecarPackages = sidecarPackages,
        _dependencies = dependencies,
        _workspaceScope = workspaceScope,
        super._();

  factory _$_ActivePackage.fromJson(Map<String, dynamic> json) =>
      _$$_ActivePackageFromJson(json);

  @override
  final Uri root;
  @override
  final Uri sidecarOptionsFile;
  @override
  final Uri sidecarPluginPackage;
  final List<Uri> _sidecarPackages;
  @override
  List<Uri> get sidecarPackages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sidecarPackages);
  }

  final List<Uri> _dependencies;
  @override
  List<Uri> get dependencies {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dependencies);
  }

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
    return 'ActivePackage(root: $root, sidecarOptionsFile: $sidecarOptionsFile, sidecarPluginPackage: $sidecarPluginPackage, sidecarPackages: $sidecarPackages, dependencies: $dependencies, workspaceScope: $workspaceScope)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivePackage &&
            const DeepCollectionEquality().equals(other.root, root) &&
            const DeepCollectionEquality()
                .equals(other.sidecarOptionsFile, sidecarOptionsFile) &&
            const DeepCollectionEquality()
                .equals(other.sidecarPluginPackage, sidecarPluginPackage) &&
            const DeepCollectionEquality()
                .equals(other._sidecarPackages, _sidecarPackages) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies) &&
            const DeepCollectionEquality()
                .equals(other._workspaceScope, _workspaceScope));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(root),
      const DeepCollectionEquality().hash(sidecarOptionsFile),
      const DeepCollectionEquality().hash(sidecarPluginPackage),
      const DeepCollectionEquality().hash(_sidecarPackages),
      const DeepCollectionEquality().hash(_dependencies),
      const DeepCollectionEquality().hash(_workspaceScope));

  @JsonKey(ignore: true)
  @override
  _$$_ActivePackageCopyWith<_$_ActivePackage> get copyWith =>
      __$$_ActivePackageCopyWithImpl<_$_ActivePackage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ActivePackageToJson(
      this,
    );
  }
}

abstract class _ActivePackage extends ActivePackage {
  const factory _ActivePackage(
      {required final Uri root,
      required final Uri sidecarOptionsFile,
      required final Uri sidecarPluginPackage,
      required final List<Uri> sidecarPackages,
      required final List<Uri> dependencies,
      final List<Uri>? workspaceScope}) = _$_ActivePackage;
  const _ActivePackage._() : super._();

  factory _ActivePackage.fromJson(Map<String, dynamic> json) =
      _$_ActivePackage.fromJson;

  @override
  Uri get root;
  @override
  Uri get sidecarOptionsFile;
  @override
  Uri get sidecarPluginPackage;
  @override
  List<Uri> get sidecarPackages;
  @override
  List<Uri> get dependencies;
  @override
  List<Uri>? get workspaceScope;
  @override
  @JsonKey(ignore: true)
  _$$_ActivePackageCopyWith<_$_ActivePackage> get copyWith =>
      throw _privateConstructorUsedError;
}
