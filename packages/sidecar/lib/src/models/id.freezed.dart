// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Id {
  IdType get type => throw _privateConstructorUsedError;
  String get packageId => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IdCopyWith<Id> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdCopyWith<$Res> {
  factory $IdCopyWith(Id value, $Res Function(Id) then) =
      _$IdCopyWithImpl<$Res>;
  $Res call({IdType type, String packageId, String id});
}

/// @nodoc
class _$IdCopyWithImpl<$Res> implements $IdCopyWith<$Res> {
  _$IdCopyWithImpl(this._value, this._then);

  final Id _value;
  // ignore: unused_field
  final $Res Function(Id) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? packageId = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IdType,
      packageId: packageId == freezed
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_IdCopyWith<$Res> implements $IdCopyWith<$Res> {
  factory _$$_IdCopyWith(_$_Id value, $Res Function(_$_Id) then) =
      __$$_IdCopyWithImpl<$Res>;
  @override
  $Res call({IdType type, String packageId, String id});
}

/// @nodoc
class __$$_IdCopyWithImpl<$Res> extends _$IdCopyWithImpl<$Res>
    implements _$$_IdCopyWith<$Res> {
  __$$_IdCopyWithImpl(_$_Id _value, $Res Function(_$_Id) _then)
      : super(_value, (v) => _then(v as _$_Id));

  @override
  _$_Id get _value => super._value as _$_Id;

  @override
  $Res call({
    Object? type = freezed,
    Object? packageId = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_Id(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as IdType,
      packageId: packageId == freezed
          ? _value.packageId
          : packageId // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Id extends _Id {
  const _$_Id({required this.type, required this.packageId, required this.id})
      : super._();

  @override
  final IdType type;
  @override
  final String packageId;
  @override
  final String id;

  @override
  String toString() {
    return 'Id(type: $type, packageId: $packageId, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Id &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.packageId, packageId) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(packageId),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$$_IdCopyWith<_$_Id> get copyWith =>
      __$$_IdCopyWithImpl<_$_Id>(this, _$identity);
}

abstract class _Id extends Id {
  const factory _Id(
      {required final IdType type,
      required final String packageId,
      required final String id}) = _$_Id;
  const _Id._() : super._();

  @override
  IdType get type;
  @override
  String get packageId;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$_IdCopyWith<_$_Id> get copyWith => throw _privateConstructorUsedError;
}
