// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sidecar_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SidecarType {
  String get typeName => throw _privateConstructorUsedError;
  String get packageName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SidecarTypeCopyWith<SidecarType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SidecarTypeCopyWith<$Res> {
  factory $SidecarTypeCopyWith(
          SidecarType value, $Res Function(SidecarType) then) =
      _$SidecarTypeCopyWithImpl<$Res>;
  $Res call({String typeName, String packageName});
}

/// @nodoc
class _$SidecarTypeCopyWithImpl<$Res> implements $SidecarTypeCopyWith<$Res> {
  _$SidecarTypeCopyWithImpl(this._value, this._then);

  final SidecarType _value;
  // ignore: unused_field
  final $Res Function(SidecarType) _then;

  @override
  $Res call({
    Object? typeName = freezed,
    Object? packageName = freezed,
  }) {
    return _then(_value.copyWith(
      typeName: typeName == freezed
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SidecarTypeCopyWith<$Res>
    implements $SidecarTypeCopyWith<$Res> {
  factory _$$_SidecarTypeCopyWith(
          _$_SidecarType value, $Res Function(_$_SidecarType) then) =
      __$$_SidecarTypeCopyWithImpl<$Res>;
  @override
  $Res call({String typeName, String packageName});
}

/// @nodoc
class __$$_SidecarTypeCopyWithImpl<$Res> extends _$SidecarTypeCopyWithImpl<$Res>
    implements _$$_SidecarTypeCopyWith<$Res> {
  __$$_SidecarTypeCopyWithImpl(
      _$_SidecarType _value, $Res Function(_$_SidecarType) _then)
      : super(_value, (v) => _then(v as _$_SidecarType));

  @override
  _$_SidecarType get _value => super._value as _$_SidecarType;

  @override
  $Res call({
    Object? typeName = freezed,
    Object? packageName = freezed,
  }) {
    return _then(_$_SidecarType(
      typeName: typeName == freezed
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SidecarType extends _SidecarType {
  const _$_SidecarType({required this.typeName, required this.packageName})
      : super._();

  @override
  final String typeName;
  @override
  final String packageName;

  @override
  String toString() {
    return 'SidecarType(typeName: $typeName, packageName: $packageName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SidecarType &&
            const DeepCollectionEquality().equals(other.typeName, typeName) &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(typeName),
      const DeepCollectionEquality().hash(packageName));

  @JsonKey(ignore: true)
  @override
  _$$_SidecarTypeCopyWith<_$_SidecarType> get copyWith =>
      __$$_SidecarTypeCopyWithImpl<_$_SidecarType>(this, _$identity);
}

abstract class _SidecarType extends SidecarType {
  const factory _SidecarType(
      {required final String typeName,
      required final String packageName}) = _$_SidecarType;
  const _SidecarType._() : super._();

  @override
  String get typeName;
  @override
  String get packageName;
  @override
  @JsonKey(ignore: true)
  _$$_SidecarTypeCopyWith<_$_SidecarType> get copyWith =>
      throw _privateConstructorUsedError;
}
