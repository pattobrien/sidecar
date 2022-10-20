// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyConfiguration _$MyConfigurationFromJson(Map<String, dynamic> json) {
  return _MyConfiguration.fromJson(json);
}

/// @nodoc
mixin _$MyConfiguration {
  String get field => throw _privateConstructorUsedError;
  bool get field2 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyConfigurationCopyWith<MyConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyConfigurationCopyWith<$Res> {
  factory $MyConfigurationCopyWith(
          MyConfiguration value, $Res Function(MyConfiguration) then) =
      _$MyConfigurationCopyWithImpl<$Res, MyConfiguration>;
  @useResult
  $Res call({String field, bool field2});
}

/// @nodoc
class _$MyConfigurationCopyWithImpl<$Res, $Val extends MyConfiguration>
    implements $MyConfigurationCopyWith<$Res> {
  _$MyConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? field2 = null,
  }) {
    return _then(_value.copyWith(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      field2: null == field2
          ? _value.field2
          : field2 // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MyConfigurationCopyWith<$Res>
    implements $MyConfigurationCopyWith<$Res> {
  factory _$$_MyConfigurationCopyWith(
          _$_MyConfiguration value, $Res Function(_$_MyConfiguration) then) =
      __$$_MyConfigurationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String field, bool field2});
}

/// @nodoc
class __$$_MyConfigurationCopyWithImpl<$Res>
    extends _$MyConfigurationCopyWithImpl<$Res, _$_MyConfiguration>
    implements _$$_MyConfigurationCopyWith<$Res> {
  __$$_MyConfigurationCopyWithImpl(
      _$_MyConfiguration _value, $Res Function(_$_MyConfiguration) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
    Object? field2 = null,
  }) {
    return _then(_$_MyConfiguration(
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as String,
      field2: null == field2
          ? _value.field2
          : field2 // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyConfiguration extends _MyConfiguration {
  const _$_MyConfiguration({required this.field, required this.field2})
      : super._();

  factory _$_MyConfiguration.fromJson(Map<String, dynamic> json) =>
      _$$_MyConfigurationFromJson(json);

  @override
  final String field;
  @override
  final bool field2;

  @override
  String toString() {
    return 'MyConfiguration(field: $field, field2: $field2)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyConfiguration &&
            (identical(other.field, field) || other.field == field) &&
            (identical(other.field2, field2) || other.field2 == field2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, field, field2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MyConfigurationCopyWith<_$_MyConfiguration> get copyWith =>
      __$$_MyConfigurationCopyWithImpl<_$_MyConfiguration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyConfigurationToJson(
      this,
    );
  }
}

abstract class _MyConfiguration extends MyConfiguration {
  const factory _MyConfiguration(
      {required final String field,
      required final bool field2}) = _$_MyConfiguration;
  const _MyConfiguration._() : super._();

  factory _MyConfiguration.fromJson(Map<String, dynamic> json) =
      _$_MyConfiguration.fromJson;

  @override
  String get field;
  @override
  bool get field2;
  @override
  @JsonKey(ignore: true)
  _$$_MyConfigurationCopyWith<_$_MyConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}
