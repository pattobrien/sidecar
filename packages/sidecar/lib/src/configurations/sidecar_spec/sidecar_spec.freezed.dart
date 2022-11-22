// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sidecar_spec.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SidecarSpec _$SidecarSpecFromJson(Map<String, dynamic> json) {
  return _SidecarSpec.fromJson(json);
}

/// @nodoc
mixin _$SidecarSpec {
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes => throw _privateConstructorUsedError;
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes => throw _privateConstructorUsedError;
  Map<String, PackageOptions>? get lints => throw _privateConstructorUsedError;
  Map<String, PackageOptions>? get assists =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SidecarSpecCopyWith<SidecarSpec> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarSpecCopyWith<$Res> {
  factory $SidecarSpecCopyWith(
          SidecarSpec value, $Res Function(SidecarSpec) then) =
      _$SidecarSpecCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      Map<String, PackageOptions>? lints,
      Map<String, PackageOptions>? assists});
}

/// @nodoc
class _$SidecarSpecCopyWithImpl<$Res> implements $SidecarSpecCopyWith<$Res> {
  _$SidecarSpecCopyWithImpl(this._value, this._then);

  final SidecarSpec _value;
  // ignore: unused_field
  final $Res Function(SidecarSpec) _then;

  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? lints = freezed,
    Object? assists = freezed,
  }) {
    return _then(_value.copyWith(
      includes: includes == freezed
          ? _value.includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: excludes == freezed
          ? _value.excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      lints: lints == freezed
          ? _value.lints
          : lints // ignore: cast_nullable_to_non_nullable
              as Map<String, PackageOptions>?,
      assists: assists == freezed
          ? _value.assists
          : assists // ignore: cast_nullable_to_non_nullable
              as Map<String, PackageOptions>?,
    ));
  }
}

/// @nodoc
abstract class _$$_SidecarSpecCopyWith<$Res>
    implements $SidecarSpecCopyWith<$Res> {
  factory _$$_SidecarSpecCopyWith(
          _$_SidecarSpec value, $Res Function(_$_SidecarSpec) then) =
      __$$_SidecarSpecCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          List<Glob>? excludes,
      Map<String, PackageOptions>? lints,
      Map<String, PackageOptions>? assists});
}

/// @nodoc
class __$$_SidecarSpecCopyWithImpl<$Res> extends _$SidecarSpecCopyWithImpl<$Res>
    implements _$$_SidecarSpecCopyWith<$Res> {
  __$$_SidecarSpecCopyWithImpl(
      _$_SidecarSpec _value, $Res Function(_$_SidecarSpec) _then)
      : super(_value, (v) => _then(v as _$_SidecarSpec));

  @override
  _$_SidecarSpec get _value => super._value as _$_SidecarSpec;

  @override
  $Res call({
    Object? includes = freezed,
    Object? excludes = freezed,
    Object? lints = freezed,
    Object? assists = freezed,
  }) {
    return _then(_$_SidecarSpec(
      includes: includes == freezed
          ? _value._includes
          : includes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      excludes: excludes == freezed
          ? _value._excludes
          : excludes // ignore: cast_nullable_to_non_nullable
              as List<Glob>?,
      lints: lints == freezed
          ? _value._lints
          : lints // ignore: cast_nullable_to_non_nullable
              as Map<String, PackageOptions>?,
      assists: assists == freezed
          ? _value._assists
          : assists // ignore: cast_nullable_to_non_nullable
              as Map<String, PackageOptions>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SidecarSpec extends _SidecarSpec {
  const _$_SidecarSpec(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final Map<String, PackageOptions>? lints,
      final Map<String, PackageOptions>? assists})
      : _includes = includes,
        _excludes = excludes,
        _lints = lints,
        _assists = assists,
        super._();

  factory _$_SidecarSpec.fromJson(Map<String, dynamic> json) =>
      _$$_SidecarSpecFromJson(json);

  final List<Glob>? _includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes {
    final value = _includes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Glob>? _excludes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes {
    final value = _excludes;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, PackageOptions>? _lints;
  @override
  Map<String, PackageOptions>? get lints {
    final value = _lints;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, PackageOptions>? _assists;
  @override
  Map<String, PackageOptions>? get assists {
    final value = _assists;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SidecarSpec(includes: $includes, excludes: $excludes, lints: $lints, assists: $assists)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SidecarSpec &&
            const DeepCollectionEquality().equals(other._includes, _includes) &&
            const DeepCollectionEquality().equals(other._excludes, _excludes) &&
            const DeepCollectionEquality().equals(other._lints, _lints) &&
            const DeepCollectionEquality().equals(other._assists, _assists));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_includes),
      const DeepCollectionEquality().hash(_excludes),
      const DeepCollectionEquality().hash(_lints),
      const DeepCollectionEquality().hash(_assists));

  @JsonKey(ignore: true)
  @override
  _$$_SidecarSpecCopyWith<_$_SidecarSpec> get copyWith =>
      __$$_SidecarSpecCopyWithImpl<_$_SidecarSpec>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SidecarSpecToJson(
      this,
    );
  }
}

abstract class _SidecarSpec extends SidecarSpec {
  const factory _SidecarSpec(
      {@JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? includes,
      @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
          final List<Glob>? excludes,
      final Map<String, PackageOptions>? lints,
      final Map<String, PackageOptions>? assists}) = _$_SidecarSpec;
  const _SidecarSpec._() : super._();

  factory _SidecarSpec.fromJson(Map<String, dynamic> json) =
      _$_SidecarSpec.fromJson;

  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get includes;
  @override
  @JsonKey(toJson: globsToStrings, fromJson: globsFromStrings)
  List<Glob>? get excludes;
  @override
  Map<String, PackageOptions>? get lints;
  @override
  Map<String, PackageOptions>? get assists;
  @override
  @JsonKey(ignore: true)
  _$$_SidecarSpecCopyWith<_$_SidecarSpec> get copyWith =>
      throw _privateConstructorUsedError;
}
