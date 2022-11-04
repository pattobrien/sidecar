// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'context_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ContextDetails _$ContextDetailsFromJson(Map<String, dynamic> json) {
  return _ContextPath.fromJson(json);
}

/// @nodoc
mixin _$ContextDetails {
  List<Uri> get includesPaths => throw _privateConstructorUsedError;
  List<Uri>? get excludesPaths => throw _privateConstructorUsedError;
  Uri? get optionsFile => throw _privateConstructorUsedError;
  Uri? get packagesFile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContextDetailsCopyWith<ContextDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContextDetailsCopyWith<$Res> {
  factory $ContextDetailsCopyWith(
          ContextDetails value, $Res Function(ContextDetails) then) =
      _$ContextDetailsCopyWithImpl<$Res>;
  $Res call(
      {List<Uri> includesPaths,
      List<Uri>? excludesPaths,
      Uri? optionsFile,
      Uri? packagesFile});
}

/// @nodoc
class _$ContextDetailsCopyWithImpl<$Res>
    implements $ContextDetailsCopyWith<$Res> {
  _$ContextDetailsCopyWithImpl(this._value, this._then);

  final ContextDetails _value;
  // ignore: unused_field
  final $Res Function(ContextDetails) _then;

  @override
  $Res call({
    Object? includesPaths = freezed,
    Object? excludesPaths = freezed,
    Object? optionsFile = freezed,
    Object? packagesFile = freezed,
  }) {
    return _then(_value.copyWith(
      includesPaths: includesPaths == freezed
          ? _value.includesPaths
          : includesPaths // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
      excludesPaths: excludesPaths == freezed
          ? _value.excludesPaths
          : excludesPaths // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
      optionsFile: optionsFile == freezed
          ? _value.optionsFile
          : optionsFile // ignore: cast_nullable_to_non_nullable
              as Uri?,
      packagesFile: packagesFile == freezed
          ? _value.packagesFile
          : packagesFile // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc
abstract class _$$_ContextPathCopyWith<$Res>
    implements $ContextDetailsCopyWith<$Res> {
  factory _$$_ContextPathCopyWith(
          _$_ContextPath value, $Res Function(_$_ContextPath) then) =
      __$$_ContextPathCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Uri> includesPaths,
      List<Uri>? excludesPaths,
      Uri? optionsFile,
      Uri? packagesFile});
}

/// @nodoc
class __$$_ContextPathCopyWithImpl<$Res>
    extends _$ContextDetailsCopyWithImpl<$Res>
    implements _$$_ContextPathCopyWith<$Res> {
  __$$_ContextPathCopyWithImpl(
      _$_ContextPath _value, $Res Function(_$_ContextPath) _then)
      : super(_value, (v) => _then(v as _$_ContextPath));

  @override
  _$_ContextPath get _value => super._value as _$_ContextPath;

  @override
  $Res call({
    Object? includesPaths = freezed,
    Object? excludesPaths = freezed,
    Object? optionsFile = freezed,
    Object? packagesFile = freezed,
  }) {
    return _then(_$_ContextPath(
      includesPaths: includesPaths == freezed
          ? _value._includesPaths
          : includesPaths // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
      excludesPaths: excludesPaths == freezed
          ? _value._excludesPaths
          : excludesPaths // ignore: cast_nullable_to_non_nullable
              as List<Uri>?,
      optionsFile: optionsFile == freezed
          ? _value.optionsFile
          : optionsFile // ignore: cast_nullable_to_non_nullable
              as Uri?,
      packagesFile: packagesFile == freezed
          ? _value.packagesFile
          : packagesFile // ignore: cast_nullable_to_non_nullable
              as Uri?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ContextPath extends _ContextPath {
  const _$_ContextPath(
      {required final List<Uri> includesPaths,
      final List<Uri>? excludesPaths,
      this.optionsFile,
      this.packagesFile})
      : _includesPaths = includesPaths,
        _excludesPaths = excludesPaths,
        super._();

  factory _$_ContextPath.fromJson(Map<String, dynamic> json) =>
      _$$_ContextPathFromJson(json);

  final List<Uri> _includesPaths;
  @override
  List<Uri> get includesPaths {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_includesPaths);
  }

  final List<Uri>? _excludesPaths;
  @override
  List<Uri>? get excludesPaths {
    final value = _excludesPaths;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Uri? optionsFile;
  @override
  final Uri? packagesFile;

  @override
  String toString() {
    return 'ContextDetails(includesPaths: $includesPaths, excludesPaths: $excludesPaths, optionsFile: $optionsFile, packagesFile: $packagesFile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ContextPath &&
            const DeepCollectionEquality()
                .equals(other._includesPaths, _includesPaths) &&
            const DeepCollectionEquality()
                .equals(other._excludesPaths, _excludesPaths) &&
            const DeepCollectionEquality()
                .equals(other.optionsFile, optionsFile) &&
            const DeepCollectionEquality()
                .equals(other.packagesFile, packagesFile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includesPaths),
      const DeepCollectionEquality().hash(_excludesPaths),
      const DeepCollectionEquality().hash(optionsFile),
      const DeepCollectionEquality().hash(packagesFile));

  @JsonKey(ignore: true)
  @override
  _$$_ContextPathCopyWith<_$_ContextPath> get copyWith =>
      __$$_ContextPathCopyWithImpl<_$_ContextPath>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ContextPathToJson(
      this,
    );
  }
}

abstract class _ContextPath extends ContextDetails {
  const factory _ContextPath(
      {required final List<Uri> includesPaths,
      final List<Uri>? excludesPaths,
      final Uri? optionsFile,
      final Uri? packagesFile}) = _$_ContextPath;
  const _ContextPath._() : super._();

  factory _ContextPath.fromJson(Map<String, dynamic> json) =
      _$_ContextPath.fromJson;

  @override
  List<Uri> get includesPaths;
  @override
  List<Uri>? get excludesPaths;
  @override
  Uri? get optionsFile;
  @override
  Uri? get packagesFile;
  @override
  @JsonKey(ignore: true)
  _$$_ContextPathCopyWith<_$_ContextPath> get copyWith =>
      throw _privateConstructorUsedError;
}
