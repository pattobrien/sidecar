// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'data_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DataResult<T> {
  RuleCode get code => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RuleCode code, Set<SingleDataResult<T>> data)
        total,
    required TResult Function(RuleCode code, T data) single,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(RuleCode code, Set<SingleDataResult<T>> data)? total,
    TResult Function(RuleCode code, T data)? single,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RuleCode code, Set<SingleDataResult<T>> data)? total,
    TResult Function(RuleCode code, T data)? single,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TotalData<T> value) total,
    required TResult Function(SingleDataResult<T> value) single,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TotalData<T> value)? total,
    TResult Function(SingleDataResult<T> value)? single,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TotalData<T> value)? total,
    TResult Function(SingleDataResult<T> value)? single,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DataResultCopyWith<T, DataResult<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataResultCopyWith<T, $Res> {
  factory $DataResultCopyWith(
          DataResult<T> value, $Res Function(DataResult<T>) then) =
      _$DataResultCopyWithImpl<T, $Res>;
  $Res call({RuleCode code});

  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class _$DataResultCopyWithImpl<T, $Res>
    implements $DataResultCopyWith<T, $Res> {
  _$DataResultCopyWithImpl(this._value, this._then);

  final DataResult<T> _value;
  // ignore: unused_field
  final $Res Function(DataResult<T>) _then;

  @override
  $Res call({
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
    ));
  }

  @override
  $RuleCodeCopyWith<$Res> get code {
    return $RuleCodeCopyWith<$Res>(_value.code, (value) {
      return _then(_value.copyWith(code: value));
    });
  }
}

/// @nodoc
abstract class _$$TotalDataCopyWith<T, $Res>
    implements $DataResultCopyWith<T, $Res> {
  factory _$$TotalDataCopyWith(
          _$TotalData<T> value, $Res Function(_$TotalData<T>) then) =
      __$$TotalDataCopyWithImpl<T, $Res>;
  @override
  $Res call({RuleCode code, Set<SingleDataResult<T>> data});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$TotalDataCopyWithImpl<T, $Res>
    extends _$DataResultCopyWithImpl<T, $Res>
    implements _$$TotalDataCopyWith<T, $Res> {
  __$$TotalDataCopyWithImpl(
      _$TotalData<T> _value, $Res Function(_$TotalData<T>) _then)
      : super(_value, (v) => _then(v as _$TotalData<T>));

  @override
  _$TotalData<T> get _value => super._value as _$TotalData<T>;

  @override
  $Res call({
    Object? code = freezed,
    Object? data = freezed,
  }) {
    return _then(_$TotalData<T>(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      data: data == freezed
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Set<SingleDataResult<T>>,
    ));
  }
}

/// @nodoc

class _$TotalData<T> extends TotalData<T> {
  const _$TotalData(
      {required this.code, required final Set<SingleDataResult<T>> data})
      : _data = data,
        super._();

  @override
  final RuleCode code;
  final Set<SingleDataResult<T>> _data;
  @override
  Set<SingleDataResult<T>> get data {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_data);
  }

  @override
  String toString() {
    return 'DataResult<$T>.total(code: $code, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TotalData<T> &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  _$$TotalDataCopyWith<T, _$TotalData<T>> get copyWith =>
      __$$TotalDataCopyWithImpl<T, _$TotalData<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RuleCode code, Set<SingleDataResult<T>> data)
        total,
    required TResult Function(RuleCode code, T data) single,
  }) {
    return total(code, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(RuleCode code, Set<SingleDataResult<T>> data)? total,
    TResult Function(RuleCode code, T data)? single,
  }) {
    return total?.call(code, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RuleCode code, Set<SingleDataResult<T>> data)? total,
    TResult Function(RuleCode code, T data)? single,
    required TResult orElse(),
  }) {
    if (total != null) {
      return total(code, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TotalData<T> value) total,
    required TResult Function(SingleDataResult<T> value) single,
  }) {
    return total(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TotalData<T> value)? total,
    TResult Function(SingleDataResult<T> value)? single,
  }) {
    return total?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TotalData<T> value)? total,
    TResult Function(SingleDataResult<T> value)? single,
    required TResult orElse(),
  }) {
    if (total != null) {
      return total(this);
    }
    return orElse();
  }
}

abstract class TotalData<T> extends DataResult<T> {
  const factory TotalData(
      {required final RuleCode code,
      required final Set<SingleDataResult<T>> data}) = _$TotalData<T>;
  const TotalData._() : super._();

  @override
  RuleCode get code;
  Set<SingleDataResult<T>> get data;
  @override
  @JsonKey(ignore: true)
  _$$TotalDataCopyWith<T, _$TotalData<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SingleDataResultCopyWith<T, $Res>
    implements $DataResultCopyWith<T, $Res> {
  factory _$$SingleDataResultCopyWith(_$SingleDataResult<T> value,
          $Res Function(_$SingleDataResult<T>) then) =
      __$$SingleDataResultCopyWithImpl<T, $Res>;
  @override
  $Res call({RuleCode code, T data});

  @override
  $RuleCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$$SingleDataResultCopyWithImpl<T, $Res>
    extends _$DataResultCopyWithImpl<T, $Res>
    implements _$$SingleDataResultCopyWith<T, $Res> {
  __$$SingleDataResultCopyWithImpl(
      _$SingleDataResult<T> _value, $Res Function(_$SingleDataResult<T>) _then)
      : super(_value, (v) => _then(v as _$SingleDataResult<T>));

  @override
  _$SingleDataResult<T> get _value => super._value as _$SingleDataResult<T>;

  @override
  $Res call({
    Object? code = freezed,
    Object? data = freezed,
  }) {
    return _then(_$SingleDataResult<T>(
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as RuleCode,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SingleDataResult<T> extends SingleDataResult<T> {
  const _$SingleDataResult({required this.code, required this.data})
      : super._();

  @override
  final RuleCode code;
  @override
  final T data;

  @override
  String toString() {
    return 'DataResult<$T>.single(code: $code, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SingleDataResult<T> &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$$SingleDataResultCopyWith<T, _$SingleDataResult<T>> get copyWith =>
      __$$SingleDataResultCopyWithImpl<T, _$SingleDataResult<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(RuleCode code, Set<SingleDataResult<T>> data)
        total,
    required TResult Function(RuleCode code, T data) single,
  }) {
    return single(code, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(RuleCode code, Set<SingleDataResult<T>> data)? total,
    TResult Function(RuleCode code, T data)? single,
  }) {
    return single?.call(code, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(RuleCode code, Set<SingleDataResult<T>> data)? total,
    TResult Function(RuleCode code, T data)? single,
    required TResult orElse(),
  }) {
    if (single != null) {
      return single(code, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TotalData<T> value) total,
    required TResult Function(SingleDataResult<T> value) single,
  }) {
    return single(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TotalData<T> value)? total,
    TResult Function(SingleDataResult<T> value)? single,
  }) {
    return single?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TotalData<T> value)? total,
    TResult Function(SingleDataResult<T> value)? single,
    required TResult orElse(),
  }) {
    if (single != null) {
      return single(this);
    }
    return orElse();
  }
}

abstract class SingleDataResult<T> extends DataResult<T> {
  const factory SingleDataResult(
      {required final RuleCode code,
      required final T data}) = _$SingleDataResult<T>;
  const SingleDataResult._() : super._();

  @override
  RuleCode get code;
  T get data;
  @override
  @JsonKey(ignore: true)
  _$$SingleDataResultCopyWith<T, _$SingleDataResult<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
